

# get libraries and call data ---------------------------------------------

source(here::here("R_scripts/setup.R"), local = TRUE)$value


# Data Wrangling -------------------------------------------------------------
hyrox_ellite_men <- hyrox_ellite_men_raw %>%
  mutate(continent = case_when(
    country == "Australia" ~ "Oceania",
    country == "USA" ~ "North America",
    TRUE ~ "Europe"
  ), .after = "country") %>%
  mutate(
    first_name  = str_extract_all(name, "[aA-zZ]+$"),
    surname = str_extract_all(name, "^[aA-zZ]+"),
    name = str_c(first_name, " ", surname)
  ) %>%
  mutate_if(is.POSIXct, ~format(.x, "%M:%S")) %>%
  select(1:wall_balls) %>%
  mutate(total_run    = sum_times(data = ., range_variables = 7:14),
         total_race   = sum_times(data = ., range_variables = 7:22),
         pace_run     = str_c(avg_station(data = ., range_variables = 7:14, n = 8), " /km"),
         ski_avg_500m = str_c(avg_station(data = ., range_variables = 15:15, n = 2), " ave /500m"),
         row_avg_500m = str_c(avg_station(data = ., range_variables = 19:19, n = 2), " ave /500m"))


rank_age_group <- hyrox_ellite_men %>% 
  select(rank, name, age_group) %>% 
  group_by(age_group) %>%
  arrange(age_group, rank) %>% 
  mutate(rank_ag = 1:n()) %>% 
  mutate(rank_ag = str_c(rank_function(rank_ag), " in ", n()))


hyrox_ellite_men <- hyrox_ellite_men %>% 
  left_join(., rank_age_group) %>% 
  arrange(rank)


stations_list <- c("running 1", "running 2", "running 3", "running 4", 
                   "running 5","running 6", "running 7", "running 8", 
                   "Ski Erg", "Sled Push", "Sled Pull", "Burpees",
                   "Row", "Farmers Carry", "Lunges", "Wall Balls", "Run Total")


stations_list_rank <- c("Run Total", "Ski Erg", "Sled Push", "Sled Pull", 
                        "Burpees", "Row", "Farmers Carry", "Lunges", "Wall Balls")

rank_stations_official <- rank_stations_official %>% 
  select(1:wall_balls) %>% 
  data.table::setnames(old = names(rank_stations_official[3:11]), 
                       new = stations_list_rank)


hyrox_ellite_men_tidy <- hyrox_ellite_men %>%
  select(rank, name, run_1:total_run) %>%
  data.table::setnames(old = names(hyrox_ellite_men[7:23]),
                       new = stations_list) %>%
  pivot_longer(cols = c(3:19),
               names_to = "station",
               values_to = "time") %>%
  group_by(station) %>%
  arrange(station, time) %>%
  mutate(rank_station = c(1:15),
         time_as_duration = as.duration(ms(time)),
         diff = (str_c("+", seconds_to_period(time_as_duration - time_as_duration[1]))),
         diff = case_when(time_as_duration == time_as_duration[1] ~ "-",
                          TRUE ~ diff),
         diff_prev = str_c("+", seconds_to_period(time_as_duration - lag(time_as_duration, 1))),
         diff_prev = case_when(is.na(diff_prev) ~ "-",
                               TRUE ~ diff_prev)) %>%
  arrange(factor(station, levels = stations_list)) %>% 
  mutate(key = str_c(rank, name, station))


rank_stations_official <- rank_stations_official %>% 
  mutate(
    first_name  = str_extract_all(name, "[aA-zZ]+$"),
    surname = str_extract_all(name, "^[aA-zZ]+"),
    name = str_c(first_name, " ", surname)) %>% 
  select(!c(first_name, surname)) %>% 
  pivot_longer(cols = c(3:11),
               names_to = "station",
               values_to = "rank_station") %>% 
  mutate(key = str_c(rank, name, station))


hyrox_ellite_men_tidy <- left_join(x = hyrox_ellite_men_tidy, 
                                   y = rank_stations_official, 
                                   by = "key", 
                                   suffix = c("", ".y")) %>% 
  rename(rank_station_official = rank_station.y) %>% 
  mutate(rank_station = case_when(is.na(rank_station_official) ~ rank_station,
                                  TRUE ~ rank_station_official)) %>% 
  select(!ends_with(".y"), -key, -rank_station_official) 




# Mean / Median / Faster / Slower -> (Per each Station) -----------------------
station_statistics <- hyrox_ellite_men_tidy %>% 
  group_by(station) %>% 
  summarise(faster = as.duration(seconds_to_period(min(time_as_duration))),
            slower = as.duration(seconds_to_period(max(time_as_duration))),
            mean_time = as.duration(
              seconds_to_period(round(mean(time_as_duration), digits = 0))),
            median_time = as.duration(
              seconds_to_period(round(median(time_as_duration), digits = 0))),
  ) %>%  
  arrange(factor(station, levels = stations_list))
station_statistics



#------------------------------------------------------------------------------
# Add rank of run by each athlete
#------------------------------------------------------------------------------
hyrox_ellite_men <- hyrox_ellite_men_tidy %>%
  filter(str_detect(station, "running")) %>%
  group_by(name) %>%
  summarise(sum_run = sum(time_as_duration)) %>%
  arrange(sum_run) %>%
  ungroup() %>%
  # mutate(rank_run = 1:15) %>%
  mutate(rank_run = hyrox_ellite_men_tidy$rank_station[hyrox_ellite_men_tidy$station == "Run Total"]) %>%
  select(-sum_run) %>%
  left_join(., hyrox_ellite_men) %>%
  relocate(rank, name, division:run_8, rank_run, total_run, pace_run,
           x1000m_ski_erg, ski_avg_500m, x2x25m_sled_push:x1000m_row,
           row_avg_500m) %>%
  arrange(rank)
hyrox_ellite_men


hyrox_ellite_men_tidy <- hyrox_ellite_men_tidy %>% 
  left_join(., station_statistics) %>% 
  select(!c(faster, slower))



# Demographic -------------------------------------------------------------
demographic_continent <- hyrox_ellite_men %>% 
  group_by(continent) %>% 
  summarise(count = n(),
            percent = percent(count / max(hyrox_ellite_men$rank), digits = 0))

demographic_country <- hyrox_ellite_men %>% 
  group_by(country) %>% 
  summarise(count = n(),
            percent = percent(count / max(hyrox_ellite_men$rank), digits = 0))

demographic_age_group <- hyrox_ellite_men %>% 
  group_by(age_group) %>% 
  summarise(count = n(),
            percent = percent(count / max(hyrox_ellite_men$rank), digits = 0))

info_demographic_continents   <- length(unique(demographic_continent$continent))
info_demographic_countries <- length(unique(demographic_country$country))
info_demographic_age_group <- length(unique(demographic_age_group$age_group))



# Athlete Analysis: Selection inputs ------------------------------------------
select_athlete <- hyrox_ellite_men %>%
  distinct(name) %>%
  pull()

select_station <- c("Running", stations_list[9:16])



