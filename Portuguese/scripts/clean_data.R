library(tidyverse)
library(janitor)
library(ggplot2)
library(plotly)
library(DT)
library(leaflet)
library(sf)
library(rnaturalearth)
library(rnaturalearthhires)
library(leaflet.extras)
library(bsicons)
library(shiny)
library(shinydashboard)
library(RColorBrewer)
library(shinyWidgets)
library(shinyjs)

# dataset -----------------------------------------------------------------

enterprises <- read_csv(here::here("raw_data/portuguese_touristic_enterprises.csv")) %>% 
  clean_names() %>% 
  select(denominacao, ent_proprietaria, tipologia_et, categoria, 
         nr_camas_fixas, nr_quartos, nr_suites, nr_apart, campo_golfe, 
         salas_reunioes, capac_salas_reunioes, spa, ano_abertura_empreendimento, 
         certif_ambiental, certif_qual_serv, distrito, concelho, 
         unesco, lat_long) %>% 
  separate(col  = lat_long,
           into = c("lat", "lng"),
           sep  =  "; ") %>% 
  mutate(lat = round(as.numeric(str_replace(lat, ",", ".")), 3),
         lng = round(as.numeric(str_replace(lng, ",", ".")), 3)) %>%
  mutate(
    categoria = as.numeric(categoria), 
    categoria = ifelse(categoria == 0, "-", categoria )) %>% 
  mutate(
    salas_reunioes = ifelse(salas_reunioes == "Sim", "yes", "no"),
    spa = ifelse(spa == "Sim", "yes", "no"),
    certif_ambiental = ifelse(certif_ambiental == "Sim", "yes", "no"),
    certif_qual_serv = ifelse(certif_qual_serv == "Sim", "yes", "no"),
    campo_golfe = ifelse(campo_golfe == "Sim", "yes", "no"),
    unesco = ifelse(unesco == "Não Abrangido", "no", "yes")) %>% 
  # mutate(
  #   tipologia_et = case_when(
  #     tipologia_et == "CasaDeCampo"  ~ "Country houses",
  #     tipologia_et == "Hotel" ~ "Hotel",
  #     tipologia_et == "HotelRural" ~ "Rural hotel",
  #     tipologia_et == "Agroturismo" ~ "Agrotourism",
  #     tipologia_et == "ApartamentosTuristicos" ~ "Apartments",
  #     tipologia_et == "TurismoDeHabitacao" ~ "Lodging houses",
  #     tipologia_et == "AldeamentoTuristico" ~ "Tourist Resort",
  #     tipologia_et == "ParqueCampismo/Caravanismo" ~ "Camping/Caravan Park",
  #     tipologia_et == "HotelApartamento" ~ "Aparthotel",
  #     # tipologia_et == "Pousada" ~ "Guesthouse",
  #     .default = "Guesthouse")
  #   ) %>% 
  mutate(
    tipologia_et = case_when(
      tipologia_et == "CasaDeCampo"  ~ "country_houses",
      tipologia_et == "Hotel" ~ "hotel",
      tipologia_et == "HotelRural" ~ "rural_hotel",
      tipologia_et == "Agroturismo" ~ "agrotourism",
      tipologia_et == "ApartamentosTuristicos" ~ "apartments",
      tipologia_et == "TurismoDeHabitacao" ~ "lodging_houses",
      tipologia_et == "AldeamentoTuristico" ~ "tourist_resort",
      tipologia_et == "ParqueCampismo/Caravanismo" ~ "camping/caravan_park",
      tipologia_et == "HotelApartamento" ~ "aparthotel",
      # tipologia_et == "Pousada" ~ "guesthouse",
      .default = "guesthouse")
  ) %>% 
  rename(
    "name" = "denominacao",
    "entity" = "ent_proprietaria",
    "type" = "tipologia_et",
    "star_rating" = "categoria",
    "beds" = "nr_camas_fixas",
    "rooms" = "nr_quartos",
    "suits" = "nr_suites",
    "apartments" = "nr_apart",
    "golf_field" = "campo_golfe",
    "meeting_room" = "salas_reunioes",
    "meeting_room_capacity" = "capac_salas_reunioes",
    "spa" = "spa",
    "start_year" = "ano_abertura_empreendimento",
    "env_certification" = "certif_ambiental",
    "qual_certification" = "certif_qual_serv",
    "district" = "distrito",
    "municipality" = "concelho",
    "unesco" = "unesco",
    "lat" = "lat",
    "lng" = "lng"
  )


# -- Build a continental Portugal map with regions (names = districts) ---------

portugal_map <- ne_states(
  country = "Portugal",
  returnclass = "sf") %>% 
  select(geometry, name, latitude, longitude) %>% 
  filter(!name %in% c("Madeira", "Azores"))


# define the Portugal map boundaries
bbox <- st_bbox(portugal_map)



# data preparation --------------------------------------------------------

my_vars <- c(
  "Name" = "name",
  "Entity" = "entity",
  "Type" = "type",
  "Start Rating" = "star_rating",
  "Beds (un.)" = "beds",
  "Rooms (un.)" = "rooms",
  "Suits (nr.)" = "suits",
  "Apartments (un.)" = "apartments",
  "Golf Field (y/n)" = "golf_field",
  "Meeting Room (y/n)" = "meeting_room",
  "Meeting Room Capacity" = "meeting_room_capacity",
  "Spa (y/n)" = "spa",
  "Start Year" = "start_year",
  "Environmental Certification" = "env_certification",
  "Quality Certification" = "qual_certification",
  "District" = "district",
  "Municipality" = "municipality",
  "Unesco" = "unesco",
  "lat" = "lat",
  "lng" = "lng"
)

my_type <- c(
  "Country houses"  = "country_houses",
  "Hotel" = "hotel",
  "Rural Hotel" = "rural_hotel",
  "Agrotourism" = "agrotourism",
  "Apartments" = "apartments",
  "Lodging Houses" = "lodging_houses",
  "Tourist Resort" = "tourist_resort",
  "Camping / Caravan Park" = "camping/caravan_park",
  "Aparthotel" = "aparthotel",
  "Guesthouse" = "guesthouse"
)