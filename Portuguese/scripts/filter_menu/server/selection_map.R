
# observeEvent(input$selection_map_shape_click, {
#   click <- input$selection_map_shape_click
#   print("Clicked shape:")
#   print(click)
# })

selected_region <- reactiveVal()

# output$district_selected <- renderText({
#   if (!is.null(selected_region())) {
#     sprintf("%s District", selected_region()) 
#   } else {
#     "All Portuguese Districts"
#   }
# })



all_districts_map <- leaflet(
  data = portugal_map, 
  options = leafletOptions(zoomControl = FALSE, minZoom = 5.7, maxZoom = 5.7)) %>%
  addPolygons(
    color = "black",
    fillColor = "#E8E0D8",
    # fillColor = "var(--map-color)",
    layerId = ~name,
    fillOpacity = 1,
    weight = 1, 
    label = ~name, 
    labelOptions = labelOptions(),
    highlightOptions = highlightOptions(
      fillColor = "darkgreen",
      color = "darkgreen",
      weight = 2,
      bringToFront = TRUE)) %>% 
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
  leaflet.extras::setMapWidgetStyle(style = list(background = "transparent")) %>% 
  htmlwidgets::onRender("
                function(el, x) {
                    var map = this;
                    map.dragging.disable();
                }
            ")


output$selection_map <- renderLeaflet({
  all_districts_map
})


observeEvent(input$selection_map_shape_click$id, {
  
  selected_region(input$selection_map_shape_click$id)
  
  # ui_state$current_ui <- "district"
  
  # to update sidebar municipality section depending which district selection
  municipalities <- unique(enterprises$municipality[enterprises$district == selected_region()])
  updatePickerInput(
    session = session,
    inputId = "select_municipality",
    choices = municipalities,
    selected = municipalities
  )
  
  #to design the shape of the district selected
  leafletProxy(mapId = "selection_map", data = portugal_map[portugal_map$name == selected_region(), ]) %>%
    clearGroup("polygons") %>% 
    addPolygons(
      group = "polygons",
      # layerId = portugal_map$ame,
      fillColor = "darkgreen",
      color = "firebrick",
      opacity = 1,
      fillOpacity = 1,
      weight = 2,
      label = selected_region()
    )
})



# Button active all districts in the filter map ---------------------------

observeEvent(input$clear_selection, {
  
  selected_region(NULL)
  
  output$selection_map <- renderLeaflet({
    all_districts_map
  })
  
  updatePickerInput(
    session = session,
    inputId = "select_municipality",
    choices = character(0),
    options = list(title = "Select one district")
  )
  
  # ui_state$current_ui <- "portugal"
  
})


