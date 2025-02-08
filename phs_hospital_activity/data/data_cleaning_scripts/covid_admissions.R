library(tidyverse)
library(janitor)
library(lubridate)
library(tsibble)



# data clean & wrangling ----------------------------------------------------

covid_admissions <- read_csv(here::here("data/raw_data/covid_admissions/hospital_admissions_hb_specialty_20231005.csv")) %>% 
  clean_names() %>% 
  select(-ends_with("qf")) %>% 
  mutate(week_ending = ymd(week_ending),
         week = lubridate::week(week_ending),
         quarter = lubridate::quarter(week_ending),
         month = lubridate::month(week_ending), 
         year = lubridate::year(week_ending),
         ym = tsibble::make_yearmonth(year = year, month = month),
         my = tsibble::make_yearquarter(year = year, quarter = quarter))

hb <- read_csv(here::here("data/raw_data/auxiliar/hb.csv")) %>% 
  clean_names() %>% 
  select(hb, hb_name) 


# join admissions & health boarders & hospitals ----------------------------

covid_admissions <- left_join(
  x = covid_admissions, 
  y = hb, 
  by = "hb") %>% 
  relocate(hb_name, .after = hb) %>% 
  mutate(hb_name = str_remove(hb_name, "NHS ")) %>% 
  mutate(hb_name = case_when(
    hb == "S92000003" ~ "All",
    TRUE ~ hb_name
  ))


# write csv ---------------------------------------------------------------

covid_admissions %>% 
  write.csv(here::here("data/clean_data/covid_admissions.csv"))



