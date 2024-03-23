

output$tb_athelte_stations <- DT::renderDataTable({
  
  athlete_table_analysis <- hyrox_ellite_men_tidy %>%
    filter(name == input$select_athlete_list,
           !str_detect(station, "[1-8]")) %>%
    select(station, rank_station, time, diff) %>%
    mutate(rank_station = rank_function(rank_station)) %>% 
    mutate(pace_avg = case_when(
      station == "Run Total" ~ hyrox_ellite_men$pace_run[hyrox_ellite_men$name == input$select_athlete_list],
      station == "Ski Erg"   ~ hyrox_ellite_men$ski_avg_500m[hyrox_ellite_men$name == input$select_athlete_list],
      station == "Row"       ~ hyrox_ellite_men$row_avg_500m[hyrox_ellite_men$name == input$select_athlete_list],
      TRUE ~ "-")) %>% 
    relocate(station, rank_station, time, pace_avg, diff) %>% 
    arrange(factor(station, levels =  c("Run Total", stations_list[9:16])))
  
  
  datatable(
    data =  athlete_table_analysis,
    options = list(
      
      # dom = 'Bfrtip',
      # buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
      
      autoWidth = FALSE,     #smart width handling
      searching = FALSE,    #search box above table
      ordering = FALSE,     #whether columns can be sorted
      lengthChange = FALSE, #ability to change number rows shown on page in table
      lengthMenu = FALSE,   #options lengthChange can be changed to
      pageLength = FALSE,   #initial number of rows per page of table
      paging = FALSE,       #whether to do pagination
      info = FALSE          #notes whether or not table is filtered
    ),
    rownames = FALSE,
    selection = "none",
    escape = FALSE,
    colnames = c("",
                 as.character(span(icon("medal", lib = "font-awesome", style = "color: white; font-size: 25px"), 
                                   br(), h5("Rank", style = "margin:0px; padding:0px; color: grey"))),
                 as.character(span(icon("clock", lib = "font-awesome", style = "color: white; font-size: 25px"), 
                                   br(), h5("Time", style = "margin:0px; padding:0px; color: grey"))),
                 as.character(span(icon("heartbeat", lib = "font-awesome", style = "color: white; font-size: 25px"), 
                                   br(), h5("Pace", style = "margin:0px; padding:0px; color: grey"))),
                 as.character(span(icon("stopwatch", lib = "font-awesome", style = "color: white; font-size: 25px"), 
                                   br(), h5("(1) Diff", style = "margin:0px; padding:0px; color: grey")))
    ),
    caption = tags$caption(
      style = "caption-side: bottom; margin-left: 10px; text-align: left; font-size: 14px; color: firebrick", #color: #A8A8A8
      "(1) Diff: Difference for the faster athlete in that station."),
  ) %>% 
    formatStyle(
      columns = c(1:4),
      backgroundColor = '#181818',
      
      
      color = "#FFFFFE",
      fontSize = "16px",
      
      borderTopColor = "white",
      borderTopStyle = "solid",
      borderTopWidth = "1px",
      
      borderBottomColor = "white",
      borderBottomStyle = "solid",
      borderBottomWidth = "1px",
      
      paddingBottom = "10px",
      paddingTop = "10px",
      paddingLeft = "0px",
      textAlign = "center",
      verticalAlign = "middle",
    ) %>% 
    formatStyle(
      columns = c(1),
      textAlign = "left",
      fontWeight = "bold",
      color = "#FFFFFE",
      paddingLeft = "15px",
      borderLeftColor = "white",
      borderLeftStyle = "solid",
      borderLeftWidth = "1px",
    ) %>%
    formatStyle(
      columns = c(5),
      color = "#FFFFFE",
      fontSize = "16px",
      textAlign = "center",
      border = "1px solid white",
      backgroundColor = "firebrick",
      background = styleEqual(c("-", "+"), c("#181818", "firebrick"))
    )
  
})