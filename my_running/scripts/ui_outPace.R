
fluidPage(
  
  radioGroupButtons(
    inputId = "id_units",
    label = NULL,
    choices = c("Kmh", "miles"),
    justified = TRUE,
    status = "custom-class"
  ),
  
  #   actionButton(inputId = "info_btn", label = "Info"),
  #   bsTooltip(
  #     id = "info_btn",
  #     title = "Click on the button to open and hide the menu with details about the app & developer.",
  #     trigger = "hover",
  #     placement = "left",
  #     options = list(container = "body")),
  # ),
  
  fluidRow(class = "content_section_analysis", id = "pace",
           
           column(width = 10,
                  h4(
                    icon("heart-pulse"),
                    "Find out your running pace!"
                  ),
                  
                  hr(),
                  p("Introduce the velocity you will run to get your running pace."),
                  sliderInput(inputId = "slider_velocity", min = 5, max = 30, value = 12, label = NULL, step = 0.1, ticks = FALSE, post = " km/h"),
                  
                  div(style = "text-align: center;",
                    column(width = 6, h2(textOutput("KmhPace"))), 
                    column(width = 6, h2(textOutput("milesPace")))
                  )
           ) 
  )
)



