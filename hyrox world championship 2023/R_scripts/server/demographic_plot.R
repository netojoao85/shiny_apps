
plot_dempgraphic_theme <- reactive({

    theme_minimal() +
    theme(
      panel.grid = element_blank(),
      legend.position = "none",
      plot.title = element_text(color = "#FFED00", face = "bold", vjust = 0),
      plot.background = element_rect(fill = "#262626", colour = "#262626"),
      axis.text.x = element_text(color = "#FFFFFE", size = 12),
      axis.text.y = element_blank(),
      axis.ticks.x = element_line(size = 0.6, color = "#FFED00"),
      axis.ticks.length.x = unit(0.15, "cm")
  
        )

  })

output$plot_demographic_continents <- renderPlot(
  
  demographic_continent %>%
    ggplot() +
    aes(x = reorder(continent, -count),
        y = count,
        fill = count == max(count)) +
    geom_col() +
    scale_fill_manual(values = c("grey30", "#FFED00")) +
    geom_text(aes(
      label = str_c(count, if_else(count == 1, " athlete", " athletes"),"\n", percent)),
      vjust = -0.3, size = 3.5, color = "#FFFFFE") +
    labs(x = NULL, y = NULL) +
    ylim(0, max(demographic_continent$count) + 0.4) + 
    plot_dempgraphic_theme()
)


output$plot_demographic_countries <- renderPlot(
  
  demographic_country %>%
    ggplot() +
    aes(x = reorder(country, -count),
        y = count,
        fill = count == max(count)) +
    geom_col() +
    scale_fill_manual(values = c("grey30", "#FFED00")) +
    geom_text(aes(
      label = str_c(count, if_else(count == 1, " athlete", " athletes"),"\n", percent)),
      vjust = -0.3, size = 3.5, color = "#FFFFFE") +
    labs(x = NULL, y = NULL) +
    ylim(0, max(demographic_country$count) + 0.4) +
    plot_dempgraphic_theme()
)


output$plot_demographic_age_groups <- renderPlot(
  
  demographic_age_group %>%
    ggplot() +
    aes(x = reorder(age_group, -count),
        y = count,
        fill = count == max(count)) +
    geom_col() +
    scale_fill_manual(values = c("grey30", "#FFED00")) +
    geom_text(aes(
      label = str_c(count, if_else(count == 1, " athlete", " athletes"),"\n", percent)),
      vjust = -0.3, size = 3.5, color = "#FFFFFE") +
    labs(x = NULL, y = NULL) +
    ylim(0, max(demographic_age_group$count) + 0.4) +
    plot_dempgraphic_theme()
)