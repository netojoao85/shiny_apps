
# Reactive ----------------------------------------------------------------

in_velocity_out_pace <- reactive({
  
  velocity <- as.numeric(input$in_velocity)
  distance <- 1
  
  pace <- distance / velocity
  pace <- pace * 3600
  pace <- str_c(
    formatC(minute(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"), 
    formatC(second(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
    sep = ":")
  
  sprintf("%s / km", pace) 
  
  })



# Outputs -----------------------------------------------------------------
output$pace_out_velocity <- renderText({
    velocity <- as.numeric(input$in_velocity)
    sprintf("%s kmh", velocity) 
    })


output$pace_out <- renderText({
    in_velocity_out_pace()
    })