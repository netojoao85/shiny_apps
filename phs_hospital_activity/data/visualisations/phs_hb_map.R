library(tidyverse)
library(janitor)
library(leaflet)
library(sf)



# read shapefile ----------------------------------------------------------

phs_hb_data <- read_sf(here::here("data/raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")) %>% 
  clean_names()%>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform(., 4326)


# compute map boundaries ---------------------------------------------------

bbox <- st_bbox(phs_hb_data)


# build map ---------------------------------------------------------------

phs_hb_map <- leaflet(
  width = "80%", 
  height = "400px",
  data = phs_hb_data,
  options = leafletOptions(zoomControl = FALSE, minZoom = 5.5, maxZoom = 5.5)) %>%
  addPolygons(data = phs_hb_data,
              color = "black",
              fillColor = "lightgrey",
              weight = 1,
              opacity = 1) %>% 
              # highlightOptions = highlightOptions(
              #   fillColor = "purple", 
              #   weight = 2, 
              #   bringToFront = TRUE),
              # label = sprintf("<strong>%s</strong><br><img src='%s' width='100px' height='100px'>"),
              # label = nhs_hb_labels,
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



phs_hb_map