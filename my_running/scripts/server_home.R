
observeEvent(input$btn_outPace, {
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_outPace.R"), local = TRUE)$value
  })
})


observeEvent(input$btn_outVelocity, {
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_outVelocity.R"), local = TRUE)$value
  })
}) 


observeEvent(input$btn_outPerformance, {
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_outPerformance.R"), local = TRUE)$value
  })
}) 