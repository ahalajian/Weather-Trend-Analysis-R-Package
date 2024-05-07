#' Estimate the trend of temperatures over time
#'
#' This function calculates the trend of temperatures over time, in units of
#' degrees Celsius per year. Returns a dataframe
#' containing expected average temperature of each day of the year.
#' @param station_daily_data daily weather data for a specific USCRN station id
#' @return a vector containing the coefficient/trend estimate, the standard
#' error of the coefficient, and the p-value of the coefficient.
#' @examples
#' # Get trend estimate for station NC_Asheville_8_SSW
#' station_id <- 53877
#' station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station_id, ]
#' trend_estimate(station_daily_data)
#' @export
trend_estimate <- function(station_daily_data){
  num_years_since <-
    as.numeric(station_daily_data[["LST_DATE"]] - as.Date("2000-01-01")) / 365.25
  model <- stats::lm(station_daily_data$T_DAILY_AVG ~ num_years_since)

  #obtain both coefficient and standard error
  out <- c(stats::coef(model)[2],
           summary(model)$coefficients[2, "Std. Error"],
           summary(model)$coefficients[2, "Pr(>|t|)"])
  names(out) <- c("Coefficient", "Standard Error", "P-value")
  return(out) #return p-value, standard-error
}
