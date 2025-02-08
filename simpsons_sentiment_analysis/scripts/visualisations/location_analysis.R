output$location_analysis <- renderPlotly({
  
  top_location <- filtered_data() %>% 
    group_by(location, sentiment_bing) %>%
    summarise(n = n()) %>%
    pivot_wider(names_from = sentiment_bing, values_from = n) %>%
    mutate(
      total = negative + positive,
      perc_pos = positive / total,
      perc_neg = negative / total
    ) %>%
    drop_na() %>%
    arrange(desc(total)) %>%
    head(50)
  
  
  if (input$in_loc_sort == "Positive") {
    top_location <- top_location %>% 
      arrange(desc(perc_neg)) %>%
      mutate(location = factor(location, levels = location))
      
  } else {
    top_location <- top_location %>% 
      arrange(desc(perc_pos)) %>%
      mutate(location = factor(location, levels = location))
  }
  
  
  plot_ly(top_location, y = ~location) %>%
    add_trace(x = ~round(negative / total, 3), name = "negative", type = "bar", orientation = "h", marker = list(color = '#F2767B')) %>% #'#E8CA00'
    add_trace(x = ~round(positive / total, 3), name = "positive", type = "bar", orientation = "h", marker = list(color = '#72CBD0')) %>% 
    config(displayModeBar = FALSE) %>%
    layout(
      showlegend = FALSE,
      barmode = "stack",
      yaxis = list(
        title = "",
        showline = FALSE,
        showgrid = FALSE,
        categoryorder = "array",  # Ensure categories are ordered as they appear in data
        categoryarray = ~location # Use the order of locations as specified in the data
      ),
      xaxis = list(
        title = "",
        showticklabels = FALSE,
        showline = FALSE,
        showgrid = FALSE
      ),
      margin = list(
        l = 0,  # Left margin
        r = 0,  # Right margin
        b = 0, # Bottom margin
        t = 0   # Top margin
      )
    )
  
})
