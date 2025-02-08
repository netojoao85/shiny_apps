
rve_outPace_kmh <- reactive({

  velocity <- as.numeric(input$slider_velocity)
  distance <- 1

  pace <- distance / velocity
  pace <- pace * 3600
  pace <- str_c(
    formatC(minute(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
    formatC(second(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
    sep = ":")

  sprintf("%s min/km", pace)

})


output$KmhPace <- renderText({
  rve_outPace_kmh ()
})


rve_outPace_miles <- reactive({
  
  velocity <- as.numeric(input$slider_velocity)
  distance <- 1
  
  pace <- (distance/0.6214) / velocity
  pace <- pace * 3600 
  pace <- str_c(
    formatC(minute(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
    formatC(second(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
    sep = ":")
  
  sprintf("%s min/mile", pace)
  
})

output$milesPace <- renderText({
  rve_outPace_miles ()
})



