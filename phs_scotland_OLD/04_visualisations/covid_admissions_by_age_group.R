
# get libraries -----------------------------------------------------------

source(file = "02_clean_scripts/libraries/libraries.R")


# get dataframe -----------------------------------------------------------

covid_admission_age_sex <- read_csv(
  here::here("03_clean_data/covid_admission_age_sex.csv"))



# visualisation -----------------------------------------------------------


covid_admission_age_sex %>%
  # filter(admission_type == input$demo_admission_type_covid_age,
  #        hb_name        == input$demo_hb_covid_age) %>% 
  mutate(ym = yearquarter(date),
         age_group =  case_when(
           age_group == "Under 5" ~  "0 - 04",
           age_group == "5 - 14" ~  "05 - 14",
           TRUE ~ age_group)) %>% 
  filter(!age_group == "All ages") %>% 
  group_by(age_group, ym, number_admissions) %>% 
  summarise(nr_admissions = sum(number_admissions), .groups = "keep") %>% 
  # covid_age_filter() %>% 
  ggplot() +
  aes(x = ym, y = nr_admissions, fill = age_group) + 
  geom_col(position = "dodge") + 
  theme_minimal() +
  labs(
    title    = "Covid admissions by group age",
    subtitle = "January of 2020 to January 2022",
    x = NULL,
    y = "Adimissions") +
  scale_fill_manual(values = c("#003087", "#005EB8", 
                               "#4D7CB9", "#99C7EB", 
                               "#919EA8", "#B7C0C6", 
                               "#DDE1E4")) +
  scale_x_yearquarter(date_labels = "%Y \n Q%q", date_breaks = "3 months") +
  theme(
    legend.position = "bottom",
    legend.title = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.background = element_rect(fill = '#FFFFFF', color = '#F8F8F8')
  )