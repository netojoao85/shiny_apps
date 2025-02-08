
# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  output$selection_map <- renderLeaflet({
    
    leaflet(
      width = "100%", 
      height = "500px",
      data = nhs_borders,
      options = leafletOptions(zoomControl = FALSE, minZoom = 5.8, maxZoom = 5.8)) %>%
      # addProviderTiles("CartoDB.Positron") %>%
      addPolygons(data = nhs_borders,
                  color = "black",
                  fillColor = "#005EB8",
                  weight = 1,
                  opacity = 1,
                  fillOpacity = 1,
                  highlightOptions = highlightOptions(
                    fillColor = "purple", 
                    weight = 2, 
                    bringToFront = TRUE),
                  # label = sprintf("<strong>%s</strong><br><img src='%s' width='100px' height='100px'>"),
                  # label = nhs_hb_labels,
                  popup = bsicons::bs_icon("pin"),
                  labelOptions = labelOptions(clickable = TRUE, permanent = TRUE, 
                                              noHide = TRUE, 
                                              textOnly = FALSE,
                                              style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center"))) %>% 
      setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>%
      leaflet.extras::setMapWidgetStyle(style = list(background = "transparent"))
  })
  
  
  observeEvent(input$selection_map_shape_click, {
    click <- input$selection_map_shape_click
    print("Clicked shape event:")
    print(click)
  })
  
  
  
  

})
