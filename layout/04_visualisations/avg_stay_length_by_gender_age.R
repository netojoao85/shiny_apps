
# get libraries -----------------------------------------------------------

source(file = "02_clean_scripts/libraries/libraries.R")


# get dataframe -----------------------------------------------------------

activity_patient_demographics <- read_csv(
  here::here("03_clean_data/activity_patient_demographics.csv"))


# visualisation -----------------------------------------------------------

activity_patient_demographics %>%
  filter(!is.na(hb_name)) %>% 
  # filter(age %in% input$demo_age,
  #        hb_name %in% input$demo_hb,
  #        admission_type %in% input$demo_admission_type) %>% 
  # demographic_filter() %>% 
  group_by(sex, year, age) %>%
  summarise(avg_stay = mean(average_length_of_stay, na.rm = TRUE)) %>% 
  ggplot() +
  aes(x = age, y = avg_stay, fill = sex) +
  geom_col(position = "dodge") +
  theme_minimal() +
  labs(title = "Average Stay Length by Gender and Age Group",
       x = NULL,
       y = "Average Stay Length", 
       fill = "Sex") +
  theme(legend.position = "right",
        panel.background = element_rect(fill = '#FFFFFF', 
                                        color = '#F8F8F8')) +
  scale_fill_manual(values = c("lightblue", 
                               "purple"))
