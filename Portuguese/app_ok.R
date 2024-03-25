library(tidyverse)
library(janitor)
library(DT)
library(tidyverse)
library(leaflet)
library(sf)
library(rnaturalearth)
library(rnaturalearthhires)
library(leaflet.extras)
library(bsicons)

apart <- read_csv("~/../Downloads/Empreendimentos_Turisticos_Existentes.csv") %>% 
  clean_names()

apart <- apart %>% 
  select(distrito, denominacao)

apart <- apart %>% 
  mutate(name = distrito) %>% 
  select(-distrito)




library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # pt <- source("map.R", local = TRUE)$value,
  # 
  
  leafletOutput("map"),
  dataTableOutput("table_out")
  
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Reactive variable to store clicked district name
  clicked_district <- reactiveVal()
  
  output$map <- renderLeaflet({
    Portugal <- ne_states(
      country = "Portugal",
      returnclass = "sf"
    ) 
    
    Portugal_continental <- Portugal %>% 
      filter(!name %in% c("Madeira", "Azores"))
    
    bbox <- st_bbox(Portugal_continental)
    
    leaflet() %>% 
      addPolygons(data = Portugal_continental,
                  color = "black",
                  fillColor = "darkgreen",
                  weight = 1,
                  opacity = 1,
                  fillOpacity = 1,
                  highlightOptions = highlightOptions(
                    fillColor = "firebrick", 
                    weight = 2, 
                    bringToFront = TRUE),
                  labelOptions = labelOptions(clickable = TRUE, permanent = TRUE, 
                                              noHide = FALSE, 
                                              textOnly = FALSE,
                                              style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center")))
    
  })
  
  
}


# Run the application 
shinyApp(ui = ui, server = server)
