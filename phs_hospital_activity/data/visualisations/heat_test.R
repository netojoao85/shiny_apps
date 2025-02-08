library(tidyverse)
library(janitor)
library(leaflet)
library(sf)
library(RColorBrewer)

source(here::here("data/data_cleaning_scripts/covid_admissions.R"), local = TRUE)$value


phs_hb_data <- read_sf(here::here("data/raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")) %>% 
  clean_names()%>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform(., 4326)

bbox <- st_bbox(phs_hb_data)


heat_admissions <- covid_admissions %>% 
  group_by(hb_name) %>% 
  summarise(nr_admissions = sum(number_admissions)) %>% 
  left_join(., y = phs_hb_data, by = "hb_name")


# -------------------------------------------------------------------------

# Define color palette
pal <- colorFactor(
  palette = "RdYlGn",  # Choose a color palette
  domain = unique(heat_admissions_polygons$hb_name)
  
  
  
)

# Filter out POLYGON geometries
polygons <- heat_admissions_sf[st_geometry_type(heat_admissions_sf) == "POLYGON", ]

# Filter out MULTIPOLYGON geometries
multipolygons <- heat_admissions_sf[st_geometry_type(heat_admissions_sf) == "MULTIPOLYGON", ]

# Build map ---------------------------------------------------------------

phs_hb_map <- leaflet(
  width = "80%", 
  height = "400px",
  options = leafletOptions(zoomControl = FALSE, minZoom = 5.5, maxZoom = 5.5)
)

# Add polygons
if (!is_empty(polygons)) {
  phs_hb_map <- phs_hb_map %>% 
    addPolygons(
      data = polygons,
      color = "black",
      fillColor = ~pal(hb_name),
      weight = 1,
      opacity = 1
    )
}

# Add multipolygons
if (!is_empty(multipolygons)) {
  phs_hb_map <- phs_hb_map %>% 
    addPolygons(
      data = multipolygons,
      color = "black",
      fillColor = ~pal(hb_name),
      weight = 1,
      opacity = 1
    ) %>% 
    addLegend(
      pal = pal,
      values = ~hb_name,
      title = "",
      opacity = 1
    )
}

# Set maximum bounds
phs_hb_map <- phs_hb_map %>% 
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
  leaflet.extras::setMapWidgetStyle(style = list(background = "transparent")) %>% 
  htmlwidgets::onRender("
                function(el, x) {
                    var map = this;
                    map.dragging.disable();
                }
            ")


phs_hb_map