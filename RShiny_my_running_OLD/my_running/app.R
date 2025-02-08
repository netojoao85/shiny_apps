library(tidyverse)
library(shiny)
library(bsicons)
library(rsconnect)
library(bslib)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  
  # .css style --------------------------------------------------------------
  tags$style(
    
    "body {background: white}",
    
    ## aside_bar ---------------------------------------------------------------
    
    "#aside_bar {
                 float:left;
                 width:10%; 
                 height: 100vh;
                 background: #262626; 
                 padding: 0px;
                 margin: 0px 0px 0px -15px;
                }",
    
    "#title {
             margin: 0px;
             color: #ABABAB;
             letter-spacing: 3px;
             padding: 10px 10px 0px 10px;
             text-align: center;
             font-weight: bold;
          }",
    
    ".hr_title {
                margin-top: 5px; 
                margin-bottom: 5px;
                border: 1 solid black;
                width: 25%;
               }",
    
    
    ## main page ---------------------------------------------------------------
    
    "#main_page {
                 float: left;
                 width:90%;
                 margin: 20px 0px 0px 0px;
                 border-width: 0px;
                 padding: 0px;
                 border-radius: 0px;
                 background: white;
                }",
    
    
    ### box ---------------------------------------------------------------------
    
    ".my_box {
              float: left;
              margin: 0px 0px 0px 10px;
              height: 420px;
              padding: 0px;
              border-radius: 30px;
              box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.5);
              width: 32%;
             }",
    
    
    ##### box_aside ---------------------------------------------------------------
    
    ".box_aside { 
                 width: 25%;
                 float: left;
                 margin: 0px,
                 padding: 0px;
                 height: 100%;
                 border-radius: 30px 0px 0px 30px;
                 color: white;
                }",
    
    ".icon_box_aside {
                      margin: 0px; 
                      padding: 20px 25% 7px 25%; 
                      color: white;
                      font-size: 50px;
                      width: 98.35px;
                      # height: 75px;
                     }",
    
    ".icon_box_aside_bsicon {
                             margin:0px; 
                             padding: 20px 25% 5px 25%; 
                             color: white; 
                             font-size: 100px;
                            }",
    
    ".title_box_aside {
                      margin: 0px;
                      padding-top: 0px;
                      text-align: center;
                      }",
    
    
    #### box_body ----------------------------------------------------------------
    
    
    ".box_body {
                float: left;
                width: 75%;
                height: 100%;
                color: white;
                margin: 0px 0px 0px 0px;
                padding: 0px 0px 0px 0px;
                border-radius: 0px 30px 30px 0px;
              }",
    
    
    #### box_body_setup ----------------------------------------------------------
    
    ".box_body_setup {
                        margin: 20px 10px 0px 10px;                        
                        height: 260px;
                       }",
    
    ".box_body_setup_options {
                                margin: 0px 0px 0px 20px;
                               }",
    
    
    ".setup_options_distance {
                                float: left;
                                width: 45%;
                                margin: 0px;
                                padding: 0px;
                               }",
    
    ".setup_options_time {
                          float: left;
                          width: 30%;
                          margin: 0px;
                          padding: 0px;
                        }",
    
    ".time_result_out {
                       margin: 7px 0px 0px 0px; 
                       padding: 0px 0px 0px 0px;
                      }",
    
    
    
    #### box_result --------------------------------------------------------------
    
    ".box_body_result {
                         margin: 0px 35px 0px 25px;
                         height: 120px;
                         box-shadow: rgba(0, 0, 0, 0.1) 0px 4px 6px -1px, 
                                     rgba(0, 0, 0, 0.06) 0px 2px 4px -1px;
                         border-radius: 5px;
                        }",
    
    ".box_body_result_icon {
                              float: left;
                              width: 10%; 
                              margin: 0px 0px 0px 0px;
                              padding: 8px 0px 0px 10px;
                              font-size: 16px;    
                             }",
    
    ".box_body_result_labels {
                                float: left;
                                width: 30%; 
                                padding: 3px 0px 0px 10px;
                               }",
    
    ".box_body_result_values {
                                float: left;
                                width: 60%; 
                                padding: 3px 0px 0px 30px;
                               }",
    
    
    
    #### icons -------------------------------------------------------------------
    
    ".icon_info {
                 float: left;
                 margin:2px 7px 55px 0px; 
                 font-size: 14px; 
                }",
    
    
    
    #### widgets -----------------------------------------------------------------
    
    
    ###### Slider ------------------------------------------------------------------
    
    ".shiny-input-container {
                             margin-bottom: 0px; 
                             height: 55px
                            }",
    
    ".irs-min {visibility:hidden !important;}",
    ".irs-max {visibility:hidden !important;}",
    
  ),
  
  
  # aside_bar ---------------------------------------------------------------
  div(id = "aside_bar",
      h1(icon("running", lib = "font-awesome"), style = "color: #ABABAB; text-align: center;"),
      hr(class = "hr_title"),
      h4(id = "title", "My Running"),
  ),
  
  
  
  # main page  --------------------------------------------------------------
  
  div(id = "main_page",
      
      
      
      ## Box Pace ----------------------------------------------------------------
      
      div(class = "my_box",
          
          div(class = "box_aside", style = "background: #1B3245",
              icon(class = "icon_box_aside", name = "heartbeat", lib = "font-awesome"),
              h4  (class = "title_box_aside", "Pace"),
              
          ), # End my_box_aside
          
          
          div(class = "box_body", style = "background: #2B4F6E",
              div(class = "box_body_setup",
                  div(class = "box_body_setup_info",
                      p(class = "info_my_box", 
                        bsicons::bs_icon(class = "icon_info", "info-circle-fill"),
                        "Insert the velocity you will run to know your running pace."),
                  ),
                  div(class = "box_body_setup_options",
                      sliderInput(inputId = "in_velocity", 
                                  label = "", 
                                  min = 1.0, 
                                  max = 40.0, 
                                  value = 12.0, 
                                  step = 0.1,
                                  width = "90%",
                                  post = " kmh")
                  )
              ), # End my_box_setup
              
              
              div(class = "box_body_result", style = "background: #396891",
                  column(width = 12,
                         div(class = "box_body_result_icon",
                             bs_icon("bar-chart-fill"),
                         ),
                         div(class = "box_body_result_labels",
                             h4("Velocity:"),
                             h4("Pace:"),
                         ),
                         div(class = "box_body_result_values",
                             h4(textOutput("pace_out_velocity")),
                             h4(textOutput("pace_out"), style = "font-weight: bold")
                         )
                  )
                  
              ) #End my_box_body_result
              
              
          ), # End my_box_body
          
          
      ), #End my_box
      
      
      
      ## Box Velocity ------------------------------------------------------------
      
      div(class = "my_box",
          div(class = "box_aside", style = "background: #991D1D",
              bsicons::bs_icon(class = "icon_box_aside_bsicon", "speedometer"),
              h4  (class = "title_box_aside", "Velocity"),
              
          ), # End my_box_aside
          
          
          div(class = "box_body", style = "background: #C90000",
              div(class = "box_body_setup",
                  div(class = "box_body_setup_info",
                      p(class = "info_my_box", 
                        bsicons::bs_icon(class = "icon_info", "info-circle-fill"),
                        "Insert your running pace target to know the velocity you must run."),
                  ),
                  div(class = "box_body_setup_options",
                      sliderInput(inputId = "in_min",label = "", min = 1, max = 15, value = 5, step = 1, ticks = FALSE, post = " min.", width = "85%"),
                      sliderInput(inputId = "in_sec",label = "", min = 0, max = 59, value = 0, step = 1, ticks = FALSE, post = " sec.", width = "85%"),
                  )
              ), # End my_box_setup
              
              
              div(class = "box_body_result", style = "background: #E80000",
                  div(class = "box_body_result_icon",
                      bs_icon("bar-chart-fill"),
                  ),
                  div(class = "box_body_result_labels",
                      h4("Pace:"),
                      h4("Velocity:"),
                  ),
                  div(class = "box_body_result_values",
                      h4(textOutput("velocity_out_pace")),
                      h4(textOutput("velocity_out"), style = "font-weight: bold")
                  )
              ) #End my_box_body_result
              
              
          ), # End my_box_body
          
          
      ), #End my_box
      
      
      
      ## Box Time ----------------------------------------------------------------
      
      div(class = "my_box",
          
          div(class = "box_aside", style = "background: #283D19",
              icon(class = "icon_box_aside", name = "stopwatch", lib = "font-awesome"),
              h4  (class = "title_box_aside", "Time"),
              
          ), # End my_box_aside
          
          
          div(class = "box_body", style = "background: #3E5F27",
              div(class = "box_body_setup", 
                  div(class = "box_body_setup_info",
                      p(class = "info_my_box", 
                        bsicons::bs_icon(class = "icon_info", "info-circle-fill"),
                        "Insert the distance and time you desire to complete your running. The result is the velocity & pace you should run."),
                  ),
                  div(class = "box_body_setup_options",
                      
                      fluidRow(
                        div(class = "setup_options_distance", 
                            sliderInput(inputId = "in_distance_km",
                                        label = "",
                                        min = 0,
                                        max = 42.0,
                                        value = 5, 
                                        width = "80%",
                                        ticks = FALSE,
                                        post = " kms")
                        ),
                        div(class = "setup_options_distance",
                            sliderInput(inputId = "in_distance_meters",
                                        label = "",
                                        min = 0,
                                        max = 900,
                                        value = 0, 
                                        step = 100, 
                                        width = "80%", 
                                        ticks = FALSE, 
                                        post = " meters")
                        )
                      ),
                      
                      fluidRow(style = "margin: 30px 0px 0px 7px",
                               div(class = "setup_options_time",
                                   numericInput(inputId = "in_time_hours",
                                                label = "hours", 
                                                min = "00", 
                                                max = "48",
                                                value = "00",  
                                                width = "90%")
                               ),
                               div(class = "setup_options_time",
                                   numericInput(inputId = "in_time_min",
                                                label = "min.",
                                                min = "00", 
                                                max = "59",
                                                value = "25", 
                                                width = "90%")
                               ),
                               div(class = "setup_options_time",
                                   numericInput(inputId = "in_time_sec",
                                                label = "sec.",
                                                min = "00", 
                                                max = "59",
                                                value = "00", 
                                                width = "90%")
                               )
                      ),
                      br(),
                      br(),
                      br(),
                      br(),
                  )
              ), # End my_box_setup
              
              
              div(class = "box_body_result", style = "background: #4E7831",
                  
                  div(class = "box_body_result_icon",
                      bs_icon("bar-chart-fill"),
                  ),
                  div(class = "box_body_result_labels",
                      h4(class = "time_result_out",  "Distance:"),
                      h4(class = "time_result_out", "Time:"), 
                      h4(class = "time_result_out", "Pace:",      style = "font-weight: bold"),
                      h4(class = "time_result_out", "Velocity:",  style = "font-weight: bold")
                  ),
                  div(class = "box_body_result_values",
                      h4(class = "time_result_out", textOutput("time_out_distance")),
                      h4(class = "time_result_out", textOutput("time_out_time")),
                      h4(class = "time_result_out", textOutput("time_out_pace"),     style = "font-weight: bold"),
                      h4(class = "time_result_out", textOutput("time_out_velocity"), style = "font-weight: bold")
                  )
              ) #End my_box_body_result
              
              
          ), # End my_box_body
          
          
      ) #End my_box
      
      
      
  ) # End main_page
  
  
  
)





# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  # Reactive ----------------------------------------------------------------
  
  in_velocity_out_pace <- reactive({
    
    velocity <- as.numeric(input$in_velocity)
    distance <- 1
    
    pace <- distance / velocity
    pace <- pace * 3600
    pace <- str_c(
      formatC(minute(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"), 
      formatC(second(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
      sep = ":")
    
    sprintf("%s / km", pace) 
    
  })
  
  
  pace <- reactive ({
    
    min <- formatC(input$in_min, digits = 1, format = 'd', flag = "0#")
    sec <- formatC(input$in_sec, digits = 1, format = 'd', flag = "0#")
    
    pace <- str_c(min, sec, sep = ":")
    pace
    
  })
  
  
  
  box_time_distance <- reactive ({
    
    kms    <- input$in_distance_km
    meters <- input$in_distance_meters
    
    distance <- as.numeric(str_c(kms, meters, sep = "."))
    
  })
  
  
  box_time_time <- reactive ({
    h <- as.numeric(input$in_time_hours) * 3600
    m <- as.numeric(input$in_time_min) *60
    s <- as.numeric(input$in_time_sec)
    
    # time <- str_c(h, m, s, sep = ":")
    
  })
  
  
  
  
  
  
  
  
  
  # outputs --------------------------------------------------------------------
  
  ## Pace --------------------------------------------------------------------
  
  output$pace_out_velocity <- renderText({
    
    velocity <- as.numeric(input$in_velocity)
    sprintf("%s kmh", velocity) 
    
  })
  
  output$pace_out <- renderText({
    
    in_velocity_out_pace()
    
  })
  
  
  ## Velocity ----------------------------------------------------------------
  
  output$velocity_out_pace <- renderText({
    
    sprintf("%s / km", pace()) 
  })
  
  
  output$velocity_out <- renderText({
    
    distance <- as.numeric(1)
    pace     <- as.duration(ms(pace()))
    
    time     <- (as.numeric(pace) * distance) / 3600
    velocity <- distance / time
    velocity <-formatC(velocity, digits = 2, format = 'f', flag = "##")
    
    sprintf("%s kmh", velocity) 
    
    
  })
  
  
  
  ## Time ---------------------------------------------------------------------
  
  output$time_out_distance <- renderText ({
    
    kms    <- input$in_distance_km
    meters <- input$in_distance_meters
    
    
    case_when(
      (kms > 0  & meters == 0) ~ str_c(kms, " kms"),
      (kms == 0 & meters > 0)  ~ str_c(meters, " meters"),
      (kms == 0 & meters == 0) ~ str_c("0.0"),
      TRUE                   ~ str_c(kms, " Km ", meters, " m."))
    
  })
  
  
  output$time_out_time <- renderText ({
    
    h <- formatC(as.numeric(input$in_time_hours), digits = 1, format = 'd', flag = "0#")
    m <- formatC(as.numeric(input$in_time_min), digits = 1, format = 'd', flag = "0#")
    s <- formatC(as.numeric(input$in_time_sec), digits = 1, format = 'd', flag = "0#")
    
    time <- str_c(h, m, s, sep = ":")
    
  })
  
  
  output$time_out_pace <- renderText ({
    
    h <- as.numeric(input$in_time_hours) * 3600
    m <- as.numeric(input$in_time_min) *60
    s <- as.numeric(input$in_time_sec)
    
    kms    <- input$in_distance_km
    meters <- input$in_distance_meters / 100
    distance <- as.numeric(str_c(kms, meters, sep = "."))
    
    velocity <- (distance / ((h + m + s) / 3600))
    
    pace <- (distance / velocity) * 3600
    pace <- str_c(
      formatC(minute(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
      formatC(second(seconds_to_period(pace / distance)),  digits = 1, format = 'd', flag = "0#"),
      sep = ":")
    
    sprintf("%s / km", pace)
    
  })
  
  
  output$time_out_velocity <- renderText ({
    
    h <- as.numeric(input$in_time_hours) * 3600
    m <- as.numeric(input$in_time_min) *60
    s <- as.numeric(input$in_time_sec)
    
    kms    <- input$in_distance_km
    meters <- input$in_distance_meters / 100
    distance <- as.numeric(str_c(kms, meters, sep = "."))
    
    velocity <- (distance / ((h + m + s) / 3600))
    
    velocity <- formatC(velocity, digits = 2, format = 'f', flag = "##")
    
    sprintf("%s kmh", velocity) 
    
    
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
