library(shiny)
library(shinyjs)
library(tidyverse)
library(janitor)
library(tidytext)
library(textdata)
library(plotly)
library(ggwordcloud)
library(htmltools)
library(shinyBS)


# sentiment_colors --------------------------------------------------------

sentiment_colors <- 
  c(
    "positive" = "#E3D93E",
    "negative" = "#B0D063"
  )
# 
sentiment_colors_intermedian <-
  c(
    "negative" = "#5AB98B",
    "positive" = "#DF8470",
    "uncertainty" = "#E4CAA2",
    "litigious" = "#232423",
    "constraining" = "#6973D4",
    "superfluous" = "#DC43CC"
  )

sentiment_colors_advanced <-
  c(
    "trust" = "red",
    "fear" = "green"  ,
    "negative"  = "blue",
    "sadness"  = "firebrick",
    "anger"  = "purple",
    "surprise"  = "grey",
    "positive"  = "black",
    "disgust"  = "yellow",
    "joy"  = "orange",
    "anticipation"  = "seagreen"
  )


