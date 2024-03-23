sidebarLayout(
  
  sidebarPanel(width = 3,
               
               shinyWidgets::radioGroupButtons(
                 inputId = "option_select",
                 # label = "Select an Option:", 
                 choices = option_list, 
                 justified = TRUE, 
                 direction = "vertical"
               )
      ),
  
  
  
  mainPanel(width = 5,
            
            conditionalPanel(
              condition = "input.option_select == 'Pace'",
              
              div(class = "box",
                  br(),
                  
                  bs_icon(class = "info_icon", "info-circle-fill"), 
                  h4(class = "info_description",
                     "Insert the velocity you will run to know your running
                     pace."),
          
              
              div(class = "box_setup",
                  
                  sliderInput(inputId = "in_velocity", 
                              label = "", 
                              min = 1.0, 
                              max = 30.0, 
                              value = 12.0, 
                              step = 0.1,
                              width = "100%",
                              post = " kmh")
              ),
              
              div(class = "box_results",
                  
                  div(class = "icon_results",
                      bs_icon("bar-chart-fill"),
                  ),
                  
                  div(class = "values_results",
                      h4("Velocity: ",  textOutput("pace_out_velocity", inline = TRUE)),
                      h4("Pace: ", textOutput("pace_out", inline = TRUE))
                  )
              )
            )
  ),
  
  conditionalPanel(
      condition = "input.option_select == 'Velocity'",
    )
)
)