## Switch's ----------------------------------------------------------------

run_mean_line <- reactive(
  if (input$switch_mean){
    geom_line(
      aes(x = station, y = mean_time),
      group = 1, size = 1.5, color = "#00A65A", linetype = "dashed")
  }
)

mean_values <- reactive(
  if (input$switch_mean ){
    
    if(input$select_station_list == "Running"){
      value <- station_statistics$mean_time[station_statistics$station == "Run Total"]
    } else {
      value <- station_statistics$mean_time[station_statistics$station == input$select_station_list]
    }
    
    value_mean <- str_c(
      formatC(minute(seconds_to_period(value)), digits = 1, format = 'd', flag = "0#"),
      ":",
      formatC(second(seconds_to_period(value)), digits = 1, format = 'd', flag = "0#"),
      " (min:sec)")
  }
)


median_values <- reactive(
  if (input$switch_median){
    
    if(input$select_station_list == "Running"){
      value <- station_statistics$median_time[station_statistics$station == "Run Total"]
    } else {
      value <- station_statistics$median_time[station_statistics$station == input$select_station_list]
    }
    
    
    value_median <- str_c(
      formatC(minute(seconds_to_period(value)), digits = 1, format = 'd', flag = "0#"),
      ":",
      formatC(second(seconds_to_period(value)), digits = 1, format = 'd', flag = "0#"),
      " (min:sec)")
  })




run_median_values <- reactive(
  if (input$switch_median){
    
    geom_label(aes(x = station, y = 0, 
                   label = str_c(
                     formatC(minute(seconds_to_period(mean_time)), digits = 1, format = 'd', flag = "0#"),
                     formatC(second(seconds_to_period(mean_time)), digits = 1, format = 'd', flag = "0#"),
                     sep = ":"
                   )), fill = "#DD4B39", color = "#FFFFFE", size = 5, vjust = 0.0, hjust = 0.0)
  }
)

run_median_line <- reactive(
  if (input$switch_median){
    geom_line(
      aes(x = station, y = median_time), 
      group = 1, size = 1.5, color = "#DD4B39", linetype = "dashed")
  }
)

mean_line <- reactive(
  if (input$switch_mean){
    geom_hline(
      yintercept = station_statistics$mean_time[station_statistics$station == station_selected()],
      linetype = "longdash", 
      size = 2, 
      color = "#00A65A"
    ) 
  }
)

median_line <- reactive(
  if (input$switch_median){
    geom_hline(
      yintercept = station_statistics$median_time[station_statistics$station == station_selected()],
      linetype = "longdash", 
      size = 2, 
      color = "#DD4B39"
    )
  }
)


output$station_mean_value <- renderText({ 
  mean_values()
})


output$station_median_value <- renderText({ 
  median_values()
})