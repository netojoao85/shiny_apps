
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

hospital_activity_and_deprivation <- 
  read_csv(
    here::here(
      str_c(
        "01_raw_data",
        "hospital_activity",
        "hospital_activity_and_deprivation.csv", 
        sep = "/"))) %>% 
  clean_names()




# clean script ------------------------------------------------------------

activity_deprivation <- hospital_activity_and_deprivation %>% 
  mutate(year    = str_sub(quarter, 1, 4), .after = id,
         year    = as.numeric(year),
         quarter = str_sub(quarter, 6), 
         quarter = as.numeric(quarter),
         shb      = if_else(nchar(hb) == 6, hb, NA_character_),
         hb       = if_else(nchar(hb) == 9 & str_detect(hb, '^S08'), hb, NA_character_),
         location = if_else(nchar(location) == 5, location, NA_character_)) %>%  
  left_join(x = .,
            y = hb, 
            by = "hb", 
            suffix = c("", "_hb_suffix")) %>% 
  left_join(x = .,
            y = shb, 
            by = "shb", 
            suffix = c("", "_shb_suffix")) %>%
  left_join(x = .,
            y = hospitals, 
            by = "location", 
            suffix = c("", "_hospital_suffix")) %>% 
  select(!ends_with(c("_suffix", "qf"))) %>% 
  relocate(c(19:22, 27:28), .after = 15) %>% 
  select(c(1:21))




# write .css --------------------------------------------------------------

activity_deprivation %>% 
  write_csv(here::here("03_clean_data/activity_deprivation.csv"))




