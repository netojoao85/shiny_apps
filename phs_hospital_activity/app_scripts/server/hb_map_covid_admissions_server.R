



output$hb_map <- renderLeaflet({
  
leaflet(
    width = "80%", 
    height = "400px",
    data = phs_hb_data,
    options = leafletOptions(zoomControl = FALSE, minZoom = 5.5, maxZoom = 5.5)) %>%
    addPolygons(data = phs_hb_data,
                color = "black",
                fillColor = "lightgrey",
                weight = 1,
                opacity = 1,
                fillOpacity = 1, 
    highlightOptions = highlightOptions(
      fillColor = "grey",
      weight = 1,
      bringToFront = TRUE),
    # label = sprintf("<strong>%s</strong><br><img src='%s' width='100px' height='100px'>"),
      label = phs_hb_data$hb_name) %>% 
    # popup = bsicons::bs_icon("pin"),
    # labelOptions = labelOptions(clickable = TRUE, permanent = TRUE, 
    #                             noHide = FALSE, 
    #                             textOnly = FALSE,
    #                             style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center")) ) %>% 
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
    leaflet.extras::setMapWidgetStyle(style = list(background = "transparent")) %>% 
    htmlwidgets::onRender("
                function(el, x) {
                    var map = this;
                    map.dragging.disable();
                }
            ")
})

observeEvent(input$hb_selection, {
  
  selected_region(input$hb_selection)
  leafletProxy("hb_map") %>%
    addPolygons(
      data = phs_hb_data[phs_hb_data$hb_name == selected_region(), ],
      layerId = "",
      fillColor = "var(--phs-blue)",
      color = "var(--phs-purple)",
      opacity = 1,
      fillOpacity = 1,
      weight = 1
      # label = selected_region()
    )
})




# Heat map ----------------------------------------------------------------


output$hb_heat_map <- renderLeaflet({
  
  summary_admissions <- covid_admissions %>% 
    filter(specialty == "All") %>% 
    group_by(hb_name) %>% 
    summarise(n_admissions = sum(number_admissions))
  
  data <- left_join(x = phs_hb_data, y = summary_admissions, by = "hb_name")
  
  
  # n_breaks <-  6  # Number of breaks you want
  # breaks <- ceiling(seq(min(data$n_admissions), max(data$n_admissions), length.out = n_breaks))
  # labels <- c(paste(breaks[-n_breaks] + 1, breaks[-1], sep = " - "), paste(" > ", breaks[n_breaks]))
  # 
  # # Create color palette and corresponding colors
  # colors <- pal(breaks)
  
  
  
  # Calculate breaks
  n_breaks <- 6
  # breaks <- quantile(data$n_admissions, probs = seq(0, 1, by = 1/n_breaks))
  breaks <- ceiling(seq(min(data$n_admissions), max(data$n_admissions), length.out = n_breaks))
  labels <- c(paste0(round(breaks[-n_breaks] +1 , 0), " - ", round(breaks[-1], 0)), paste0("> ", round(breaks[n_breaks], 0)))
  
  
  
  my_pal <- c("Purples", "BuPu", "Blues", "OrRD", "GnBu")
  
  # Create color palette and corresponding colors
  pal <- colorQuantile(
    
    palette = c("red", "blue", "green", "pink", "purple", "yellow"),
    # my_pal[5],
    # "Blues",
    # "OrRd",
    # viridisLite::viridis(12),
    domain = data$n_admissions,
    n = n_breaks)
  
  # Build map
  leaflet(data = data) %>% 
    addPolygons(
      color = "black",
      fillColor = ~pal(n_admissions),
      layerId = ~hb_name, 
      weight = 1,
      opacity = 1,
      fillOpacity = 0.9
    ) %>% 
    setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
    leaflet.extras::setMapWidgetStyle(style = list(background = "transparent")) %>% 
    addLegend(
      "bottomright", 
      title = "Number of Admissions",
      colors = pal(breaks),
      labels = labels,
      opacity = 0.9
    )
  
})

