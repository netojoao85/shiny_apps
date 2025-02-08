
fluidPage(
  
  div(class = "content_section",
      
      actionButton(class = "option1",
                   inputId = "btn_outPace", 
                   icon = icon("heart-pulse"),
                   width = "100%",
                   HTML("Find out your running pace! <i class='fa-solid fa-chevron-right'></i>")
      ),
      
      actionButton(class = "option2",
                   inputId = "btn_outVelocity", 
                   icon = icon("gauge-simple-high"),
                   width = "100%",
                   HTML("How fast do you have to run? <i class='fa-solid fa-chevron-right'></i>")
      ),
      
      actionButton(class = "option3",
                   inputId = "btn_outPerformance", 
                   icon = icon("stopwatch"),
                   width = "100%", 
                   HTML("Your race performance... <i class='fa-solid fa-chevron-right'></i>")
      )
  )
  
)