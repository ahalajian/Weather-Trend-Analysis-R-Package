#' Estimate the trend of temperatures over time
#'
#' This function calculates the trend of temperatures over time, in units of degrees Celsius per year. Returns a dataframe
#' containing expected average temperature of each day of the year.
#'
#' @export
trend_estimate <- function(){
  data$year <- as.numeric(format(data[["LST_DATE"]], "%y"))
  model <- lm(T_DAILY_AVG ~ year, data = data)
  temp_trend <- coef(model)[2]
  return(temp_trend)
}
