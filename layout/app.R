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

nhs_borders <- read_sf(here::here("data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")) %>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform('+proj=longlat +datum=WGS84')
# st_transform(., 4326)

bbox <- st_bbox(nhs_borders)



ui <- shinyUI(
  fluidPage(
  
  sidebarLayout(fluid = TRUE,
                sidebarPanel(
                  width = 3,
                  tags$img(src = "phs_logo.png", height = "75px", width = "200px"),
                  leafletOutput("selection_map")
                ),
                
                mainPanel(width = 9,
                          
                          navbarPage(collapsible = TRUE,title = "",
                                     tabPanel("Admissions",
                                              
                                              
                                              DT::dataTableOutput("table_output")
                                              
                                              
                                     ),
                                     
                                     tabPanel("Beds")
                                     
                          )
                          
                )
                
                
  )
)
)

# Define server logic required to draw a histogram
# server <- function(input, output, session) {
shinyServer(function(input, output, session) {
  output$selection_map <- renderLeaflet({
    
    leaflet(
      width = "100%", 
      height = "500px",
      data = nhs_borders,
      options = leafletOptions(zoomControl = FALSE, minZoom = 5.8, maxZoom = 5.8)) %>%
      # addProviderTiles("CartoDB.Positron") %>%
      addPolygons(data = nhs_borders,
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
                                              noHide = TRUE, 
                                              textOnly = FALSE,
                                              style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center"))) %>% 
      setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>%
      leaflet.extras::setMapWidgetStyle(style = list(background = "transparent"))
    })
    
  
  observeEvent(input$selection_map_shape_click, {
    click <- input$selection_map_shape_click
    print("Clicked shape event:")
    print(click)
  })


  
  output$table_output <- renderDataTable({
    table1
  })
})
  
  
  


# Run the application 
shinyApp(ui = ui, server = server)
