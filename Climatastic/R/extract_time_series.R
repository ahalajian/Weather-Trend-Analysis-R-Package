#have to write the documentation here for the function
#automatically creates separate file

extract_time_series <- function(station, start = as.Date("2000-01-01"), end = as.Date("2024-05-07")){

  this_station <- data |> dplyr::filter(WBANNO == station & start <= LST_DATE & end >= LST_DATE)

  return(this_station)

}
