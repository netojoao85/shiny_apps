
#//////////////////////////////////////////////////////////////////////////
# CONDITIONS --------------------------------------------------------------
#//////////////////////////////////////////////////////////////////////////

#If some district was selected, the GIS radio-button option is disable
observe({
  if (!is.null(selected_region())) {
    shinyjs::disable(selector = "input[type=radio][value='GIS']")
    updateRadioButtons(session, "in_volume", selected = "Bar Chart")
  } else {
    shinyjs::enable(selector = "input[type=radio][value='GIS']")
  }
})


# Show different plots depending the radio-buttons selection
output$dynamic_plot <- renderUI({
  if (input$in_volume == "Bar Chart") {
    plotlyOutput("plot_local", height = "450px")
  } else {
    leafletOutput("map", height = "450px")
  }
})

#//////////////////////////////////////////////////////////////////////////
# VISUALISATIONS ----------------------------------------------------------
#//////////////////////////////////////////////////////////////////////////

## Local Plot --------------------------------------------------------------

output$plot_local <- renderPlotly({
  
  if (!is.null(selected_region())) {
    data_local <- filtered_data() %>%
      filter(district == selected_region()) %>% 
      count(municipality, sort = FALSE) %>% 
      rename(local = municipality) %>% 
      arrange(n)
  } else {
    data_local <- filtered_data() %>% 
      count(district, sort = FALSE) %>% 
      rename(local = district) %>% 
      arrange(n)
  }
  
  
  data_local <- data_local %>%
    mutate(text_color = if_else(local == local[nrow(data_local)], "white", "black")) %>% 
    mutate(text_position = if_else(local == local[nrow(data_local)], "inside", "outside"))
  
  
  plot_local <- plot_ly(
    data = data_local, 
    x = ~n, 
    y = ~local, 
    color = ~n, 
    colors = "Greens",
    text = ~n,
    textfont = list(color = ~text_color),
    textposition = ~text_position,
    name = " ") %>% 
    hide_colorbar()
  
  plot_local <- plot_local %>% 
    config(displayModeBar = FALSE) %>% 
    layout(
      showscale = FALSE,
      showlegend = FALSE,
      yaxis = list(
        title = "", showgrid = FALSE, showticklabels = TRUE,
        categoryorder = "array",  # Ensure categories are ordered as they appear in data
        categoryarray = ~local        # Use the order of locations as specified in the data
      ),
      xaxis = list(title = "", showgrid = FALSE, showticklabels = FALSE), 
      autosize = TRUE,
      margin = list(
        l = 0,  # Left margin
        r = 0,  # Right margin
        b = 0, # Bottom margin
        t = 0   # Top margin
      )
    )
  
  plot_local
  
})



## Type Plot ---------------------------------------------------------------

output$plot_type <- renderPlotly ({
  
  if (!is.null(selected_region())) {
    data_type <- filtered_data() %>% 
      filter(district == selected_region()) %>%
      count(type, sort = TRUE) 
    
  } else {
    data_type <- filtered_data() %>% 
      count(type, sort = TRUE)
  }
  
  plot_type <- plot_ly(
    data = data_type, 
    x = ~type, 
    y = ~n, 
    color = ~n, 
    colors = "Greens",
    text = ~n,
    textfont = list(color = 'black'),
    textposition = "outside") %>% 
  hide_colorbar()
  
  plot_type <- plot_type %>% 
    config(displayModeBar = FALSE) %>% 
    layout(
      showlegend = FALSE,
      yaxis = list(title = "", showgrid = FALSE, showticklabels = FALSE),
      xaxis = list(
        title = "", 
        tickangle = 50,
        # tickfont = list(size = 12, color = "black"),
        categoryorder = "array",  # Ensure categories are ordered as they appear in data
        categoryarray = ~n  # Use the order of locations as specified in the data
      ),
      autosize = TRUE,
      margin = list(
        l = 0,  # Left margin
        r = 0,  # Right margin
        b = 0, # Bottom margin
        t = 0   # Top margin
      )
    )
  
  plot_type
  
})


## Leaflet Plot ------------------------------------------------------------

most_type_enterprise <- reactive ({
  
  out <- filtered_data() %>% 
    # filter(type %in% input$type_rank) %>% 
    group_by(district) %>% 
    summarise(count = n())
  
  out <- left_join(x = portugal_map, y =  out, by = c("name" = "district"))
})


output$map <- renderLeaflet({
  
  pal <- colorNumeric(palette = "Greens", domain = unique(most_type_enterprise()$count))
  
  leaflet(
    data = most_type_enterprise(),
    options = leafletOptions(zoomControl = FALSE, minZoom = 6.5, maxZoom = 6.5)) %>% 
    addPolygons(
      color = "black",
      fillColor = ~pal(count),
      layerId = ~name,
      fillOpacity = 1,
      weight = 1, 
      label =  ~paste0("<b> District: </b>", name, "<br>", "<b>", "Total of Enterprises: </b>", count) %>% lapply(htmltools::HTML)
    ) %>% 
    addLegend(
      pal = pal,
      values = ~count,
      position = "bottomright", 
      title = ~paste0("Number of <br> Enterprises") %>% lapply(htmltools::HTML),
      opacity = 1.0,
      labFormat = labelFormat(suffix = "")
      # labels = labels
    ) %>%
    setMaxBounds(
      lng1 = bbox["xmin"], lng2 = bbox["xmax"], 
      lat1 = bbox["ymin"], lat2 = bbox["ymax"]
    ) %>% 
    leaflet.extras::setMapWidgetStyle(style = list(background = "transparent")) %>% 
  htmlwidgets::onRender("
              function(el, x) {
                  var map = this;
                  map.dragging.disable();
              }
          ")
})
