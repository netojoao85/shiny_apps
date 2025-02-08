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


table1 <- read_csv("../01_raw_data/hospitalisations_due_to_covid_19/admissions_by_health_board_age_and_sex.csv")

nhs_borders <- read_sf("../data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp") %>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform('+proj=longlat +datum=WGS84')
# st_transform(., 4326)

bbox <- st_bbox(nhs_borders)


# Define UI for application that draws a histogram
shinyUI(
  fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
