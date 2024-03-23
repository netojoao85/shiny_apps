uk <- ne_countries(scale = "large", country = "United Kingdom")

bbox <- st_bbox(uk)

my_icon <-awesomeIcons(markerColor = "red", iconColor = "black", icon = "home", text = "Manchester", extraClasses = "icon_css")

leaflet(data = uk, 
        width = "40%",
        height = "450px",
        options = leafletOptions(zoomControl = TRUE, minZoom = 4.9, maxZoom = 4.9)
) %>%
  addPolygons(
    color = "black",
    fillColor = "lightgrey",
    weight = 1,
    opacity = 1,
    fillOpacity = 1, 
    options = popupOptions(maxHeight =  "40px", minWidth = "200px", closeButton = FALSE, keepInView = TRUE)) %>% 
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
  setMapWidgetStyle(style = list(background = "transparent")) %>% 
  htmlwidgets::onRender("
    function(el, x) {
    L.marker([53.483959, -2.244644]).addTo(this)
    .bindPopup('Manchester, UK.<br> June, 2023.')
    .openPopup();
    }
  ")