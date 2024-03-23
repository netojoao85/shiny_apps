#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  navbarPage(
      id = "intabset", # id used for jumping between tabs
      position = "fixed-top",
      collapsible = "true",
      title = "My Running Pace",
      
      
      tabPanel(title = "Pace",
               
               ),
      
      tabPanel(title = "Velocity",
               
               ),
      
      tabPanel(title = "Time",
               
               )
      
  )

 
)

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
