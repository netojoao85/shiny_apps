library(tidyverse)
library(janitor)


# get data ----------------------------------------------------------------

incidence_scotland_level <- read_csv("data/raw_data/cancer_incidence/incidence_at_scotland_level.csv") %>%
  clean_names()

incidence_health_board <- read_csv("data/raw_data/cancer_incidence/incidence_by_health_board.csv") %>% 
  clean_names()

five_year_summary_incidence_health_board <- read_csv("data/raw_data/cancer_incidence/5_year_summary_of_incidence_by_health_board.csv") %>% 
  clean_names()

health_board <- read_csv("data/raw_data/cancer_incidence/health_board_2014_health_board_2019.csv") %>% 
  clean_names()





# data wrangling ----------------------------------------------------------
incidence_health_board_clean <- incidence_health_board %>% 
  filter(sex %in% c("Male", "Female")) %>% 
  left_join(x = .,
            y = health_board,
            by = "hb", suffix = c("", "suffix_hb")) %>% 
  relocate(hb_name, .after = "hb") %>% 
  filter(sex %in% c("Male", "Female"), !cancer_site == "All cancer types")



names(five_year_summary_incidence_health_board) <- 
  str_remove(names(five_year_summary_incidence_health_board), 'incidence_rate_age')

names(five_year_summary_incidence_health_board) <-   
  str_replace(string = names((five_year_summary_incidence_health_board)),
              pattern = "to", 
              replacement =  " to ")



