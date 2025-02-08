
# input pace --------------------------------------------------------------
pace <- reactive ({
  min <- formatC(input$slider_paceMin, digits = 1, format = 'd', flag = "0#")
  sec <- formatC(input$slider_paceSec, digits = 1, format = 'd', flag = "0#")
  pace <- str_c(min, sec, sep = ":")
  
})


# Kmh Output ----------------------------------------------------------------

rve_outVel_kmh <- reactive({
  distance <- as.numeric(1)
  pace     <- as.duration(ms(pace()))
  time     <- (as.numeric(pace * distance)) / 3600
  
  velocity <- (distance / time)
  velocity <- formatC(velocity, digits = 2, format = 'f', flag = "##")
  sprintf("%s kmh", velocity)
})

output$kmVelocity <- renderText({
  rve_outVel_kmh ()
})



# Miles Output ---------------------------------------------------------------

rve_outVel_miles <- reactive({
  distance <- as.numeric(1)
  pace     <- as.duration(ms(pace()))
  time     <- (as.numeric(pace * distance)) / 3600
  
  velocity <- (distance / time) * 0.621
  velocity <- formatC(velocity, digits = 2, format = 'f', flag = "##")
  sprintf("%s mph", velocity)
})

output$milesVelocity <- renderText({
  rve_outVel_miles ()
})
