devtools::load_all()

extract_time_series(53878, "2010-01-01", "2019-02-02")


yearly_cycle(53878)

grid_pts <- create_grid_pts()

station_locs <- station_data[, c("LONGITUDE", "LATITUDE")]
avg_station_weather <- tapply(daily_weather_data$T_DAILY_AVG, daily_weather_data$station_name, mean, na.rm = TRUE)
station_weather_data <- cbind(station_locs, avg_station_weather)

interpolations <- interpolate_grid_pts(station_weather_data, grid_pts)
interpolations


plot(interpolations$LONGITUDE, interpolations$LATITUDE)
plot_interpolations(interpolations, create_grid_pts())

#interpolations is a vector of predictions
#grid_points is all of the points in the usa


latnum <- floor(sqrt(length(interpolations)/(57/23)))
lonnum <- floor(latnum*(57/23))

pred_array <- array(interpolations, lonnum, latnum)

#im kinda rewriting our usa gridpoint function here but im gonna finish and
#then maybe we can redo that one/refer to that function in this function
usa_map <- maps::map("usa", plot = FALSE)
usa_boundary <- usa_map$range

lon <- seq(usa_boundary[1], usa_boundary[2], length.out = lonnum)
lat <- seq(usa_boundary[3], usa_boundary[4], length.out = latnum)

fields::image.plot(interpolations) #this plots our predictions on square usa but not well

x <-  c(1,2,3,4,NA,5,NA,7,8)
y <- c(1:12, NA, 13,14)
z <- outer(x,y,"+")
z
fields::image.plot(x,y,z)
grid_pts

#either
#matrix() for create_grid_pts()
#leave NA's for


#interp.surface(x = station_data$LONGITUDE, y = station_data$LATITUDE,
 #              z = avg_station_weather, xo = grid_pts$LONGITUDE, yo = grid_pts$LATITUDE, method = "bilinear")


devtools::document()
#Rd files will not appear until we write Roxygen comments in R files

devtools::test()

devtools::build()
#

devtools::check()
#must pass all the checks

#average temperature for each station
station_data
yearly_cycle()
