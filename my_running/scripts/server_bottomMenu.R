observeEvent(input$btn_home, {
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_home.R"), local = TRUE)$value
  })
})

observeEvent(input$btn_info, {
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_info.R"), local = TRUE)$value
  })
})

observeEvent(input$btn_question, {
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_question.R"), local = TRUE)$value
  })
})

observeEvent(input$btn_linkedin, {
  output$contentPage <- renderUI({
    source(here::here("scripts/ui_linkedin.R"), local = TRUE)$value
  })
})