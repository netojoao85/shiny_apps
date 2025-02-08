selected_data <- reactive({
  
  x <- filtered_data()
  
  #names(x) <- table_names
  
  x <- x[, input$select_data, drop = FALSE]
  
})


output$table_summary <- renderDT({
  
  selected_data() %>% 
    datatable(
      options = list(scrollX = TRUE),
      filter = "top",
      rownames = FALSE
      # colnames = table_var
    )
  # formatStyle(
  #   names(filtered_data())[sapply(filtered_data(), is.numeric)],
  #   textAlign = "center"
  # )
})


# download button
output$download_data <- downloadHandler(
  filename = function() {
    paste("tourist_enterprises_portugal_",Sys.time(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(selected_data(), file)
  }
)


observeEvent(input$select_all_var, {
  updateCheckboxGroupInput(session, "select_data", selected = my_vars)
})

observeEvent(input$remove_var, {
  updateCheckboxGroupInput(session, "select_data", selected = my_vars[1])
})





