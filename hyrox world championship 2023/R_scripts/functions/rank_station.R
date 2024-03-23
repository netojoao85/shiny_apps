rank_function <- function(rank_var){
  case_when(
    rank_var == 1 ~ str_c(rank_var, "st"),
    rank_var == 2 ~ str_c(rank_var, "nd"),
    TRUE ~ str_c(rank_var, "th")
  )
}