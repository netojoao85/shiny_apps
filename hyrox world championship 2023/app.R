
# setup --------------------------------------------
source(file = here::here("R_scripts/clean_and_wrangling.R"), local = TRUE)$value


# ui ----------------------------------------------------------------------

# header
source("R_scripts/ui/header.R", local = TRUE)$value

# sidebar
source("R_scripts/ui/sidebar.R", local = TRUE)$value

# body
body <-  dashboardBody(
  
  source(here::here("R_scripts/css_scripts.R"), local = TRUE)$value, 
  

tabItems(
  
  ## Race Page ---------------------------------------------------------------
  tabItem(
    
    tabName = "race",
    
    div(id = "race_page",
        
        column(
          width = 7,
          h3(class = "race_table_title",
             icon("medal", lib = "font-awesome"), "  Results & Rankings"),
          
          tableOutput(outputId = "table_classification")
          
        ),
        
        column(
          width = 5,
          
          fluidRow(
            h3(
              class = "race_table_title",
              bs_icon("speedometer"), "  Faster Atlhete By Station"),
            
            dataTableOutput(outputId = "table_faster", width = "auto"),
            
          ),
          
          br(),
          
          fluidRow(
            h3(
              class = "race_table_title",
              bs_icon("calculator"), "  Statistics By Station"),
            
            dataTableOutput(outputId = "table_stats", width = "auto")
          )
        )
    )
  ),
  
  ## Demographic -------------------------------------------------------------
  tabItem(tabName = "demographic",
          
          fluidRow(
            column(width = 4,
                   tabBox(
                     # id = "tabbox_demographic", 
                     tabPanel(title = "Visualisation",
                              card(full_screen = TRUE,
                                   card_body(plotOutput("plot_demographic_continents"))
                              )
                     ),
                     tabPanel(title = "Data",
                              dataTableOutput(outputId = "data_continents", width = "auto")
                     ),
                   )
                   
            ),
            column(width = 4,
                   tabBox(
                     
                     tabPanel(
                       title = "Visualisation",
                       card(full_screen = TRUE,
                            card_body(plotOutput("plot_demographic_countries")))),
                     
                     tabPanel(
                       title = "Data",
                       dataTableOutput(outputId = "data_countries", width = "auto")),
                     
                   )
            ),
            
            column(width = 4,
                   tabBox(
                     tabPanel(title = "Visualisation",
                              card(full_screen = TRUE,
                                   card_body(plotOutput("plot_demographic_age_groups"))
                              )
                     ),
                     tabPanel(title = "Data",
                              dataTableOutput(outputId = "data_age_group", width = "auto")),
                   )
                   
            )
            
          )
  ),
  
  
  ## Analysis ----------------------------------------------------------------
  tabItem(
    
    tabName = "analysis",
    
    div(id = "analysis_main_page", style = "margin: 0px 0px 0px 30px;",
        
        div(class = "athlete_name_row", style = "margin:0px; padding: 0px;",
            h1(textOutput(outputId = "athlete_name"))
        ),
        
        #///////////////////////////////////////////////////////////////
        
        fluidRow(
          infoBoxOutput("athlete_overall_performance", width = 4),   
          infoBoxOutput("athlete_age_group_info", width = 4),
          infoBoxOutput("nationality", width = 4),
        ),
        # div(id = "infoboxs_row",
        #     
        #     infoBoxOutput("athlete_overall_performance", width = 4),   
        #     infoBoxOutput("athlete_age_group_info", width = 4),
        #     infoBoxOutput("nationality", width = 4),
        # ),
        
        #///////////////////////////////////////////////////////////////
        
        fluidRow(
          column(width = 4,
                 dataTableOutput(outputId = "tb_athelte_stations", width = "auto")
          ),
          
          column(width = 8,
                 plotOutput("plot_run_analysis", height = "480px", width = "auto" )
          )
        )
        
        
    )
    
  )
)
)





# ui - Define the ui ------------------------------------------------------
ui <- dashboardPage(
  header  = header, 
  sidebar = sidebar, 
  body    = body
)

server <- function(input, output, session) {
  
  table_template <- reactive({
    
    options = list(
      autoWidth = FALSE,    #smart width handling
      searching = FALSE,    #search box above table
      ordering = FALSE,      #whether columns can be sorted
      lengthChange = FALSE, #ability to change number rows shown on page in table
      lengthMenu = FALSE,   #options lengthChange can be changed to
      pageLength = FALSE,   #initial number of rows per page of table
      paging = FALSE,       #whether to do pagination
      info = FALSE          #notes whether or not table is filtered
    )
    
  })
  
  
  ## Station Selected ---------------------------------------------------------
  station_selected <- reactive({
    as.character(input$select_station_list)  
  })
  
  
  scale_run <- reactive({
    faster_running <- min(hyrox_ellite_men_tidy$time_as_duration[str_detect(hyrox_ellite_men_tidy$station, "running") & hyrox_ellite_men_tidy$name == input$select_athlete_list])
    slower_running <- max(hyrox_ellite_men_tidy$time_as_duration[str_detect(hyrox_ellite_men_tidy$station, "running") & hyrox_ellite_men_tidy$name == input$select_athlete_list])
    
    
    scale_running <- station_statistics %>%
      filter(str_detect(station, "running")) %>%
      summarise(faster_mean   = min(mean_time),
                slower_mean   = max(mean_time),
                faster_median = min(median_time),
                slower_median = max(median_time),
                faster_run    = faster_running,
                slower_run    = slower_running)
    
    return(scale_running)
    
  })
  
  
  #/////////////////////////////////////////////////////////////////////
  # RACE RESULTS PAGE
  #/////////////////////////////////////////////////////////////////////
  source("R_scripts/server/race_classification_table.R", local = TRUE)$value
  source("R_scripts/server/race_faster_table.R", local = TRUE)$value
  source("R_scripts/server/race_stats_table.R", local = TRUE)$value
  
  
  #/////////////////////////////////////////////////////////////////////
  # DEMOGRAPHIC PAGE
  #/////////////////////////////////////////////////////////////////////
  source("R_scripts/server/demographic_plot.R", local = TRUE)$value
  source("R_scripts/server/demographic_data.R", local = TRUE)$value
  
  
  #/////////////////////////////////////////////////////////////////////
  # INDIVIDUAL ANALYSIS PAGE
  #/////////////////////////////////////////////////////////////////////
  output$athlete_name <- renderText({ 
    sprintf("%s's Race Performance", input$select_athlete_list) 
  })
  
  source("R_scripts/server/analysis_infobox.R", local = TRUE)$value
  source("R_scripts/server/analysis_statistic_switch.R", local = TRUE)$value
  source("R_scripts/server/analysis_table.R", local = TRUE)$value
  source("R_scripts/server/analysis_run_plot.R", local = TRUE)$value
  
}

# Run the application 
shinyApp(ui = ui, server = server)
