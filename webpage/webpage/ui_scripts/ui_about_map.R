
library(tidyverse)
library(leaflet)
library(janitor)
library(jsonlite)
library(sf)

sco_map <- st_read(here::here("webpage/data/Scotland_boundary/Scotland boundary.shp")) %>% 
  st_simplify(dTolerance = 2500) %>% 
  st_set_crs(27700) %>% 
  st_transform(., 4326)

# Compute the bounding box of the selected country
bbox <- st_bbox(sco_map)


leaflet(
  data = sco_map) %>% 
  addProviderTiles("CartoDB.PositronNoLabels") %>%
  addPolygons(data = sco_map,
              color = "black",
              fillColor = "#005EB8",
              weight = 1,
              opacity = 1,
              fillOpacity = 1) %>%
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) 