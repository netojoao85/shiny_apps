## Script Information -------------------------------------------------------
##
## Script name:  hospital_activity_pat_clean.R
##
## Purpose of script: 
##  The purpose of this script is to clean the hospital activity deprivation
##  data. This is then joined on to the main data with more information on the
##  healthboard regions/hospital locations.
##
##  The variable quarter was splitted in a year and quarter. The variable hb did
##  not have just information/codes from health board, but had special health 
##  board (shb) and location codes too. That way, variable hb was cleaned to 
##  just have hb values, and one column called shb was created to have shb codes
##  from hb variable and the location values were shifted to location variable. 
##  The criteria to clean the hb variable was :
##    - values with  9 digits and started by "S08" was signed as hb value;
##    - values with a length of 6 digits were considered as shb values;
##    - values with a length of 5 digits were considered as location values.
##  
##  The variable hb just had the the code and did not have the name the same 
##  for the variables like shb and location, for that reason three auxiliar 
##  dataset were joined:
##  - healthboard (hb variable as key);
##  - special health board (shb variable as key); and
##  - hospitals (location variable as key)
##
## Author: Joao Neto
##
## Date Created: 2022/08/11
## 
## Output:
##        activity_patient_demographics.csv - cleaned file of raw data
##                      
## 
##
##/////////////////////////////////////////////////////////////////////////////
##
## Notes:
##   Packages required to be installed-
##        {tidyverse}
##        {here}
##        
##
##
##    Data file require:
##        hospital_ativity_and_patient_demographics.csv
##        hospitals.csv
##        special_health_boards.csv
##
##
## ////////////////////////////////////////////////////////////////////////////


# Load Libraries ----------------------------------------------------------

library(tidyverse)


# Load in the data --------------------------------------------------------


hospital_ativity_and_patient_demographics <- 
  read_csv(here::here("01_data/hospital_ativity_and_patient_demographics.csv")) %>% 
  clean_names()

# Load additional information to be used for join

hospitals <- read_csv(here::here("01_data/healt_board/hospitals.csv")) %>% 
  clean_names()

hb <- read_csv(here::here("01_data/healt_board/health_board.csv")) %>% 
  clean_names()

shb <- read_csv(here::here("01_data/healt_board/special_health_boards.csv")) %>% 
  clean_names()


# Cleaning/Wrangling -----------------------------------------------------------

### hospital_ativity_and_patient_demographics

activity_patient_demographics <- hospital_ativity_and_patient_demographics %>% 
  mutate(year    = str_sub(quarter, 1, 4), .after = id,
         year    = as.numeric(year),
         quarter = str_sub(quarter, 6), 
         quarter = as.numeric(quarter),
         shb      = if_else(nchar(hb) == 6, hb, NA_character_),
         hb       = if_else(nchar(hb) == 9 & str_detect(hb, '^S08'), hb, NA_character_),
         location = if_else(nchar(location) == 5, location, NA_character_),
         age = str_remove(age, pattern = " years")) %>%
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
  relocate(c(20:23, 28:29), .after = 16) %>% 
  select(c(1:22))



# Write the output --------------------------------------------------------

activity_patient_demographics %>% 
  write.csv(here::here("02_cleaned_data/activity_patient_demographics.csv"))
