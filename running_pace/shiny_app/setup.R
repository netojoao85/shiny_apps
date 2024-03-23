
# import libraries -----------------------------------------------
library(shiny)
library(tidyverse)
library(bsicons)
library(shinyWidgets)

library(rsconnect)


# vectors / lists ------------------------------------------------
# option_list <- list(
#   list(span(icon("heartbeat", lib = "font-awesome")) = "Pace"),
#   list(span(icon("run", lib = "font-awesome")) = "Velocity"),
#   list(span(icon("heartbeat", lib = "font-awesome"))  = "Time")
# )

option_list <- c(
  "Pace",
  "Velocity",
  "Time"
)


