library(shiny)
library(tidyverse)
library(htmltools)

ui <- fluidPage(
  # useShinyjs(),
  # source(here::here("simpsons/scripts/css_scripts.R"), local = TRUE)$value,
  includeCSS("www/style.css"),
  includeCSS("www/info_window.css"),
  # 
  # 
  div(class="head_image",
      tags$image(src = "banner2.jpg"),
      
      actionButton(inputId = "info_btn", label = "Info"),
      # bsTooltip(
      #   id = "info_btn", 
      #   title = "Click on button to open and hide app & developer details menu.",
      #   trigger = "hover",
      #   placement = "left", 
      #   options = list(container = "body")),
      # source(here::here("scripts/ui_info.R"), local = TRUE)$value
  ),
  
  div(class = "main_panel",
      fluidRow( 
        fluidRow( 
          column(width = 2,
                 # selectInput(inputId = "in_character",label = "Character",choices = unique(simpsons_words$character), width = "100%")
          ),
          column(width = 2,
                 # selectInput(inputId = "in_location", label = "Location", choices = unique(simpsons_words$location), width = "100%")
          ),
          column(width = 2,
                 # selectInput(inputId = "in_season", label = "Season",choices = unique(simpsons_words$season), width = "100%")
          )
        ),
        
        
        
        
        
        column(class = "section", width = 4,
               h3("Detailed Sentiment")
               # plotlyOutput("detailed_sentiment", height = "250px", width = "100%")
               
        ),
        
        column(class = "section", width = 4,
               h3("Location")
               # plotlyOutput("location_analysis", height = "250px")
        ),
        column(class = "word_cloud", width = 4,
               
               
               column(width = 8, 
                      h3("Most Common Words", inline = TRUE)
               ),
               column(width = 4
                      # selectInput(
                      #   inputId = "in_wc_sentiment", 
                      #   label = "", 
                      #   choices = unique(word_cloud$sentiment)
                      # ),
                      
               ),
               # plotOutput("wordcloud", height = "230px")
        )
      ),
      fluidRow(
        column(
          class = "section", width = 12,
          h3("Season")
          # plotlyOutput("season_analysis", height = "250px")
        )
      )
  )
)




# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # observeEvent(input$info_btn, {
  #  toggle("info_window")
  # })
  # 
  # output$detailed_sentiment <- renderPlotly({
  #    source(here::here("scripts/visualisations/global.R"), local = TRUE)$value
  # })
  # 
  # output$location_analysis <- renderPlotly({
  #  source(here::here("scripts/visualisations/location_analysis.R"), local = TRUE)$value
  # })
  # 
  # output$season_analysis <- renderPlotly(
  #  source(here::here("scripts/visualisations/season_analysis.R"), local = TRUE)$value
  # )
  # 
  # output$wordcloud <- renderPlot({
  #  source(here::here("scripts/visualisations/word_cloud.R"), local = TRUE)$value
  # })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
