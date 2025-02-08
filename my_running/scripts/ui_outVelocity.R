
fluidPage(
  
  radioGroupButtons(
    inputId = "id_units",
    label = NULL,
    choices = c("Kmh", "miles"),
    justified = TRUE,
    status = "custom-class"
  ),
  
  
  
  fluidRow(class = "content_section_analysis",
           
           div(class = "analysis_velocity",   
               icon("gauge-simple-high", class = "icon"),
               br(),
               h4("How fast do you have to run?", style = "font-weight: bold; margin-bottom: 0px;"), 
               p("Introduce your running pace target to get the velocity you must run", style = "margin-top:0px; color: grey; text-align: justify;"),
               hr(style = "margin: 5px 0px 30px 0px; border: 1px dashed lightgray"),
               
               sliderInput(inputId = "slider_paceMin", min = 0, max = 20, value = 5, label = NULL, step = 1, ticks = FALSE, post = " min."),
               sliderInput(inputId = "slider_paceSec", min = 0, max = 59, value = 0, label = NULL, step = 1, ticks = FALSE, post = " sec."),
               
               div(style = "text-align: center;",
                   column(width = 6, h2(textOutput("kmVelocity"))),
                   column(width = 6, h2(textOutput("milesVelocity")))
               )
               
               
           )
  )
)


