
filtered_data <- reactive({
  
  filtered <- enterprises
  
  if (input$unesco_input != "All") {
    filtered <- filtered[filtered$unesco == input$unesco_input, ]
  }
  
  filtered <- filtered %>% 
    filter(type %in% input$type_enterprise)
  
  
  #-----------------------------------------------------------------------------------
  # if (input$env_certif_input != "All") {
  #   filtered <- filtered[filtered$env_certification == input$env_certif_input, ]
  # }
  # 
  # if (input$qual_certif_input != "All") {
  #   filtered <- filtered[filtered$qual_certification == input$qual_certif_input, ]
  # }
  #-----------------------------------------------------------------------------------
  
  filtered <- filtered %>%
    filter(start_year >= input$year_input[1] & start_year <= input$year_input[2] )

  
  if (!is.null(selected_region())) {
    filtered <- filter(
      filtered,
      district == selected_region() & municipality %in% input$select_municipality
    )
    updatePickerInput(session = session, inputId = "select_municipality", options = list(title = "Select at least one Municipality"))
  } else {
    filtered
  }
  
  return(filtered)
  
})