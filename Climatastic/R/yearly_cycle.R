#' Estimate the yearly cycle for one station
#'
#' This function calculates a station's yearly cycle, which is simply the
#' expected temperature on each day of the year. Returns a dataframe
#' containing expected average temperature of each day of the year.
#'
#' @param station USCRN station WBAN number id
#' @return a Dataframe containing the following columns:
#' \itemize{
#'   \item day: day number (1-366)
#'   \item expected_avg_temp: expected average temperature on each day
#' }
#' @examples
#' # Get yearly cycle for station NC_Asheville_8_SSW
#' station_id <- 53877
#' forecast <- yearly_cycle(station_id)
#' print(forecast)
#' @export
yearly_cycle <- function(station){

  #extract data for station
  station_ind_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  day <- format(station_ind_data$LST_DATE, "%j")

  #obtain mean of T_DAILY_AVG by day
  avg_temp <- tapply(station_ind_data$T_DAILY_AVG, day, mean, na.rm = TRUE)

  df <- data.frame(day = as.numeric(names(avg_temp)), expected_avg_temp = avg_temp)

  return(df)
}
