output$table_stats <- DT::renderDataTable({
  my_stats <- station_statistics %>% 
    mutate(diff_mean = mean_time - lag(mean_time, 1),
           diff_mean = if_else(str_detect(station, "[2-8]"),
                               true =  
                                 case_when(
                                   diff_mean > 0 ~ paste0(as.character(icon("caret-up", lib = "font-awesome", style = "color: red; font-size: 20px; padding:0px; margin:0px;" )), abs(diff_mean)),
                                   TRUE ~ paste0(as.character(icon("caret-down", lib = "font-awesome", style = "color: #00BD0C; font-size: 20px; padding:0px; margin:0px;" )), abs(diff_mean))),
                               false = "-"
           ),
           diff_median = median_time - lag(median_time, 1),
           diff_median = if_else(str_detect(station, "[2-8]"),
                                 true =  
                                   case_when(
                                     diff_median > 0 ~ paste0(as.character(icon("caret-up", lib = "font-awesome", style = "color: red; font-size: 20px; padding:0px; margin:0px;" )), abs(diff_median)),
                                     TRUE ~ paste0(as.character(icon("caret-down", lib = "font-awesome", style = "color: #00BD0C; font-size: 20px; padding:0px; margin:0px;" )), abs(diff_median))),
                                 false = "-"
           )) %>% 
    mutate(across(c(2:5), ~seconds_to_period(.x)),
           across(c(2:5), ~str_c(
             formatC(minute(.), digits = 1, format = 'd', flag = "0#"),
             formatC(second(.), digits = 1, format = 'd', flag = "0#"),
             sep = ":"))) %>% 
    relocate(station, faster, slower, mean_time, diff_mean, median_time, diff_median) %>% 
    arrange(factor(station, levels = 
                     c("Run Total", "running 1", "running 2", "running 3", "running 4", 
                       "running 5","running 6", "running 7", "running 8", 
                       "Stations", "Ski Erg", "Sled Push", "Sled Pull", "Burpees",
                       "Row", "Farmers Carry", "Lunges", "Wall Balls"))) %>% 
    mutate(
      diff_mean = case_when(
        station == "Run Total" ~ "",
        TRUE ~ diff_mean),
      
      diff_median = case_when(
        station == "Run Total" ~ "",
        TRUE ~ diff_median)
    )
  
  
  my_stats[nrow(my_stats) + 1, ] <- list("-","", "", "", "", "", "")  
  
  
  
  
  sketch = htmltools::withTags(table(
    class = 'display',
    thead(
      tr(
        th(rowspan = 2, 'Stations'),
        th(rowspan = 2, 'Faster'),
        th(rowspan = 2, 'Slower'),
        th(colspan = 2, 'Mean'),
        th(colspan = 2, 'Median')
      ),
      tr(
        th("Time"),
        th("Diff"),
        th("Time"),
        th("Time")
      )
    )))
  
  
  
  
  datatable(my_stats,
            escape = FALSE,
            rownames = FALSE,
            selection = "none",
            container = sketch,
            
            options = list(
              lengthChange = FALSE,
              lengthMenu = list(c(9,9)),
              pageLength = 9,
              autoWidth = FALSE,
              searching = FALSE,
              ordering = FALSE,
              paging = TRUE,
              info = FALSE
            ),
            colnames = c("Station",
                         "Faster",
                         "Slower",
                         as.character(icon("clock", lib = "font-awesome")),
                         as.character(icon("chart-line", lib = "font-awesome")),
                         as.character(icon("clock", lib = "font-awesome")),
                         as.character(icon("chart-line", lib = "font-awesome")))
  ) %>% 
    formatStyle(
      columns = c(2:7),
      target = "row",
      backgroundColor = "#262626",
      color = "white",
    ) %>%
    formatStyle(
      columns = "station", 
      valueColumns = "station",
      target = "row",
      color = styleEqual(c("Run Total"), c("#FFFFFE")),
      backgroundColor = styleEqual(c("Run Total"), c("#606060")),
      fontWeight = styleEqual(c("Run Total"), c("bold")),
      fontSize   = styleEqual(c("Run Total"), c("22px"))
    ) %>% 
    formatStyle(
      'station',
      backgroundColor = styleEqual(
        c("running 1", "running 2", "running 3", "running 4", 
          "running 5","running 6", "running 7", "running 8", 
          "Ski Erg", "Sled Push", "Sled Pull", "Burpees",
          "Row", "Farmers Carry", "Lunges", "Wall Balls", "-"),
        c("#323232"))
    ) %>% 
    formatStyle(
      columns = c(1:7),
      paddingBottom = "2px",
      paddingTop = "2px",
      fontSize   = "16px",
      textAlign = "center",
      verticalAlign = "middle",
    )
  
})
