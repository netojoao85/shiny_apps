
# get libraries ------------------------------------------------------------

library(tidyverse)
library(janitor)
library(stringr)

library(readxl)
library(lubridate)
library(here)
library(tsibble)
library(scales)

library(htmltools)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(bslib)
library(bsicons)
library(shinyjs)
library(shinyBS)

library(knitr)
library(fontawesome)
library(rsconnect)

library(fresh)

#Tables
library(DT)
library(formattable)
library(kableExtra)

#map
library(leaflet)
library(sf)
library(rnaturalearth)
library(leaflet.extras)



# get datasets
hyrox_ellite_men_raw <- readxl::read_xlsx(here::here("raw_data/dataset_hyrox_elite_2023.xlsx")) %>% 
  clean_names()

rank_stations_official <- readxl::read_xlsx(here::here("raw_data/rank_stations_official.xlsx")) %>% 
  clean_names()


# call functions
source(file = here::here("R_scripts/functions/sum_time.R"), local = TRUE)$value
source(file = here::here("R_scripts/functions/avg_station.R"), local = TRUE)$value
source(file = here::here("R_scripts/functions/rank_station.R"), local = TRUE)$value

