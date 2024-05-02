#' Estimate the trend of temperatures over time
#'
#' This function calculates the trend of temperatures over time, in units of degrees Celsius per year. Returns a dataframe
#' containing expected average temperature of each day of the year.
#'
#' @export
trend_estimate <- function(){
  num_years_since <-
    as.numeric(daily_weather_data[["LST_DATE"]] - as.Date("2000-01-01")) / 365.25
  model <- stats::lm(daily_weather_data$T_DAILY_AVG ~ num_years_since)
  return(stats::coef(model)[2])
}

#for a single station
#should involve cosine and sine again

#obtain days since january 1, 2000, divide by 365.25
#num_years_since <-
#  as.numeric(daily_weather_data[["LST_DATE"]] - as.Date("2000-01-01")) / 365.25
#model <- lm(daily_weather_data$T_DAILY_AVG ~ num_years_since)
#summary(model)

#theta <- 2 * pi * num_years_since
#sine_term <- sin(theta)
#cosine_term <- cos(theta)

#model <- lm(T_DAILY_AVG ~ sine_term + cosine_term, data = daily_weather_data)
#summary(model)

#account for cosine and sine

