library(tidyverse)
library(janitor)
library(leaflet)
library(sf)
library(rnaturalearth)
library(rnaturalearthhires)
library(rgeos)
library(leaflet.extras)
library(shiny)
library(bsicons)


sco_nhs_hb <- read_sf(here::here("data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")) %>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform(., 4326)

# img <- "<img src='https://github.com/netojoao85/data_analysis_reports/blob/main/citi_bikes/images/bike.jpg' 'width:40px'/>" %>% lapply(htmltools::HTML)

# img_url <- "https://github.com/netojoao85/data_analysis_reports/blob/main/citi_bikes/images/bike.jpg"
# img_url
# 
# img <- paste("<img src='", img_url, "' width='100px' height='100px'>")

# nhs_hb_labels <- paste(
#   img,
#   "<h3>",sco_nhs_hb$HBName,"</h3><b> 
#   Code: </b>", sco_nhs_hb$HBCode, bsicons::bs_icon("arrow-up")) %>%
#   lapply(htmltools::HTML)

# Compute the bounding box of the selected country
bbox <- st_bbox(sco_nhs_hb)


# ---------------------------

leaflet(
  width = "100%", 
  height = "500px",
  data = sco_nhs_hb,
  options = leafletOptions(zoomControl = FALSE, minZoom = 5.8, maxZoom = 5.8)) %>%
  # addProviderTiles("CartoDB.PositronNoLabels") %>%
  addPolygons(data = sco_nhs_hb,
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
                                          noHide = FALSE, 
                                          textOnly = FALSE,
                                          style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center")) ) %>% 
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
  leaflet.extras::setMapWidgetStyle(style = list(background = "transparent"))


