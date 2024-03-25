library(tidyverse)
library(leaflet)
library(sf)
library(rnaturalearth)
library(rnaturalearthhires)
library(leaflet.extras)
library(bsicons)


Portugal <- ne_states(
  country = "Portugal",
  returnclass = "sf"
) 


Portugal_continental <- Portugal %>% 
  filter(!name %in% c("Madeira", "Azores"))

bbox <- st_bbox(Portugal_continental)

leaflet() %>% 
  # addTiles() %>% 
  addPolygons(data = Portugal_continental,
              color = "black",
              fillColor = "darkgreen",
              weight = 1,
              opacity = 1,
              fillOpacity = 1,
              highlightOptions = highlightOptions(
                fillColor = "firebrick", 
                weight = 2, 
                bringToFront = TRUE),
              # label = Portugal_continental$name,
              # popup = paste0(Portugal_continental$name, "<br>", bsicons::bs_icon("pin")),
              labelOptions = labelOptions(clickable = TRUE, permanent = TRUE, 
                                          noHide = FALSE, 
                                          textOnly = FALSE,
                                          style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center"))) %>%
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
  leaflet.extras::setMapWidgetStyle(style = list(background = "transparent"))
  # addCircleMarkers(~longitude, ~latitude, label = ~denominacao, radius = 10)
  # addSearchOSM(options = searchOSMOptions(
  #   # propertyName = "denominacao",
  #   zoom = 10)