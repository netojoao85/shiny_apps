library(tidyverse)
library(leaflet)
library(sf)



# read shapefile ----------------------------------------------------------

phs_hb_map <- read_sf(here::here("data/raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")) %>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform(., 4326)


# compute map boundaries ---------------------------------------------------

bbox <- st_bbox(phs_hb_map)


# build map ---------------------------------------------------------------

phs_hb_map <- leaflet(
  width = "80%", 
  height = "500px",
  data = phs_hb_map,
  options = leafletOptions(zoomControl = FALSE, minZoom = 5.8, maxZoom = 5.8)) %>%
  addPolygons(data = phs_hb_map,
              color = "black",
              fillColor = "#005EB8",
              weight = 1,
              opacity = 1,
              fillOpacity = 1,
              highlightOptions = highlightOptions(
                fillColor = "purple", 
                weight = 2, 
                bringToFront = TRUE),
              # label = phs_hb_map,
              popup = bsicons::bs_icon("pin"),
              labelOptions = labelOptions(clickable = TRUE, permanent = TRUE, 
                                          noHide = FALSE, 
                                          textOnly = FALSE,
                                          style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center")) ) %>% 
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
  leaflet.extras::setMapWidgetStyle(style = list(background = "transparent"))

phs_hb_map


