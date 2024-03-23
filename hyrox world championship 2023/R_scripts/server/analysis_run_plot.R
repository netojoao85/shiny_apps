
plot_station <- reactive({
  if(input$select_station_list == "Running"){
    plot <- hyrox_ellite_men_tidy %>%
      filter(name == input$select_athlete_list,
             str_detect(station, "running")) %>%
      ggplot() +
      geom_line(aes(x = station, y = time_as_duration), group = 1, size = 2.5, color = "#FFED00") +
      geom_point(aes(x = station, y = time_as_duration, 
                     fill = if_else(
                       condition =  rank_station == 1,
                       true = "seagreen",
                       false = "#FFED00")),
                 color = "#262626", size = 15, shape = 21) +
      geom_text(aes(x = station, y = time_as_duration,
                    label = time),
                size = 7, vjust = -2.0, hjust = 0.6, 
                color = "#FFFFFE") +
      geom_text(aes(x = station, y = time_as_duration, label = rank_function(rank_station),
                    size = 10,
                    color = if_else(
                      condition =  rank_station == 1,
                      true = "#FFFFFE",
                      false = "black"
                    ))) +
      scale_color_identity() +
      scale_fill_identity() + 
      labs(x = NULL, y = NULL, title = NULL, subtitle = NULL) +
      scale_y_time(labels = label_time(format = '%M:%S'),
                   breaks = seq(min(scale_run()), max(scale_run())),
                   limits = c(min(scale_run()),  max(scale_run() + 7))) +
      theme_minimal() +
      theme(
        plot.background = element_rect(fill = "#262626", color = "#262626"),
        # axis.text = element_text(color = "#FFFFFE", size = 15),
        axis.text.y = element_blank(),
        axis.text.x = element_text(color = "#FFFFFE", size = 15),
        plot.title = element_text(color = "#FFFFFE",face = "bold", vjust = -1, hjust = -0.06, size = 18),
        plot.subtitle = element_text(color = "grey80", vjust = -1),
        panel.grid.major.x = element_line(size = 0.1, color = "grey40", linetype = "longdash"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks.x = element_line(size = 1, color = "#FFED00"),
        axis.ticks.length.x = unit(0.2, "cm"),
        legend.position = "none",
        axis.title.y = element_text(vjust = 3, color = "#FFFFFE")
      ) +
      run_mean_line() +
      run_median_line()
    
  }else if (input$select_station_list != "Running"){
    plot <- hyrox_ellite_men_tidy %>% 
      filter(station == station_selected()) %>% 
      mutate(diff = if_else(diff == "-", str_c(time, " (min:sec)"), diff)) %>% 
      ggplot() +
      aes(
        # x = reorder(name, -time_as_duration),
        x = reorder(name, -rank_station),
        y = time_as_duration,
        fill = name == input$select_athlete_list,
      ) +
      geom_col() +
      coord_flip() +
      scale_y_time(
        labels = label_time(format = '%M:%S'),
        breaks = 
          seq(0,as.numeric(station_statistics$slower[station_statistics$station == station_selected()]), 60),
        limits = 
          c(0,as.numeric(station_statistics$slower[station_statistics$station == station_selected()]) + 20)
      ) +
      labs(x = NULL, y = "[min:sec]") +
      scale_fill_manual(values = c("grey30","#FFED00")) +
      theme_minimal()+
      theme(
        axis.ticks.x        = element_line(size = 0.6, color = "#FFED00"),
        axis.ticks.length.x = unit(0.15, "cm"),
        axis.text.x         = element_text(color = "#FFFFFE", angle = 0, size = 14),  
        axis.text.y         = element_text(color = "#FFFFFE", size = 14),
        panel.grid          = element_blank(),
        axis.title.x        = element_text(size = 16, color = "#FFFFFE", vjust = -0.8),
        # plot.title          = element_text(color = "#FFED00", face = "bold", vjust = 3, size = "50px"),
        # plot.subtitle       = element_text(color = "grey40", vjust = 3),
        legend.position     = "none",
        plot.background     = element_rect(fill = "#262626", colour = "#262626")
      ) +
      geom_text(aes(label = diff,
                    vjust = 0.5, 
                    hjust = -0.1,
                    size = 3,
                    color = case_when(
                      name == input$select_athlete_list ~ "#FFED00",
                      TRUE ~ "#FFFFFE"))
      ) +
      scale_color_identity() +
      mean_line() +
      median_line()
  }
  return(plot)
})


output$plot_run_analysis <- renderPlot(
  plot_station()
)