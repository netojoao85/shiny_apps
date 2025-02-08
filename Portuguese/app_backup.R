
source(here::here("scripts/clean_data.R"), local = TRUE)$value


ui <- fluidPage(
  
  shinyjs::useShinyjs(),
  
  
  source(here::here("scripts/css_scripts.R"), local = TRUE)$value, 
  
  # div(style = "margin-left:-15px; margin-right: -15px",
  #
  #     tags$img(src = "banner.png", style = "margin: 0px 0px 0px 0px; width: 100%; height:auto")
  #   ),

  # actionButton(
  #   inputId = "show_popup",
  #   icon = icon("info-circle"),
  #   label = "info",
  #   width = "200px"
  # ),
  
  
  
  navbarPage(
    id = "navbar",
    title = "",
    collapsible = TRUE,
    
    header = tags$head(
      source(here::here("scripts/header/ui/ui_header.R"), local = TRUE)$value
    ),
    
    # UI Analysis Tab ------------------------------------------------------------
    
    tabPanel(
      title = span(icon("eye"), "Analysis"),
      uiOutput("layout_glance")
    ),
    
    # UI Trend Tab ---------------------------------------------------------------
    
    tabPanel(title = span(bs_icon("graph-up"), "TREND"),
             source(here::here("scripts/tab_trend/ui/ui_tab_trend.R"), local = TRUE)$value
             ),
    
    
    
    # UI Rank Tab ----------------------------------------------------------------
    
    tabPanel(title = span(bs_icon("bar-chart-fill"), "RANK"),
             
    ),
    
    
    
    # UI Data Tab ----------------------------------------------------------------
    
    tabPanel(
      title = span(bs_icon("database-fill-check"), "DATA"),
      source(here::here("scripts/tab_data/ui/ui_tab_data.R"), local = TRUE)$value
    )
  )
  
  
)  




# Define server logic required to draw a histogram
server <- function(session, input, output) {
  
  #selected_region carries the district selected in the filter menu map
  selected_region <- reactiveVal()
  
  
  # renderUI Analysis Tab ---------------------------------------------------
  # output$layout_glance <- renderUI({
  #   if (!is.null(selected_region())) {
  #     source(here::here("scripts/tab_analysis/ui/ui_tab_analysis_district.R"), local = TRUE)$value
  #   } else {
  #     source(here::here("scripts/tab_analysis/ui/ui_tab_analysis_portugal.R"), local = TRUE)$value
  #   }
  # })

  ui_state <- reactiveValues(current_ui = "portugal")
  
  portugal_ui <- source(here::here("scripts/tab_analysis/ui/ui_tab_analysis_portugal.R"), local = TRUE)$value
  district_ui <- source(here::here("scripts/tab_analysis/ui/ui_tab_analysis_district.R"), local = TRUE)$value
  
  output$layout_glance <- renderUI({
    
    if (ui_state$current_ui == "district") {
      district_ui
    } else {
      portugal_ui
    }
    
    # if (ui_state$current_ui == "portugal") {
    #   portugal_ui
    # } 
    
  })
  


  # SERVER Header -----------------------------------------------------------
  source(here::here("scripts/header/server/server_header.R"), local = TRUE)$value
  
  
  # SERVER Filter Menu ------------------------------------------------------
  source(here::here("scripts/filter_menu/server/selection_map.R"), local = TRUE)$value
  source(here::here("scripts/filter_menu/server/filter_menu_conditions.R"), local = TRUE)$value
  
  
  # SERVER Analysis tab ------------------------------------------------------------
  source(here::here("scripts/tab_analysis/server/server_tab_analysis_portugal.R"), local = TRUE)$value
  source(here::here("scripts/tab_analysis/server/server_tab_analysis_district.R"), local = TRUE)$value
  
  
  # SERVER Trend tab ---------------------------------------------------------------
  source(here::here("scripts/tab_trend/server/server_tab_trend_plot.R"), local = TRUE)$value
  
  
  # SERVER Rank Tab ----------------------------------------------------------------
  # source(here::here(""), local = TRUE)$value
  
  
  # SERVER Data tab ----------------------------------------------------------------
  source(here::here("scripts/tab_data/server/server_tab_data_DTtable.R"), local = TRUE)$value
  
  
  # infoboxes ---------------------------------------------------------------
  
  nr_enterprises <- reactive({
    nrow(filtered_data())
  })
  
  
  
  
  
  output$nr_enterprises_analysis <- renderText({ 
    sprintf("%s Enterprises", nr_enterprises()) 
  })
  
  output$nr_enterprises_trend <- renderText({ 
    sprintf("%s Enterprises", nr_enterprises()) 
  })
  
  output$selected_region_analysis <- renderText({
    if(!is.null(selected_region())){
      sprintf("%s district", selected_region()) 
    } else {
      return("All Portuguese Districts")
    }
  })
    
    output$selected_region_trend <- renderText({
      if(!is.null(selected_region())){
        sprintf("%s district", selected_region()) 
      } else {
        return("All Portuguese Districts")
      }
  })
  
  
  
  
} #close server


# Run the application 
shinyApp(ui = ui, server = server)
