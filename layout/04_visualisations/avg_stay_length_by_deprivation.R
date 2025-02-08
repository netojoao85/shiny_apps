
# get libraries -----------------------------------------------------------

source(file = "02_clean_scripts/libraries/libraries.R")


# get dataframe -----------------------------------------------------------

activity_deprivation <- read_csv(
  here::here("03_clean_data/activity_deprivation.csv"))



# visualisation -----------------------------------------------------------

activity_deprivation %>%
  filter(!is.na(hb_name),
         !is.na(simd)) %>% 
  mutate(simd = factor(simd, levels = c(1, 2, 3, 4, 5))) %>%
  # filter(hb_name %in% input$demo_hb,
  #        admission_type %in% input$demo_admission_type) %>% 
  group_by(year, simd) %>% 
  summarise(avg_length_stays = mean(average_length_of_stay, na.rm = TRUE)) %>%
  # demographic_simd_filter() %>%
  ggplot() + 
  aes(x = year, y = avg_length_stays, fill = simd) +
  geom_col(position = "dodge") + 
  labs(title = "Average Length of Stay by Board of Treatment and Deprivation",
       subtitle = "1 - Most deprived | 5 - least deprived",
       x = NULL) +
  theme_minimal() +
  scale_x_continuous(breaks = seq(2016, 2021, 1)) +
  theme(
    legend.position = "bottom",
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    legend.direction = "horizontal",
    panel.background = element_rect(fill = '#FFFFFF', 
                                    color = '#F8F8F8')) +
  scale_fill_brewer(palette = "OrRd", direction = -1) +
  # scale_fill_manual(values = c("#003087", "#005EB8", 
  #                              "#99C7EB", "#919EA8", 
  #                              "#DDE1E4")) +
  labs(y = "Average Stay Length")

