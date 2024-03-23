
output$table_classification <- function() ({
  
  join_diff_run <- hyrox_ellite_men_tidy %>% 
    filter(station == "Run Total") %>%
    mutate(diff_run = str_c(diff)) %>% 
    mutate(diff_run = case_when(diff_run == "-" ~ "-",
                                TRUE ~ paste(as.character(icon("caret-up", lib = "font-awesome", style = "color: red; font-size: 24px;" )), diff_run))) %>% 
    mutate(diff_run = diff_run) %>% 
    select(name, diff_run)
  
  
  
  join_diff_total <- hyrox_ellite_men %>% 
    select(name, total_race) %>% 
    mutate(total_duration = as.duration(hms(total_race))) %>% 
    mutate(total_duration = if_else(is.na(total_duration), as.duration(ms(total_race)), total_duration)) %>% 
    mutate(diff_prev = str_c("+", as.period(total_duration - lag(total_duration, 1))),
           diff_winner = str_c("+", as.period(total_duration - total_duration[1]))) %>% 
    mutate(diff = str_c(diff_prev, "<br></br>", diff_winner)) %>% 
    mutate(diff = replace_na(diff, "-"))
  
  
  X <- hyrox_ellite_men %>%
    left_join(., join_diff_total) %>% 
    mutate(rank = rank_function(rank),
           rank_run = rank_function(rank_run)) %>%
    mutate(space_one = "  ", space_two = "  ") %>% 
    select(name, rank, total_race, diff, space_one, age_group, rank_ag, space_two, rank_run, total_run, pace_run) %>%
    knitr::kable(format = "html", escape = FALSE, 
                 col.names = c("Athlete", 
                               as.character(span(icon("medal", lib = "font-awesome", style = "color: white; font-size: 20px"),
                                                 br(), h6("Rank", style = "margin:0px; padding: 0px"))),
                               as.character(span(icon("clock", lib = "font-awesome", style = "color: white; font-size: 20px"),
                                                 br(), h6("Time", style = "margin:0px; padding: 0px"))),
                               paste(h6("(1)", style = "color: grey; font-size: 13px; margin: 0px; padding: 0px; text-align: right; width: 20px"),
                                     as.character(icon("chart-line", lib = "font-awesome", style = "color: white; font-size: 20px"))),
                               
                               as.character(h3(" ", style ="margin-left: 20px")),
                               as.character(span(icon("group", lib = "font-awesome", style = "color: white; font-size: 20px"),
                                                 br(), h6("AG", style = "margin:0px; padding: 0px"))),
                               as.character(span(icon("medal", lib = "font-awesome", style = "color: white; font-size: 20px"),
                                                 br(), h6("Rank", style = "margin:0px; padding: 0px"))),
                               as.character(h3(" ", style ="margin-left: 20px")),
                               as.character(span(icon("medal", lib = "font-awesome", style = "color: white; font-size: 20px"),
                                                 br(), h6("Rank", style = "margin:0px; padding: 0px"))),
                               as.character(span(icon("clock", lib = "font-awesome", style = "color: white; font-size: 20px"),
                                                 br(), h6("Time", style = "margin:0px; padding: 0px"))),
                               as.character(span(icon("heartbeat", lib = "font-awesome", style = "color: white; font-size: 20px"),
                                                 br(), h6("Pace", style = "margin:0px; padding: 0px")))
                 )) %>%
    kable_styling(bootstrap_options = "basic",
                  full_width = TRUE,
                  position = "center") %>%
    add_header_above(
      escape = FALSE, 
      line = TRUE, 
      line_sep = 5,
      header = c(" " = 1,
                 "Overall Performance" = 3,
                 " " = 1,
                 "Age Group (AG)" = 2,
                 " " = 1,
                 "8km Run Performance" = 3),
      extra_css = "color: white ; text-align: center; font-size: 16px; font-size: normal; ") %>%
    row_spec(row = 0, align = "center", extra_css = "padding: 5px 0px") %>%
    column_spec(1, background = "#323232", extra_css = "text-align: left; font-size: 18px; vertical-align: middle;") %>%
    column_spec(2:11, extra_css = "text-align: center; font-size: 18px; vertical-align: middle;") %>% 
    column_spec(4, extra_css = "font-size: 14px; background-color: firebrick; color: white") %>% 
    add_footnote(label = c("First row time / Second row time: Difference for the above athlete / Difference for the Race Winner."),
                 notation = "number", escape = FALSE)
})