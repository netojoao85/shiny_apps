
# Pop-Up ------------------------------------------------------------------
observeEvent(input$show_popup, {
  
  showModal(modalDialog(
    # title = span(icon("info-circle"), "What about this dataset?", style = "margin-left: 20px"),
    title = "",
    easyClose = FALSE,
    footer = actionButton(
      inputId = "close_popup",
      icon = icon("times"),
      label = "Close"),
    size = "l",
    div(
      class = "popoup_window",
      
      tabsetPanel(
        tabPanel(
          icon = icon("database"), 
          title = "About Dataset",
          includeHTML("www/popup_info_text.html")
        ),
        
        tabPanel(
          icon = icon("user"),
          title = "About Developer",
          
          div(class = "info_window_content", 
              style = "
                    color: black;
                    text-align: center;
                    font-size: 24px;
                    font-weight: bold;
                  ",
              
              h1("João Neto", style = "margin-top:30px"),
              hr(style = "margin:5px 30%"),
              h4("Automation & Control Systems Engineer"),
              h4("Data Scientist"),
              tags$a(
                href="https://www.linkedin.com/in/joaonetoprofile", target="_blank",
                tags$img(src="linkedin_icon.png", alt = "visit me!", style='width:40px; height:40px; justify-content:center')
              )
          )
        )
      )
    )
  )
  )
  
})




#to close pop-uo
observeEvent(input$close_popup, {
  removeModal()
})


# 
# 
# # Toogle Btn in header to Show/Hide Filter Menu -------------------------------------
# 
# observeEvent(input$filter,  {
#   toggle("filter_menu")
# })
# 
# #Btn in the filter to hide filter menu
# observeEvent(input$hide_filter_menu, {
#   hide("filter_menu")
# })