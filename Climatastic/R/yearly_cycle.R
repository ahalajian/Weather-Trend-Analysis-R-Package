#' Estimate the yearly cycle for one station
#'
#' This function estimates a station's yearly cycle, which is simply the
#' expected temperature on each day of the year. The estimation occurs by using
#' sine and cosine terms in the model to predict expected temperature. Returns
#' a dataframe containing expected average temperature of each day of the year.
#'
#' Note that this function removes all instances of leap days from the function.
#'
#' @param station_daily_data daily weather data for a specific USCRN station id
#' @return a Dataframe containing the following columns:
#' \itemize{
#'   \item day: day number (1-365)
#'   \item expected_avg_temp: expected average temperature on each day
#' }
#' @examples
#' # Get yearly cycle for station NC_Asheville_8_SSW
#' station_id <- 53877
#' station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station_id, ]
#' yearly_cycle(station_daily_data)
#' @export
yearly_cycle <- function(station_daily_data){

  #extract data for station
  #station_ind_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  ind_data_cleaned <- station_daily_data[!is.na(station_daily_data$T_DAILY_AVG), ]

  #remove leap days:
  #remove all feb 29. instances
  #if year is 2000, 2004, 2008, 2012, 2016, 2020, or 2024, and day is (strictly)
  #greater than 60, subtract by 1

  #determine leap day instances and remove them
  is_leap_day <- format(ind_data_cleaned$LST_DATE, "%m-%d") == format(as.Date("2024-2-29"), "%m-%d")
  ind_data_cleaned <- ind_data_cleaned[!is_leap_day, ]

  day <- as.numeric(format(ind_data_cleaned$LST_DATE, "%j"))

  #determine leap year instances, if day is (strictly) greater than 60, subtract by 1
  is_leap_year <- format(ind_data_cleaned$LST_DATE, "%Y") %in% c("2000", "2004", "2008", "2012", "2016", "2020", "2024")
  day[is_leap_year & day > 60] <- day[is_leap_year & day > 60] - 1

  #use sine and cosine with revised period
  sine_term <- sin(2*pi*day/365.25)
  cos_term <- cos(2*pi*day/365.25)
  model_trig <- stats::lm(ind_data_cleaned$T_DAILY_AVG ~ sine_term + cos_term)

  #predictions
  newdata <- data.frame(sine_term = sin(2*pi*(1:365)/365.25), cos_term = cos(2*pi*1:365/365.25))
  pred <- stats::predict((model_trig), newdata = newdata)

  df <- data.frame(day = as.numeric(names(pred)),
                   expected_avg_temp = pred)
  return(df)
}

