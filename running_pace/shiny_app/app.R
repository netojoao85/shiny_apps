# get libraries/packages
source("setup.R")


# Define main UI
ui <- fluidPage(
 
  source("header.R"),  #.css scripts
  
  navbarPage(
    id = "navbar_id",
    position = "fixed-top",
    collapsible = "true",
    title = span(icon("running", lib = "font-awesome"), "My Running Pace "),
    windowTitle = "Running Pace", 
    
    
    tabPanel(
      title = "Km/h",
      source(file.path("ui_server/pace/ui_pace.R"), local = TRUE)$value
    ),
      
    tabPanel(
      title = "miles",
      
      br(), br(), 
      h1(icon("hourglass-start", lib = "font-awesome"), "Under construction")
    )
    
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  source(file.path("ui_server/pace/server_pace.R"), local = TRUE)$value

  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
