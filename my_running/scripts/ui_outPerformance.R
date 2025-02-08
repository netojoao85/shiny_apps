
fluidPage(
  
  radioGroupButtons(
    inputId = "id_units",
    label = NULL,
    choices = c("Kmh", "miles"),
    justified = TRUE,
    status = "custom-class"
  ),
  
  
  
  fluidRow(class = "content_section_analysis",
           
           div(class = "analysis_performace",   
               icon("stopwatch", class = "icon"),
               br(),
               h4("How fast do you have to run?", style = "font-weight: bold; margin-bottom: 0px;"), 
               p("Introduce the distance and time of your running to get your performance...", style = "margin-top:0px; color: grey; text-align: justify;"),
               hr(style = "margin: 5px 0px 30px 0px; border: 1px dashed lightgray"),
               
               div(
               column(width = 6,
                      sliderInput(inputId = "id_slicer_perfMin", min = 0, max = 42, value = 5, label = NULL, step = 1, ticks = FALSE, post = " kms"),
                      ), 
               
               column(width = 6,
                      sliderInput(inputId = "id_slicer_perfSec", min = 0, max = 900, value = 0, label = NULL, step = 100, ticks = FALSE, post = " meters"),
                      )
               ),
               
               div(
                 column(width = 4, numericInput(inputId = "in_hours", label = "hours", min = 0, max = 48, value = 0)),
                 column(width = 4, numericInput(inputId = "in_min", label = "min.", min = 0, max = 59, value = 0)),
                 column(width = 4, numericInput(inputId = "in_sec", label = "sec.", min = 0, max = 59, value = 0))
               ),
               
               div(style = "color: grey;",
                   column(width = 6, h2("2:40 min/km")),
                   column(width = 6, h2("3:10 miles/km"))
                   # textOutput("pace_kmh")
               )
               
               
           )
  )
)


