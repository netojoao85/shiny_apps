source(here::here("scripts/setup.R"), local = TRUE)


# 1. get raw data & manipulation ----------------------------------------------

characters <- read_csv("raw_data/simpsons_characters.csv") %>% 
  clean_names() %>% 
  rename("character_id" = "id",  
         "character" = "normalized_name") %>% 
  select(character_id, character) %>% 
  filter(character_id %in% c("1", "2", "8", "9", "105"))

episodes <- read_csv("raw_data/simpsons_episodes.csv") %>% 
  clean_names() %>% 
  rename("episode_id" = "id") %>% 
  select(episode_id, season, imdb_rating , views)
  
locations <- read_csv("raw_data/simpsons_locations.csv") %>% 
  clean_names() %>% 
  rename("location_id" = "id",
         "location" = "normalized_name") %>% 
  select(location_id, location) %>% 
  mutate(
    location_count = str_count(location, "\\w+") <= 2, #count nr of words
    location = str_to_title(location)) %>%
  filter(location_count == TRUE) %>% 
  select(-location_count)


scripts <- read_csv("raw_data/simpsons_script_lines.csv") %>% 
  clean_names() %>% 
  filter(speaking_line == TRUE) %>% 
  select(!starts_with("raw"))



# 2. join datasets -----------------------------------------------------------

simpsons_join <- 
  inner_join(scripts, characters, by = "character_id") %>% 
  inner_join(., episodes, by = "episode_id") %>% 
  inner_join(., locations, by = "location_id") %>% 
  select(character, season, location, spoken_words, word_count)
  # drop_na()


# 3. turn text into Data -----------------------------------------------------
simpsons_words <- tibble(
  id = 1:nrow(simpsons_join),
  character = simpsons_join$character,
  spokens = simpsons_join$spoken_words,
  season = simpsons_join$season,
  location = simpsons_join$location
)


sentiment_words <- simpsons_words %>% 
  unnest_tokens(word, spokens, token = "ngrams", n = 1) %>% 
  anti_join(stop_words) %>% 
  # filter(nchar(word) > 5) %>% 
  inner_join(., get_sentiments("bing")) %>% 
  inner_join(., get_sentiments("nrc"), by = "word", suffix = c("_bing", "_nrc"))
  

sentiment_words <- sentiment_words %>% 
  inner_join(., get_sentiments("afinn"))

simpsons_words <- sentiment_words

simpsons_words %>%
  write.csv("scripts/cleaned_data/simpsons_words.csv")



rm(main_characters)
rm(characters)
rm(characters_joined)
rm(episodes)
rm(locations)
rm(scripts)
rm(simpsons_join)
rm(sentiment_words)



# sentiment analysis ------------------------------------------------------


## global ------------------------------------------------------------------
# global_analysis <- simpsons_words %>%
#   left_join(tidytext::get_sentiments("nrc")) %>%
#   drop_na()

## location ---------------------------------------------------------------
# location_analysis <- simpsons_words %>%
#   left_join(., tidytext::get_sentiments("bing"), by = "word") %>%
#   drop_na()
# 
# 
# ## Word Cloud --------------------------------------------------------------
# word_cloud <- simpsons_words %>%
#   count(word, sort = TRUE) %>%
#   left_join(., tidytext::get_sentiments("nrc"), by = "word") %>%
#   drop_na()
# 
# 
# ## season ------------------------------------------------------------------
# seasons_analysis <- simpsons_words %>%
#   left_join(., tidytext::get_sentiments("bing"), by = "word") %>%
#   drop_na()



# write csv ---------------------------------------------------------------
# simpsons_words %>% 
#   write.csv("scripts/cleaned_data/simpsons_words.csv")
