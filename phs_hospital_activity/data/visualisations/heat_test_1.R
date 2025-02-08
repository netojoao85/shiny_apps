library(tidyverse)
library(janitor)
library(leaflet)
library(sf)
library(RColorBrewer)

# Load data
source(here::here("data/data_cleaning_scripts/covid_admissions.R"), local = TRUE)$value

phs_hb_data <- read_sf(here::here("data/raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")) %>% 
  clean_names()%>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform(., 4326)

bbox <- st_bbox(phs_hb_data)

summary_admissions <- covid_admissions %>% 
  filter(specialty == "All") %>% 
  group_by(hb_name) %>% 
  summarise(n_admissions = sum(number_admissions))



data <- left_join(x = phs_hb_data, y = summary_admissions, by = "hb_name")


n_breaks <-  5  
# breaks <- ceiling(seq(
#   min(data$n_admissions), 
#   max(data$n_admissions), 
#   length.out = n_breaks)
# )
labels <- c(paste(breaks[-n_breaks] + 1, breaks[-1], sep = " - "), paste(" > ", breaks[n_breaks]))


#//////////////////////////////////////////////////////////////////////////////
breaks <- quantile(data$n_admissions, probs = seq(0, 1, by = 1/n_breaks))
labels <- c(paste0(round(breaks[-n_breaks] +1 , 0), " - ", round(breaks[-1], 0)), paste0("> ", round(breaks[n_breaks], 0)))

# Create color palette and corresponding colors
pal <- colorQuantile(
  # palette = "Purples",
  "OrRd",
  # viridisLite::viridis(12),
  domain = data$n_admissions,
  n = n_breaks)

# Build map
leaflet(data = data) %>% 
  addPolygons(
    color = "black",
    fillColor = ~pal(n_admissions),
    layerId = ~hb_name, 
    weight = 1,
    opacity = 1,
    fillOpacity = 0.9
  ) %>% 
  setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
  leaflet.extras::setMapWidgetStyle(style = list(background = "transparent")) %>% 
  addLegend(
    "bottomright", 
    title = "Number of Admissions",
    colors = pal(breaks),
    labels = labels,
    opacity = 0.9
  )

