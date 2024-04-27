yearly_cycle <- function(station){
  data$day <- format(data[["LST_DATE"]], "%j")
  result <- data |> dplyr::filter(WBANNO == station) |> dplyr::group_by(day) |> dplyr::summarize(expected_avg_temp = mean(T_DAILY_AVG, na.rm = TRUE))
  return(as.data.frame(result))
}
