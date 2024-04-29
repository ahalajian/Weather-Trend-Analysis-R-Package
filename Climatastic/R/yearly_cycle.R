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

  station_data <- data[data$WBANNO == station, ] #extract data for station
  day <- format(station_data$LST_DATE, "%j")  #obtain day of each station data

  #obtain mean of T_DAILY_AVG by day
  avg_temp <- tapply(station_data$T_DAILY_AVG, day, mean, na.rm = TRUE)

  df <- data.frame(day = as.numeric(names(avg_temp)), expected_avg_temp = avg_temp)

  return(df)
}
