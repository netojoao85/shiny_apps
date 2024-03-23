sum_times <- function(data, range_variables){
  total <- data %>% 
    mutate(across(c(range_variables), ~as.duration(ms(.x)))) %>% 
    mutate(sum_time = seconds_to_period(rowSums(select(., range_variables))))
  
  my_hour   <- hour(total$sum_time)
  my_minute <- formatC(minute(total$sum_time), digits = 1, format = 'd', flag = "0#")
  my_second <- formatC(second(total$sum_time), digits = 1, format = 'd', flag = "0#")
  
  total_time <- case_when(
    my_hour < 1 ~ str_c(my_minute, my_second, sep = ":"),
    TRUE ~ str_c(my_hour, my_minute, my_second, sep = ":"))
  
  return(total_time)
}