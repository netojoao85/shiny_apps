source(here::here("data/data_cleaning_scripts/cancer_incidence.R"), local = TRUE)$value


output$cancer_incidence_gender <- renderPlot({
  
incidence_health_board_clean %>% 
  group_by(year, sex) %>% 
  summarise(nr_incidences = sum(incidences_all_ages)) %>% 
  ggplot(aes(x = year, y = nr_incidences, color = sex)) +
  geom_line(size = 1) +
  labs(
    # title = "Total values of incidences", 
    # subtitle = "from 1996 to 2020",
    x = NULL, 
    y = NULL) +
  geom_point(size = 2) +
  theme_minimal() +
  theme(legend.position = "bottom", 
        legend.title = element_blank()) +
  scale_x_continuous(breaks = seq(min(incidence_health_board$year),
                                  max(incidence_health_board$year), 
                                  2)) +
  scale_color_manual(values = c("Female" = "pink2",
                                "Male" = "steelblue"))
  
  })




# type of cancer ----------------------------------------------------------

output$cancer_incidence_type_cancer <- renderPlot({
  
  incidence_health_board_clean %>% 
    group_by(hb_name, cancer_site) %>% 
    summarise(nr_incidences_per_hb = sum(incidences_all_ages)) %>% 
    slice_max(nr_incidences_per_hb, n = 3) %>% 
    ggplot() + 
    aes(x = hb_name, y = nr_incidences_per_hb, fill = cancer_site) +
    geom_col(position = "dodge") +
    theme_minimal() +
    theme(legend.position = "bottom",
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          legend.title = element_blank(),
          axis.text.x  = element_text(angle = 90, hjust = 1),
    ) +
    labs(title    = "",
         subtitle = "",
         x = NULL,
         y = NULL)
  
  
  
  
})