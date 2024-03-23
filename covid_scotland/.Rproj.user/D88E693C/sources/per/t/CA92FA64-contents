library(shiny)
library(tidyverse)
library(leaflet)
library(sf)
library(htmlwidgets)
library(shinydashboard)
library(shinyWidgets)
library(shinythemes)
library(bslib)
library(tsibble)
library(plotly)



# Load relevant data sets
beds <- read_csv(here::here("02_cleaned_data/bed_clean.csv")) %>% 
  mutate(year_quarter = yearquarter(year_quarter))

activity_patient_demographics <- read_csv(here::here("02_cleaned_data/activity_patient_demographics.csv")) 

specialty_admissions <- read_csv(here::here("02_cleaned_data/admissions_by_speciality_clean.csv"))

activity_deprivation <- read_csv(here::here("02_cleaned_data/activity_deprivation.csv")) %>% 
  mutate(year_quarter = make_yearquarter(year, quarter), .after = quarter)

covid_admission_age_sex <- read_csv(here::here("02_cleaned_data/covid_admission_age_sex.csv"))

activity_dep_variables <- activity_deprivation %>% 
  select(contains(c("episode", "stay"))) %>%  names()

deaths_by_deprivation <- read_csv(here::here("02_cleaned_data/deaths_by_deprivation.csv"))

names(activity_dep_variables) <- str_to_title(
  str_replace_all(
    str_replace(
      str_replace(activity_dep_variables, 
                  "^e", "number of e"), "^s", "number of s"), "_", " "))
  

# Load variables/functions for Leaflet Plots ------------------------------

# Load in the region geometry
nhs_borders <- st_read(dsn = here::here("02_cleaned_data/nhs_region_simple"))

# Create labels for region plot
labels_regions <- paste0(
  "<b>", nhs_borders$HBName, "</b><br>", nhs_borders$HBCode
) %>% lapply(htmltools::HTML)

# Create colour pallete "function"
pal <- colorFactor("viridis", domain = nhs_borders$HBCode, 
                   n = nrow(nhs_borders))

# Create the view box for the leaflet
bbox <- st_bbox(nhs_borders) %>% 
  as.vector()


label_scotland <- paste0(
  "<b>", "Click Marker For", "</b><br>", "NHS Scotland"
  ) %>% lapply(htmltools::HTML)


# Beds data ---------------------------------------------------------------

beds <- read_csv(here::here("02_cleaned_data/bed_clean.csv")) %>% 
  mutate(year_quarter = yearquarter(year_quarter))




# Plotly plot -------------------------------------------------------------

beds_variables_selection <- beds %>% 
  select(contains(c("bed", "occup"))) %>%  names()

# Apply titles
names(beds_variables_selection) <- str_to_title(
  str_replace_all(beds_variables_selection, "_", " "))



# Load Functions ----------------------------------------------------------

source(here::here("08_functions/significance_round_function.R"))


# NHS theme ---------------------------------------------------------------

