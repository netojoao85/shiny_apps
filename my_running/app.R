library(shiny)
library(shinyWidgets)
library(htmltools)
library(shinyBS)
library(bslib)
library(lubridate)
library(stringr)



# Define UI ---------------------------------------------------------------
ui <- fluidPage(
  
  source(here::here("scripts/css_scripts.R"), local = TRUE)$value,
  

# Header ------------------------------------------------------------------
  fluidRow(style= "height:25px; border-radius: 50px 50px 0px 0px;"),
  source(here::here("scripts/ui_header.R"), local = TRUE)$value,
 

# Main --------------------------------------------------------------------
  fluidRow(class = "main",
           column(class = "border", width = 1),
           column(width = 10, uiOutput("contentPage")),
           column(class = "border", width = 1)
  ),
  
# Bottom Menu -------------------------------------------------------------
  source(here::here("scripts/ui_bottomMenu.R"), local = TRUE)$value,
  fluidRow(style= "height: 25px; border-radius: 0px 0px 50px 50px;")
  
)


# Define Server -----------------------------------------------------------
server <- function(input, output) {
  
# Initialize --------------------------------------------------------------
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_home.R"), local = TRUE)$value
  })
  
  

# Home Menu ---------------------------------------------------------------
  source(here::here("scripts/server_home.R"), local = TRUE)$value
  

# Analysis ----------------------------------------------------------------
  source(here::here("scripts/server_outPace.R"), local = TRUE)$value
  source(here::here("scripts/server_outVelocity.R"), local = TRUE)$value
  

# Bottom Menu --------------------------------------------------------------
  source(here::here("scripts/server_bottomMenu.R"), local = TRUE)$value
  
}


# Run App -----------------------------------------------------------------
shinyApp(ui = ui, server = server)
