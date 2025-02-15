library(RColorBrewer)

output$sentiment <- renderPlotly({
  
  blues_palette <- brewer.pal(10, "Purples")
  
  sentiment <- filtered_data() %>% 
    count(sentiment_nrc, sort = TRUE) %>% 
    mutate(sentiment_nrc = factor(sentiment_nrc, levels = sentiment_nrc))
  
  
  plot <- plot_ly(
    data = sentiment, 
    x = ~sentiment_nrc, 
    y = ~n, 
    color = ~sentiment_nrc, 
    colors = rev(blues_palette)
    )
  
  plot <- plot %>% 
    config(displayModeBar = FALSE) %>% 
    layout(
      showlegend = FALSE,
      yaxis = list(title = "", showgrid = FALSE, showticklabels = FALSE),
      xaxis = list(
        title = "", 
        tickangle = 45,
        tickfont = list(size = 12, color = "black"),
        categoryorder = "array",  # Ensure categories are ordered as they appear in data
        categoryarray = ~location  # Use the order of locations as specified in the data
        ),
      autosize = TRUE,
      margin = list(
        l = 0,  # Left margin
        r = 0,  # Right margin
        b = 0, # Bottom margin
        t = 10   # Top margin
      )
    )
  
  plot
  
})
