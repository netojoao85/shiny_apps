# Libraries ---------------------------------------------------------------
library(tidyverse)
library(janitor)
library(bsicons)
library(shinydashboard)


# Header -----------------------------------------------------------------                                                               
header <- dashboardHeader(
  
  # title = "PHS"
  title = tags$img(src = "images/white-logo.png", 
                   height = "100%", width = "75%"
                   ),
  titleWidth = 230

  )

# Sidebar ----------------------------------------------------------------
sidebar <- dashboardSidebar(
  
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
  
  includeCSS("www/css/navbar.css"),
  includeCSS("www/css/sidebar.css"),
  
  tabItems(
    
    tabItem(tabName = "OK",
            
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            plotOutput("distPlot")
    ),
    
    tabItem(tabName = "OK1",
            
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
            
            # plotOutput("distPlot")
    )

  )
  
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