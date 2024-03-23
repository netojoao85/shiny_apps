
output$table_faster <- DT::renderDataTable({
  faster_atlhete <- hyrox_ellite_men_tidy %>% 
    
    filter(rank_station == 1,
           !str_detect(station, "Run Total")) %>%
    select(station, name, time)
  
  faster_atlhete %>% 
    datatable(
      options = list(
        lengthChange = FALSE, 
        lengthMenu = list(c(8)),
        pageLength = c(8),
        autoWidth = FALSE,    
        searching = FALSE,    
        ordering = FALSE,      
        paging = TRUE,       
        info = FALSE 
      ) ,
      rownames = FALSE,
      escape = FALSE,
      colnames = c("Station", 
                   "Athlete",
                   as.character(icon("clock", lib = "font-awesome", style = "color: white; font-size: 20px"))
      )) %>% 
    formatStyle(
      columns = c(1:3),
      backgroundColor = "#262626",
      color = "#FFFFFE",
      textAlign = "center",
      verticalAlign = "middle",
      paddingBottom = "1px",
      paddingTop = "1px",
      fontSize   = "16px"
    ) %>% 
    formatStyle(
      columns = c(1),
      backgroundColor = "#323232")
})

