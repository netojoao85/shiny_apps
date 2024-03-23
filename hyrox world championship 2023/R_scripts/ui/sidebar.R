sidebar <- dashboardSidebar(
  
  sidebarMenu(
    id = "tabs",
    
    menuItem(span(bs_icon("zoom-in")," Race Results"), tabName = "race"),
    
    menuItem("Demographic", tabName = "demographic", icon = icon("globe", lib="glyphicon")),
    
    menuItem(span(bs_icon("bar-chart-fill"), " Individual Analysis"), tabName = "analysis"),
    
    conditionalPanel("input.tabs == 'analysis'",
                     div(id = "my_submenu", style = "background-color: black; padding: 5px 5px 10px 5px; border-right: 1px solid black",
                         selectInput(
                           inputId = "select_athlete_list",
                           label = "Athlete:",
                           choices = select_athlete
                         ),
                         selectInput(
                           inputId = "select_station_list",
                           label ="Station:",
                           choices = select_station,
                         ),
                         
                         h5("Statistics Race Times", 
                            style = "text-align: center; margin: 15% 0px 3px 8%; color: grey"),
                         div(style = "margin: 0% 5% 10% 5%; padding: 0px 0px; 
                                                  background-color: black; border-radius: 0px;
                                         
                                                  box-shadow: inset 0px 0px 4px 0px rgba(0, 0, 0, 0.55), 
                                                              inset 0px 0px 7px 0px rgba(0, 0, 0, 0.85);",
                             
                             
                             span(id = "span_mean",
                                  materialSwitch(inputId = "switch_mean",
                                                 label = "Mean", 
                                                 status = "success",
                                                 right = FALSE,
                                                 value = FALSE,
                                                 inline = TRUE, 
                                                 width = "57px"),
                                  textOutput(outputId = "station_mean_value", inline = TRUE)
                             ),
                             
                             br(style = "margin: 0px; padding: 0px"),
                             span(id = "span_median",
                                  materialSwitch(inputId = "switch_median",
                                                 label = "Median",
                                                 status = "danger",
                                                 right = FALSE,
                                                 value = FALSE,
                                                 inline = TRUE,
                                                 width = "57px"),
                                  textOutput(outputId = "station_median_value", inline = TRUE)
                             )
                         )
                     )
    )
  )
)
