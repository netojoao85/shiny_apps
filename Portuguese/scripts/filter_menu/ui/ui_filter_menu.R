
fluidPage(
  
  fluidRow(
    column(width = 6, style ="padding-right:0px",
           h4("Select one District in the Map"),
           leafletOutput("selection_map", height = "265px"),
    ),
    column(width = 6, style ="padding:60px 10px 0px 0px; margin:0px;",
           checkboxGroupInput(
             inputId = "type_enterprise", 
             label = "Type of Enterprise", 
             inline = TRUE, 
             choices = my_type, 
             selected = my_type
           ),
    )
  ),
  
  actionButton(
    inputId = "clear_selection", icon =  icon(""),
    label = span(
      img(src = "images/portugal_flag.png", height = "20px"), 
      "Filter by All Districts"
    )
  ),
  
  
  hr(class = "break"),
  pickerInput(
    inputId = "select_municipality",
    label = span(bs_icon("geo-alt-fill"), "Municipality:"),
    choices = NULL,
    multiple = TRUE,
    inline = TRUE,
    options = list(`actions-box` = TRUE, title = "Select one district")
  ),
  
  
  hr(class = "break"),
  sliderInput(
    inputId = "year_input" ,
    label = span(bs_icon("calendar3"), "Start Year"),
    value = c(1950, 2024),
    step = 1, min = 1950,
    max = 2024,
    round = TRUE,
    ticks = TRUE,
    sep =""
  ),
  
  hr(class = "break"),
  radioButtons(
    inputId = "unesco_input",
    label = span(icon("globe"), "Unesco"),
    choices = c("All", "yes", "no"),
    inline = TRUE,
    selected = "All"
  )
  
  # hr(class = "break"),
  # checkboxGroupInput(
  #   inputId = "raking_star_input",
  #   label = span(icon("star"), "Raking Star"),
  #   choices = c(1, 2, 3, 4, 5),
  #   selected = c(1, 2, 3, 4, 5)
  # )
)




