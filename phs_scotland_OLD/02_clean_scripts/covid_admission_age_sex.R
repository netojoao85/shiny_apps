
# load libraries ----------------------------------------------------------

source(file = "02_clean_scripts/libraries/libraries.R")



# load data ----------------------------------------------------------------

## load auxiliary data ------------------------------------------------------
  
hospitals <- read_csv(here::here("01_raw_data/health_board/hospitals.csv")) %>% 
  clean_names()

hb <- read_csv(here::here("01_raw_data/health_board/health_board.csv")) %>% 
  clean_names()

shb <- read_csv(here::here("01_raw_data/health_board/special_health_boards.csv")) %>% 
  clean_names()


## load main data ----------------------------------------------------------

covid_admission_hb_age_sex <-
  read_csv(
    here::here(
      str_c(
        "01_raw_data",
        "hospitalisations_due_to_covid_19",
        "admissions_by_health_board_age_and_sex.csv",
      sep = "/"))) %>% 
  clean_names()




# clean script ------------------------------------------------------------

covid_admission_age_sex <- covid_admission_hb_age_sex %>% 
  mutate(date    = ymd(week_ending), .before = 1,
         year    = year(date),     
         month   = month(date),   
         day     = day(date),     
         quarter = quarter(date),
         week    = week(date),
         hb       = if_else(nchar(hb) == 9 & str_detect(hb, '^S08'), hb, NA_character_)) %>% 
  left_join(x = .,
            y = hb, 
            by = "hb", 
            suffix = c("", "_hb_suffix")) %>% 
  relocate(hb_name, .after = hb) %>% 
  select(!ends_with("qf"), -week_ending) %>% 
  select(c(1:"percent_variation")) %>%
  mutate(year_quarter = tsibble::make_yearquarter(year, quarter), .after = quarter)




# write .css --------------------------------------------------------------

covid_admission_age_sex %>% 
  write_csv(here::here("03_clean_data/covid_admission_age_sex.csv"))




