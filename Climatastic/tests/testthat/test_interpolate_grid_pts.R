test_that("test interpolate (1)", {
  grid_pts <- create_grid_pts()
  station_locs <- station_data[, c("LONGITUDE", "LATITUDE")]
  interpolation_data <- tapply(daily_weather_data$T_DAILY_AVG,
                               daily_weather_data$station_name, mean, na.rm = TRUE)
  interpolations <- interpolate_grid_pts(station_locs,
    interpolation_data = interpolation_data, grid_pts = grid_pts[,c(1,2)])

  #structure of data frame is as expected
  expect_equal(
    c(length(interpolations), names(interpolations)),
    c(3, c("LONGITUDE", "LATITUDE", "predictions"))
  )

  #that no grid points from input are lost
  expect_equal(
    nrow(interpolations), nrow(grid_pts)
  )

  #type test
  expect_equal(is.data.frame(interpolations), TRUE)
}
)

test_that("test interpolate (2)", {
  grid_pts <- create_grid_pts()
  station_locs <- station_data[, c("LONGITUDE", "LATITUDE")]
  interpolation_data <- tapply(daily_weather_data$SOLARAD_DAILY,
                               daily_weather_data$station_name, mean, na.rm = TRUE)
  interpolations <- interpolate_grid_pts(station_locs,
                                         interpolation_data = interpolation_data, grid_pts = grid_pts[,c(1,2)])

  #structure of data frame is as expected
  expect_equal(
    c(length(interpolations), names(interpolations)),
    c(3, c("LONGITUDE", "LATITUDE", "predictions"))
  )

  #that no grid points from input are lost
  expect_equal(
    nrow(interpolations), nrow(grid_pts)
  )

  #type test
  expect_equal(is.data.frame(interpolations), TRUE)
}
)


