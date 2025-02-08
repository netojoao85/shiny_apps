output$trend_plot <- renderPlotly({
  
  data_trend <- filtered_data() %>%
    # filter(type %in% c(input$type_compare)) %>%
    group_by(type, start_year) %>%
    summarise(n = n())

  
  min_y <- as.numeric(min(data_trend$n))
  max_y <- as.numeric(max(data_trend$n))
  
  
  trend_ggplot <- ggplot(data_trend) +
    aes(
      x = start_year, 
      y = n, 
      color = type,
    ) +
    geom_line(size = 1.2) +
    labs(
      title = "", 
      subtitle = "", 
      x = NULL,
      y = NULL
    ) + 
    theme_minimal() +
    theme(
      # legend.title = element_blank(),
      # legend.position = "bottom",
      # legend.text = element_text(size = 14),
      # panel.grid.major = element_blank(),
      # axis.text.x = element_text(color = "black", angle = 0, size = 14),  
      # axis.text.y = element_text(color = "black", size = 14),
    ) +
    scale_x_continuous(breaks = seq(1950, 2024, 10)) +
    scale_y_continuous(limits = c(min_y, max_y)) +
    scale_color_discrete(labels = names(my_type))
  
ggplotly(trend_ggplot) %>%
  config(displayModeBar = FALSE) %>%
  layout(
    hovermode = "x unified",
    legend = list(
      orientation = "h",
      y = -0.1,
      title = list(text = "")
    ),
    xaxis = list(
      title ="",
      tickfont = list(size = 14, color = "black"),
      showline = FALSE,
      tickmode = "auto",
      nticks = 10,
      showgrid = "major"
    ),
    yaxis = list(
      title ="",
      tickfont = list(size = 14, color = "black"),
      showline = FALSE,
      zeroline = FALSE,
      tickmode = "auto",
      nticks = 10,
      showgrid = "major"
    )
  )

  
})





