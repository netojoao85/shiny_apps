
# get libraries -----------------------------------------------------------

source(file = "02_clean_scripts/libraries/libraries.R")



# get dataframe -----------------------------------------------------------

covid_admission_age_sex <- read_csv(
  here::here("03_clean_data/covid_admission_age_sex.csv"))



# visualisation -----------------------------------------------------------


covid_admission_age_sex %>% 
  mutate(year_quarter = make_yearquarter(year, quarter), .after = quarter) %>% 
  # covid_admission_age_sex %>%
  filter(!sex == "All") %>% 
  # admission_type == input$demo_admission_type_covid,
  # hb_name        == input$demo_hb_covid) %>% 
  mutate(year_month = yearmonth(date)) %>% 
  group_by(year_month, 
           sex) %>% 
  summarise(nr_admissions = sum(number_admissions), .groups = "keep") %>% 
  ggplot() + 
  aes(x = year_month,
      y = nr_admissions, 
      fill = sex, 
      color = sex) +
  geom_line(position = position_dodge(width = 0.5), size = 1) +
  scale_x_yearmonth(date_labels = "%b \n%Y", date_breaks = "2 month") +
  labs(
    title    = "Covid Admissions by Gender",
    subtitle = "January 2020 to February 2022\n",
    x        = NULL, 
    y        = "Admissions"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        panel.background = element_rect(fill = '#FFFFFF', color = '#F8F8F8'),
        panel.grid.minor.y = element_blank()) +
  scale_color_manual(values = c("Male"   = "lightblue",
                                "Female" = "purple"))