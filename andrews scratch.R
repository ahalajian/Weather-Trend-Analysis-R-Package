devtools::load_all()

station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == 53878, ]

extract_time_series(station_daily_data, "2010-01-01", "2019-02-02")

yearly_cycle(station_daily_data)

trend_estimate(station_daily_data)

grid_pts <- create_grid_pts(resolution = 1)

station_locs <- station_data[, c("LONGITUDE", "LATITUDE")]
interpolation_data <- tapply(daily_weather_data$T_DAILY_AVG,
daily_weather_data$station_name, mean, na.rm = TRUE)
interpolations <- interpolate_grid_pts(station_locs,
interpolation_data = interpolation_data, grid_pts = grid_pts[,c(1,2)])

plot_interpolations(interpolations, grid_pts)

devtools::document()
#Rd files will not appear until we write Roxygen comments in R files

devtools::test()

devtools::build()

devtools::check()
#must pass all the checks

#average temperature for each station
station_data
yearly_cycle()
