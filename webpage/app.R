

source(here::here("ui_scripts/source.R"), local = TRUE)$value


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # useShinyjs(), # Initialize shinyjs
  

# upload .CSS scripts -----------------------------------------------------
includeCSS(here::here("www/setup.css")),
includeCSS(here::here("www/navbar.css")),

includeCSS(here::here("www/ui_about.css")),

includeCSS(here::here("www/ui_articles.css")),




# ui structure ------------------------------------------------------------


  navbarPage(
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
      
      source(here::here("ui_scripts/ui_about.R"), local = TRUE)$value
    ),
    
    tabPanel(
      title = "Data Analysis", 
      value = "data_analysis",
      
      source(here::here("ui_scripts/ui_home.R"), local = TRUE)$value
      
      ),
    
    tabPanel(title = "Python Development", value = "python_development"),
    
    tabPanel(
      title = "Articles",
      value = "articles",

      source(here::here("ui_scripts/ui_articles.R"), local = TRUE)$value
      
      # source(here::here("ui_scripts/ui_articles_data_ethics.R"), local = TRUE)$value
      )
    
  )


)#end fluid_page



# Define server logic required to draw a histogram
server <- function(input, output) {
  
  observeEvent(input$articles_button, {
    # Load the UI script for articles ethics
    source(here::here("ui_scripts/ui_articles_data_ethics.R"), local = TRUE)$value
  })
  
  
  

}

# Run the application 
shinyApp(ui = ui, server = server)
