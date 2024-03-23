

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  includeCSS(here::here("webpage/www/setup.css")),
  includeCSS(here::here("webpage/www/navbar.css")),
  
  mainPanel(
    
    tabPanel(title = "Home", value = "home", 
             
             actionButton(inputId = "articles", label = " > Articles", style = "background-color:blue; color:white")
             
    ),
    
    tabPanel(title = "Articles", value = "main_articles",
             
             navbarPage(
               title = "joao_neto_",
               windowTitle = "João Neto",
               collapsible = TRUE,
               #
               #   tabPanel(title = "Home", value = "home"),
               #   tabPanel(title = "Data Analysis", value = "data_analysis"),
               #   tabPanel(title = "Python Development", value = "python_development"),
               tabPanel(
                 title = "Articles", value = "articles",
                 
                 h1("My Articles are written here")
               )
             )
    )
    
    
    
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

}

# Run the application 
shinyApp(ui = ui, server = server)
