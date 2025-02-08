library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(shinydashboard)
library(leaflet)
library(sf)


source(here::here("data/data_cleaning_scripts/covid_admissions.R"), local = TRUE)$value

phs_hb_data <- read_sf(here::here("data/raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")) %>% 
  clean_names()%>% 
  st_simplify(dTolerance = 2500) %>%
  st_transform(., 4326)

bbox <- st_bbox(phs_hb_data)



ui <- fluidPage(

   source(here::here("app_scripts/css_scripts.R"), local = TRUE)$value,

   includeCSS("www/setup.css"),
   includeCSS("www/navbar.css"),
   includeCSS("www/ui_home.css"),

  
  uiOutput("layout_page")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  
  # Home Page Layout --------------------------------------------------------
  
  output$layout_page <- renderUI({
    source(here::here("app_scripts/ui/ui_home.R"), local = TRUE)$value
  })
  
  
  observeEvent(input$navbar, {
    
    if (input$navbar == "Home") {
      output$layout_page <- renderUI({
        source(here::here("app_scripts/ui/ui_home.R"), local = TRUE)$value
      })
    }
  })
  
  
  
  home_selection <- reactiveVal()
  
  observeEvent(input$beds, {
    home_selection(list("beds", "Beds Occupancy"))
  })
  
  observeEvent(input$covid, {
    home_selection(list("covid", "Covid Admissions"))
  })
  
  observeEvent(input$length, {
    home_selection(list("length", "Lengths of Stay"))
  })
  
  observeEvent(input$about, {
    home_selection(list("about", "About"))
  })
  
  
  
  # Main Layout -------------------------------------------------------------
  
  observeEvent(home_selection(), {
    output$layout_page <- renderUI({
      
      
      navbarPage(
        id = "navbar",
        title = "",
        collapsible = TRUE,
        
        header = tags$head(
          
          div(style = "color:white; background-color:var(--head-color); margin:0px; padding:20px 40px 20px 40px; ",
              tags$img(src = "images/phs_logo.png", height = "80px"),
            )
          ),
        
        # Home
        tabPanel(icon = icon("home"), title = "Home"),
        
        
        # Lengths of Stay
        tabPanel(icon = icon("chart-line"), title = "Lengths of Stay",
                 
                 
                 column(width = 4, style = "background-color:whitesmoke",
                        
                        tags$img(src = "images/phs_logo.png", height = "80px"),
                        br(),
                        br(),
                        
                        
                        selectInput(
                          inputId = "hb_selection",
                          label = "Health Board",
                          choices = unique(covid_admissions$hb_name)
                        ),
                        
                        leafletOutput("hb_heat_map", height = "600px"),
                        leafletOutput("hb_map")
                        
                        ),
                 column(width = 8,
                        plotlyOutput("covid_admissions", height = "450px")
                        )
        ),
        
        
        # Beds Occupancy
        tabPanel(icon = icon("bed"), title = "Beds Occupancy",
                 plotOutput("cancer_incidence_gender"),
                 plotOutput("cancer_incidence_type_cancer"),
                 ),
        
        # Covid Admissions
        tabPanel(icon = icon("virus"), title = "Covid Admissions"),
        
        # About
        tabPanel(icon = icon("info-circle"), title = "About", includeHTML("www/about_page.html"))
        
      )
      
    })
    
    updateTabsetPanel(session, "navbar", selected = home_selection()[[2]])
    home_selection(NULL)
  })
  
  
  

# my server ---------------------------------------------------------------

  selected_region <- reactiveVal()
  

  output$covid_admissions <- renderPlotly({
    source(here::here("data/visualisations/covid_admissions_plot.R"), local = TRUE)$value
  })
  
  source(here::here("app_scripts/server/hb_map_covid_admissions_server.R"), local = TRUE)$value
  
  
  #Cancer Incidence
  source(here::here("app_scripts/server/server_cancer_incidence/incidence_per_gender.R"), local = TRUE)$value
 
  


}


# Run the application 
shinyApp(ui = ui, server = server)
