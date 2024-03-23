avg_station <- function(data, range_variables, n){
  total <- data %>% 
    mutate(across(c(range_variables), ~as.duration(ms(.x)))) %>% 
    mutate(sum_time = seconds_to_period(rowSums(select(., range_variables) / n)))
  
  my_minute <- formatC(minute(total$sum_time), digits = 1, format = 'd', flag = "0#")
  my_second <- formatC(second(total$sum_time), digits = 1, format = 'd', flag = "0#")
  
  avg <- str_c(my_minute, my_second, sep = ":")
  
  return(avg)
}