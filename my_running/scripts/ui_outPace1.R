
fluidPage(
  
  radioGroupButtons(
    inputId = "id_units",
    label = NULL,
    choices = c("Kmh", "miles"),
    justified = TRUE,
    status = "custom-class"
  ),
  
  fluidRow(class = "content_section_analysis",
           
           column(width = 10,
                  
                  div(class = "analysis_pace",   
                      icon("heart-pulse", class = "icon"),
                      br(),
                      h4("Find out your running pace!", style = "font-weight: bold; margin-bottom: 0px;"), 
                      p("Introduce the velocity you will run to get your running pace.", style = "margin-top:0px; color: grey; text-align: justify;"),
                      hr(style = "margin: 5px 0px 30px 0px; border: 1px dashed lightgray"),
                      
                      sliderInput(inputId = "id_slicer_velocity", min = 5, max = 30, value = 10, label = NULL, step = 0.1, ticks = FALSE, post = " km/h"),
                      
                      div(style = "color: grey;",
                          column(width = 6, h2("3:40 min/km")),
                          column(width = 6, h2("4 miles/km"))
                          # textOutput("pace_kmh")
                      )
                      
                      
                  )
           )
           
  )
)



