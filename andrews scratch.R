devtools::load_all()

#data("allweather")
extract_time_series(53878, "2010-01-01", "2019-02-02")


yearly_cycle(53878)

plot(create_grid_pts())
create_grid_pts()

interpolations <- interpolate_station_data()
plot(interpolations$LONGITUDE, interpolations$LATITUDE)
plot_interpolations(interpolations, create_grid_pts())

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
