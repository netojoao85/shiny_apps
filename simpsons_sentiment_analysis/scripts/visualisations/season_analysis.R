output$season_analysis <- renderPlotly({
  
  if (character_state$current_character == "character") {
    
    season_pos <- filtered_data() %>% 
      filter(sentiment_bing == "positive") %>%
      group_by(character, season) %>% 
      summarise(count_pos = n())
    

    season_neg<- filtered_data() %>% 
      filter(sentiment_bing == "negative") %>%
      group_by(character, season) %>% 
      summarise(count_neg = n())
      
  } else {
    
    season_pos <- filtered_data() %>% 
      filter(sentiment_bing == "positive") %>% 
      group_by(season) %>% 
      summarise(count_pos = n())
    
    season_neg <- filtered_data() %>% 
      filter(sentiment_bing == "negative") %>%
      group_by(season) %>% 
      summarise(count_neg = n())
  }
  
  
  
  
  season_plot <- plot_ly(x = ~season_pos$season, y = ~season_pos$count_pos, 
          type = "scatter", 
          mode = "lines", 
          fill = "tozeroy", 
          name = "Positive",
          fillcolor = "rgba(114, 203, 208, 1.0)",
          line = list(color = "#21A3A4", width = 2, dash = 'solid')) %>%    # dash = "dash", "dot", "solid"
    add_trace(x = ~season_neg$season, y = ~season_neg$count_neg,
              name = "Negative",
              opacity = 0.2,
              line = list(color = "#FF0000", width = 2, dash = 'solid'),
              fillcolor = "rgba(242, 118, 123, 0.1)")
              # fillcolor = "rgba(232, 202, 0, 0.1)")

  season_plot %>% 
    config(displayModeBar = FALSE) %>%
    layout(
      showlegend = TRUE,
      legend = list(
        orientation = "h",
        y = -0.1,
        x = 0.40,
        title = list(text = "")
      ),
      hovermode = "x unified",
      yaxis = list(
        title = "",
        showgrid = FALSE,
        showticklabels = FALSE
      ),
      xaxis = list (
        title = "",
        showgrid = FALSE,
        tickmode = "auto",
        nticks = 26
      ),
      margin = list(
        l = 0,  # Left margin
        r = 0,  # Right margin
        b = 0, # Bottom margin
        t = 5   # Top margin
      )
    )

})
