# Libraries ---------------------------------------------------------------
library(tidyverse)
library(janitor)
library(bsicons)
library(shinydashboard)


# Header -----------------------------------------------------------------                                                               
header <- dashboardHeader(disable = TRUE

  # title = tags$img(src = here::here("www/phs_logo.png"), height = 40, width = 200)
)



# Sidebar ----------------------------------------------------------------
sidebar <- dashboardSidebar(
  
  source(here::here("R Scripts/map.R"), local = TRUE)$value,
  
  sidebarMenu(id = "sidebarmenu_id",
              
              menuItem(
                span(bs_icon("zoom-in")," Race Results"), tabName = "ok"
              ),
              
              menuItem(
                span(bs_icon("zoom-in")," Race Results"), tabName = "ok1"
              )
              
              
  )
)



# Body -------------------------------------------------------------------
body <- dashboardBody(
  
  # includeCSS("www/css/navbar.css"),
  # includeCSS("www/css/sidebar.css"),
  
  navbarPage(id = "my-navbar",
             title = "João Neto _",
             windowTitle = "João Neto _",
             collapsible = TRUE, 
             
             
             # navbar tabs -------------------------------------------------------------
             
             tabPanel(
               title = "Home", 
               value = "home"
             ),
             
             tabPanel(
               title = "About", 
               value = "about",
             )),
  
)



# ui - Define the ui ------------------------------------------------------

ui <- dashboardPage(
  
 
  
  
  header  = header, 
  sidebar = sidebar, 
  body    = body
)



# Server ------------------------------------------------------------------
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })
  
}


# Run Application ---------------------------------------------------------
shinyApp(ui = ui, server = server)