
output$athlete_overall_performance <- renderInfoBox({
  
  overall_performance <- hyrox_ellite_men %>% 
    filter(name == input$select_athlete_list) %>% 
    mutate(rank = rank_function(rank)) %>% 
    select(rank, total_race)
  
  infoBox(title = "Overall Performance",
          value = str_c(overall_performance$rank, "  in  ", overall_performance$total_race),
          icon = icon("hourglass-end", lib = "font-awesome"),
          color = "black",fill = TRUE
  )
})

output$athlete_age_group_info <- renderInfoBox({
  infoBox(title = "Age Group (AG)",
          value = str_c(
            hyrox_ellite_men$age_group[hyrox_ellite_men$name == input$select_athlete_list],
            " | ",
            hyrox_ellite_men$rank_ag[hyrox_ellite_men$name == input$select_athlete_list],
            " AG athletes"
          ),
          icon = icon("group", lib = "font-awesome"),
          color = "black",fill = TRUE
  )
})

output$nationality <- renderInfoBox({
  infoBox(title = "Nationality",
          value = hyrox_ellite_men$country[hyrox_ellite_men$name == input$select_athlete_list],
          icon = icon("map-marker", lib = "glyphicon"),
          color = "black",fill = TRUE
  )
})
