output$data_continents <- DT::renderDataTable({
  
  hyrox_ellite_men %>% 
    select(rank, name, continent) %>% 
    mutate(rank = rank_function(rank)) %>% 
    datatable(
      options = list(
        autoWidth = FALSE,    #smart width handling
        searching = FALSE,    #search box above table
        ordering = FALSE,      #whether columns can be sorted
        lengthChange = FALSE, #ability to change number rows shown on page in table
        lengthMenu = FALSE,   #options lengthChange can be changed to
        pageLength = 8,   #initial number of rows per page of table
        paging = TRUE,       #whether to do pagination
        info = FALSE          #notes whether or not table is filtered
      ),
      rownames = FALSE,
      selection = "none",
      escape = FALSE,
      colnames = c(paste(as.character(icon("medal", lib = "font-awesome", style = "color: black; font-size: 20px")), " Race Rank"),
                   paste(as.character(icon("running", lib = "font-awesome", style = "color: black; font-size: 20px")), " Athlete"),
                   paste(as.character(icon("globe", lib = "font-awesome", style = "color: black; font-size: 20px")), " Continent"))
    ) %>% 
    formatStyle(
      columns = c(1,3),
      textAlign = "center"
    )
  
  
  
  
  
  
})

output$data_countries <- DT::renderDataTable({
  
  hyrox_ellite_men %>% 
    select(rank, name, country) %>% 
    mutate(rank = rank_function(rank)) %>% 
    datatable(
      options = list(
        autoWidth = FALSE,    #smart width handling
        searching = FALSE,    #search box above table
        ordering = FALSE,      #whether columns can be sorted
        lengthChange = FALSE, #ability to change number rows shown on page in table
        lengthMenu = FALSE,   #options lengthChange can be changed to
        pageLength = 8,   #initial number of rows per page of table
        paging = TRUE,       #whether to do pagination
        info = FALSE          #notes whether or not table is filtered
      ),
      rownames = FALSE,
      selection = "none",
      escape = FALSE,
      colnames = c(paste(as.character(icon("medal", lib = "font-awesome", style = "color: black; font-size: 20px")), " Race Rank"),
                   paste(as.character(icon("running", lib = "font-awesome", style = "color: black; font-size: 20px")), " Athlete"),
                   paste(as.character(icon("map", lib = "font-awesome", style = "color: black; font-size: 20px")), " Country"))
    ) %>% 
    formatStyle(
      columns = c(1,3),
      textAlign = "center"
    )
  
  
})

output$data_age_group <- DT::renderDataTable({
  
  hyrox_ellite_men %>% 
    select(rank, name, age_group) %>% 
    arrange(age_group) %>% 
    mutate(rank = rank_function(rank)) %>% 
    datatable(
      options = list(
        autoWidth = FALSE,    #smart width handling
        searching = FALSE,    #search box above table
        ordering = FALSE,     #whether columns can be sorted
        lengthChange = FALSE, #ability to change number rows shown on page in table
        lengthMenu = FALSE,   #options lengthChange can be changed to
        pageLength = 8,       #initial number of rows per page of table
        paging = TRUE,        #whether to do pagination
        info = FALSE          #notes whether or not table is filtered
      ),
      rownames = FALSE,
      selection = "none",
      escape = FALSE,
      colnames = c(paste(as.character(icon("medal", lib = "font-awesome", style = "color: black; font-size: 20px")), " Race Rank"),
                   paste(as.character(icon("running", lib = "font-awesome", style = "color: black; font-size: 20px")), " Athlete"),
                   paste(as.character(icon("group", lib = "font-awesome", style = "color: black; font-size: 20px")), " Age Group"))
    ) %>% 
    formatStyle(
      columns = c(1,3),
      textAlign = "center"
    )
  
})
