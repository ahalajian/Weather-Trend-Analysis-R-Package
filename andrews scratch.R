devtools::load_all()

#data("allweather")
extract_time_series(53878, "2010-01-01", "2019-02-02")

yearly_cycle(53878)

create_grid_pts()

plot_interpolations(interpolate_station_data(), create_grid_pts(resolution = 1))

devtools::document()
#Rd files will not appear until we write Roxygen comments in R files

#devtools::test()
