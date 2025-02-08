fluidPage(
  
  div(
    class = "data_menu",
    h3(
      bs_icon("gear", style = "padding-bottom: 7px"), "Menu"),
    
    downloadButton("download_data", "Download Data"),
    actionButton(icon = icon("check"), "select_all_var", "Select All Variables"),
    actionButton(icon = icon("close"), "remove_var", "Remove Variables"),
  ),
  
  checkboxGroupInput(
    inputId = "select_data",
    label = "",
    choices = my_vars,
    selected = my_vars,
    inline = TRUE,
    width = NULL,
    choiceNames = NULL,
    choiceValues = TRUE
  ),
  
  DTOutput("table_summary")
  
)