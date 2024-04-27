interpolate_station_data <- function(){
  return (unique(data[!data$state %in% c("ON", "SA", "HI", "AK"), c("station_name", "LONGITUDE", "LATITUDE")]) )
}
