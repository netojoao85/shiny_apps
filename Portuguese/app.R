
source(here::here("scripts/clean_data.R"), local = TRUE)$value


ui <- fluidPage(
  
  shinyjs::useShinyjs(),
  
  source(here::here("scripts/css_scripts.R"), local = TRUE)$value, 
  
  fluidRow(
    style = "margin-left: -15px;",
    
    
    # Menu Sidebar
    column(width = 3,
           class = "col-menu", 
           
           div(class = "offset"),
        
           div(class = "menu",
               source(here::here("scripts/filter_menu/ui/ui_filter_menu.R"), local = TRUE)$value
           )
    ),
    
    # Dashboard side
    column(
      width = 9,
      
      navbarPage(
        id = "navbar",
        title = "",
        collapsible = TRUE,
        
        header = tags$head(
          source(here::here("scripts/header/ui/ui_header.R"), local = TRUE)$value
        ),
        
        
        # UI Analysis Tab ------------------------------------------------------------
        
        tabPanel(title = span(icon("eye"), "ANALYSIS"),
          source(here::here("scripts/info/ui/ui_info_analysis.R"), local = TRUE)$value,
          source(here::here("scripts/tab_analysis/ui/ui_tab_analysis.R"), local = TRUE)$value
        ),
        
        # UI Trend Tab ---------------------------------------------------------------
        
        tabPanel(
          title = span(bs_icon("graph-up"), "TREND"),
          source(here::here("scripts/info/ui/ui_info_trend.R"), local = TRUE)$value,
          source(here::here("scripts/tab_trend/ui/ui_tab_trend.R"), local = TRUE)$value
        ),
        
        # UI Data Tab ----------------------------------------------------------------
        
        tabPanel(
          title = span(bs_icon("database-fill-check"), "DATA"),
          source(here::here("scripts/info/ui/ui_info_data.R"), local = TRUE)$value,
          source(here::here("scripts/tab_data/ui/ui_tab_data.R"), local = TRUE)$value
          
        )
      )
    )
  )
)


server <- function(session, input, output) {
  
  map_section <- reactiveValues(current_selection = "portugal")
  selected_region <- reactiveVal()
  
  
  # SERVER Header -----------------------------------------------------------
  source(here::here("scripts/header/server/server_header.R"), local = TRUE)$value
  
  # SERVER Info -------------------------------------------------------------
  source(here::here("scripts/info/server/server_info.R"), local = TRUE)$value
  
  # SERVER Filter Menu -------------------------------------------------------
  source(here::here("scripts/filter_menu/server/selection_map.R"), local = TRUE)$value
  source(here::here("scripts/filter_menu/server/filter_menu_conditions.R"), local = TRUE)$value
  
  # SERVER Analysis tab -----------------------------------------------------
  source(here::here("scripts/tab_analysis/server/server_tab_analysis.R"), local = TRUE)$value
  
  # SERVER Trend tab --------------------------------------------------------
  source(here::here("scripts/tab_trend/server/server_tab_trend_plot.R"), local = TRUE)$value
  
  # SERVER Data tab ----------------------------------------------------------
  source(here::here("scripts/tab_data/server/server_tab_data_DTtable.R"), local = TRUE)$value
  
}

# Run the application 
shinyApp(ui = ui, server = server)
