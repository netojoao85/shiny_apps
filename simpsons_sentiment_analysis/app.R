
source(here::here("scripts/setup.R"), local = TRUE)$value

simpsons_words <- read_csv("scripts/cleaned_data/simpsons_words.csv")


wc_filter <- simpsons_words %>% 
  drop_na(sentiment_nrc) %>% 
  distinct(sentiment_nrc) %>% 
  pull()
wc_filter <- c("All", wc_filter)


character_filter <- simpsons_words %>% 
  drop_na(character) %>% 
  distinct(character) %>% 
  pull()
character_filter <- c("All", character_filter)

ui <- fluidPage(
  useShinyjs(),
  source(here::here("scripts/css_scripts.R"), local = TRUE)$value,
  
  
  # Header ------------------------------------------------------------------
  
  div(class="head_image",
      tags$image(src = "banner_simpsons.jpg"),
      
      actionButton(inputId = "info_btn", label = "Info"),
      bsTooltip(
        id = "info_btn",
        title = "Click on the button to open and hide the menu with details about the app & developer.",
        trigger = "hover",
        placement = "left",
        options = list(container = "body")),
  ),
  
  fluidRow(
      class = "option",
           style = "background-color: #67ADF5; height:25px; margin-bottom:0px",
           column(
             class ="options",
             width = 4,

             selectInput(
               inputId = "in_character",
               label = NULL,
               choices = character_filter,
               selected = "All",
               width = "100%")
           )
  ),
  
  
  # Main Panel -------------------------------------------------------------
  
  
  ## Selection section------------------------------------------------------
  
  div(class = "main_panel",
      
      fluidRow(
        style = "border-radius:10px 10px 0px 0px;",
      
      ## Plot sections -------------------------------------------------------
      
      fluidRow(
        style = "
            padding-left: 10px; 
            padding-right: 10px; 
            border-radius: 0px 0px 10px 10px;
        ",
        
        column(width = 8,
               
               fluidRow(
                 
                 column(
                   class = "section",
                   width = 6,
                   
                   h3("Sentiment", icon(id = "info_sentiment", "info-circle")), 
                   bsTooltip(
                     id = "info_sentiment",
                     title = "The number of words spoken by emotion!",
                     trigger = "hover",
                     placement = "right",
                     options = list(container = "body")),
                   
                   plotlyOutput("sentiment", height = "250px")
                 ),
                 

                 column(
                   class = "section_location",
                   width = 6,
                   
                   fluidRow(
                     column(width = 5,
                            h3("Location", icon(id = "info_location", "info-circle")),
                            bsTooltip(
                              id = "info_location",
                              title = "The ratio between positive and negative feelings in the top 50 locations. You can sort by the most negative or positive.",
                              trigger = "hover",
                              placement = "right",
                              options = list(container = "body"))
                            ),
                     column(width = 7, 
                            style = "padding-left:0px;",
                            
                            radioButtons(
                              inputId = "in_loc_sort", 
                              label = "Sort by", 
                              choices = c("Negative", "Positive"),
                              selected = "Positive",
                              inline = TRUE  # Coloca os botões de forma horizontal
                            )
                            
                            
                            )
                   ),

                   div(
                     class = "scroll",
                     plotlyOutput("location_analysis", height = "1300px")
                   )
                 )
),
               
               fluidRow(
                 column(
                   class = "section",
                   width = 12,
                   
                   h3("Season", icon(id = "info_season", "info-circle")),
                   bsTooltip(
                     id = "info_season",
                     title = "The number of positive and negative feeling words per season.",
                     trigger = "hover",
                     placement = "right",
                     options = list(container = "body")),
                   
                   plotlyOutput("season_analysis", height = "250px")
                 )
               )
            
               
        ),
        column(
          class = "word_cloud",
          width = 4,
          fluidRow(
            column(width = 8, h3("Common Words")),
            column(width = 4,
                selectInput(
                   inputId = "in_wc_sentiment",
                   label = "",
                   choices = wc_filter),
              )
            ),
            fluidRow(style= "
            display: flex;
            align-items: center;
            justify-content: center;",
                     
                     plotOutput("wordcloud")
            )
          )

      )
  )
)
)
  
  
  
  
  
  # Define server logic required to draw a histogram
  server <- function(input, output) {
    
    character_state <- reactiveValues(current_character = "all")
    
    #filter data ---------------------------------------------------------------
    filtered_data <- reactive({
      
      filtered <- simpsons_words
      
      if(input$in_character != "All") {
        filtered <- filtered[filtered$character == input$in_character, ]
        character_state <- reactiveValues(current_character = "character")
        
      }
      return(filtered)
    })  
    
    
    #info button ---------------------------------------------------------------
    observeEvent(input$info_btn, {
      toggle("info_window")
    })
    
    
    # Visualisations -----------------------------------------------------------
    
    ## Sentiment
    source(here::here("scripts/visualisations/sentiment.R"), local = TRUE)$value
    
    ## Location Plot
    source(here::here("scripts/visualisations/location_analysis.R"), local = TRUE)$value
    
    ## Word Cloud 
    source(here::here("scripts/visualisations/word_cloud.R"), local = TRUE)$value
    
    ## Season Plot
    source(here::here("scripts/visualisations/season_analysis.R"), local = TRUE)$value
    
    
    # Pop-Up ------------------------------------------------------------------
    observeEvent(input$info_btn, {
      showModal(modalDialog(
        title = "",
        easyClose = FALSE,
        footer = actionButton(
          inputId = "close_popup",
          icon = icon("power-off"), 
          label = "  Turn Off"),
        size = "l",
        div(
          class = "popup_window",
          source(here::here("scripts/ui_info.R"), local = TRUE)$value
          # includeHTML("www/popup_info_text.html")
        )
      ))
    })
    
    #to close pop-uo
    observeEvent(input$close_popup, {
      removeModal()
    })
    
    
    
  }
  
  # Run the application 
  shinyApp(ui = ui, server = server)
