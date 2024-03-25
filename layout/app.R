#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    

    # Sidebar with a slider input for number of bins 
    sidebarLayout(fluid = TRUE,
        sidebarPanel(width = 3,
                     tags$img(src = "phs_logo.png", height = "75px", width = "200px"),
            source(here::here("R Scripts/map.R"), local = TRUE)$value
        ),
        mainPanel(
          
          navbarPage(collapsible = TRUE,title = "",
                     tabPanel("ok"),
                     tabPanel("nok")
                     
          )
          
        )
        
        
        )

        # Show a plot of the generated distribution
       
          

           
        )

# Define server logic required to draw a histogram
server <- function(input, output) {

   
 
}

# Run the application 
shinyApp(ui = ui, server = server)
