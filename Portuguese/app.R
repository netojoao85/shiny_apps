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

districts_mapping <- data.frame(id = 1:nrow(Portugal_continental),
                                name = Portugal_continental$name)


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
      addTiles() %>% 
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
                  # label = Portugal_continental$name,
                  # popup = paste0(Portugal_continental$name, "<br>", bsicons::bs_icon("pin")),
                  labelOptions = labelOptions(clickable = TRUE, 
                                              permanent = TRUE, 
                                              noHide = TRUE, 
                                              textOnly = FALSE,
                                              style = list("font-size" = "14px", "background-color" = "lightgrey", "text-align" = "center"))) %>%
      setMaxBounds(lng1 = bbox["xmin"], lng2 = bbox["xmax"], lat1 = bbox["ymin"], lat2 = bbox["ymax"]) %>% 
      leaflet.extras::setMapWidgetStyle(style = list(background = "transparent"))
    
    
  })
  
  
  # observeEvent(input$map_shape_click, {
  #   click <- input$map_shape_click
  #   if (!is.null(click$id)) {
  #     selected_district <- districts_mapping$name[click$id]
  #     clicked_district(selected_district)
  #   }
  # })
  
  observeEvent(input$map_shape_click, {
    print("Clicked shape event:")
    print(input$map_shape_click)
  })
  
  # Define reactive expression for filtered data
  filtered_apart <- reactive({
    selected_district <- clicked_district()
    if (!is.null(selected_district)) {
      filter(apart, name == selected_district)
    } else {
      apart
    }
  })
  
  # Render DataTable
  output$table_out <- renderDataTable({
    filtered_apart()
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server)
