trend_estimate <- function(){
  data$year <- as.numeric(format(data[["LST_DATE"]], "%y"))
  model <- lm(T_DAILY_AVG ~ year, data = data)
  temp_trend <- coef(model)[2]
  return(temp_trend)
}
