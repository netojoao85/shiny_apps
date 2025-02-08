output$selected_region_analysis <- output$selected_region_trend <- output$selected_region_data <- renderText({
  if(!is.null(selected_region())){
    sprintf("%s district", selected_region()) 
  } else {
    return("All Portuguese Districts")
  }
})

output$nr_enterprises_analysis <- output$nr_enterprises_trend <- output$nr_enterprises_data <- renderText({ 
  sprintf("%s Enterprises", nrow(filtered_data())) 
})


output$selected_years_analysis <- output$selected_years_trend <- output$selected_years_data <- renderText({ 
  paste0(input$year_input[1], " - ", input$year_input[2])
})
