library(shiny)
library(shinyjs)

ui <- fluidPage(
  shinyjs::useShinyjs(),  # Enable shinyjs
  titlePanel("Main Menu"),
  fluidRow(
    column(width = 4, align = "center",
           actionButton("option1", "Option 1"),
           actionButton("option2", "Option 2"),
           actionButton("option3", "Option 3")
    )
  ),
  div(id = "main_menu",
      navbarPage(
        "Navbar Page",
        tabPanel("Option 1", "Content for Option 1"),
        tabPanel("Option 2", "Content for Option 2"),
        tabPanel("Option 3", "Content for Option 3")
      ),
      style = "display: none;"  # Initially hide main menu
  )
)

server <- function(input, output, session) {
  observeEvent(input$option1, {
    show_page("Option 1")
  })
  
  observeEvent(input$option2, {
    show_page("Option 2")
  })
  
  observeEvent(input$option3, {
    show_page("Option 3")
  })
  
  show_page <- function(option) {
    shinyjs::show("main_menu")  # Show main menu
    shinyjs::hide("option1", "option2", "option3")  # Hide menu buttons
    shinyjs::addClass(selector = "main_menu", class = "container-fluid")
    shinyjs::removeClass(selector = "main_menu", class = "container")
  }
}

shinyApp(ui = ui, server = server)