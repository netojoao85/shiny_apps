library(shiny)
library(DT)
library(tidyverse)
library(janitor)
library(leaflet)
library(sf)
library(rnaturalearth)
library(rnaturalearthhires)
library(rgeos)
library(leaflet.extras)
library(bsicons)


table1 <- read_csv("03_clean_data/covid_admission_age_sex.csv")

nhs_borders <- read_sf("data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp") %>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform('+proj=longlat +datum=WGS84')
# st_transform(., 4326)

bbox <- st_bbox(nhs_borders)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  sidebarLayout(fluid = TRUE,
                sidebarPanel(
                  width = 3,
                  tags$img(src = "phs_logo.png", height = "75px", width = "200px"),
                  leafletOutput("selection_map")
                ),
                
                mainPanel(width = 9,
                          
                          navbarPage(collapsible = TRUE,title = "TEST",
                                     tabPanel("Admissions",
                                              
                                     ),
                                     
                                     tabPanel("Beds")
                                     
                          )
                          
                )
                
                
  )
))


