#' Extract the time series for a specific station by station id.
#'
#' Get the USCRN time series weather data for a given station id within the
#' optionally specified start and end dates.
#'
#' @param station_daily_data daily weather data for a specific USCRN station id
#' @param start a "Date" object, returned from \code{\link{as.Date}}. Starting
#' datefor time series. Defaults to \code{as.Date("2000-11-14")}
#' (earliest entry in data).
#' @param end a "Date" object, returned from \code{\link{as.Date}}. Ending
#' date for time series. Defaults to \code{as.Date("2024-04-08")}
#' (when data was retrieved).
#' @return a Dataframe containing all the columns of allweather within the
#' specified start and end date.
#' @examples
#' # get time series for station NC_Asheville_8_SSW from 2000-2020
#' end_date <- as.Date("2020-12-31")
#' station_id <- 53877
#' station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station_id, ]
#' asheville_2000_2020 <- extract_time_series(station_daily_data, end = end_date)
#' print(asheville_2000_2020$T_DAILY_MAX)
#' @export
extract_time_series <- function(station_daily_data,
  start = as.Date("2000-11-14"), end = as.Date("2024-04-08")){

  return(station_daily_data[start <= station_daily_data$LST_DATE &
                       end >= station_daily_data$LST_DATE, ])
}
