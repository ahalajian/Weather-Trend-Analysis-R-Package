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
  ind_data_cleaned <- station_ind_data[!is.na(station_ind_data$T_DAILY_AVG), ]

  day <- as.numeric(format(ind_data_cleaned$LST_DATE, "%j"))

  #use sine and cosine with revised period
  sine_term <- sin(2*pi*day/365.25)
  cos_term <- cos(2*pi*day/365.25)
  model_trig <- stats::lm(ind_data_cleaned$T_DAILY_AVG ~ sine_term + cos_term)

  #obtain expected average temperature by predicting on the training data
  pred <- stats::predict(model_trig,
                  newdata = data.frame(ind_data_cleaned$T_DAILY_AVG))
  exp_avg_temp <- tapply(pred, day, mean)

  df <- data.frame(day = as.numeric(names(exp_avg_temp)),
                   expected_avg_temp = exp_avg_temp)

  return(df)
}

