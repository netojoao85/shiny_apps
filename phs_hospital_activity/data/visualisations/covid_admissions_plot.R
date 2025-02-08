library(tidyverse)
library(janitor)
library(ggplot2)
library(tsibble)
library(plotly)

covid_admissions <- read_csv(here::here("data/clean_data/covid_admissions.csv"))

ggplot_covid_admissions <- covid_admissions %>% 
  filter(
    hb_name == "All",
    admission_type == "All",
    specialty == "All") %>% 
  ggplot() +
  geom_line(aes(x = week_ending, y = number_admissions, color = "number_admissions"), linetype = "solid", size = 1.5) + 
  geom_area(aes(x = week_ending, y = number_admissions), fill = "#E8FCE8") +
  geom_line(aes(x = week_ending, y = average20182019, color = "average20182019"), linetype = "solid", alpha = 0.4) +
  geom_area(aes(x = week_ending, y = average20182019), fill = "#F4B6F1", alpha = 0.2 ) +
  scale_x_yearmonth(date_labels = "%b \n%Y", date_breaks = "2 months") +
  theme_minimal() +
  labs(
    x = NULL,
    y = NULL
  ) +
  scale_color_manual(values = c("purple", "darkgreen"))

ggplot_covid_admissions


plotly::ggplotly(ggplot_covid_admissions) %>% 
  config(displayModeBar = FALSE) %>%
  layout(
    legend = list(
      orientation = "h", 
      y = -0.1, 
      x = 0.35, 
      title = list(text = "")
    ),
    xaxis = list(
      # title ="", 
      # titlefont = list(size = 14, color = "firebrick"),
      tickfont = list(size = 14, color = "black")
      # showline = FALSE,
      # tickmode = "auto",
      # nticks = 10,
      # showgrid = "major"
    ),
    yaxis = list(
      # title ="", 
      # titlefont = list(size = 16, color = "firebrick"),
      tickfont = list(size = 14, color = "black"),
      # showline = FALSE,
      # zeroline = FALSE,
      tickmode = "auto",
      nticks = 8,
      showgrid = "major"
    )
  )

