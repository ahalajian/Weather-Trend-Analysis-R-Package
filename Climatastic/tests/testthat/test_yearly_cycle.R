test_that("test yearly cycle (1)", {
  station <- 53878
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  cycle <- yearly_cycle(station_daily_data)

  #checking that dataframe has 366 rows and range from 1-366
  expect_equal(
    c(nrow(cycle), all(cycle$day == 1:366)),
    c(366, TRUE)
  )

  #type checking output and one of the output columns
  expect_equal(
    c(is.data.frame(cycle), is.numeric(cycle$expected_avg_temp)), c(TRUE, TRUE)
  )
}
)

test_that("test yearly cycle (2)", {
  station <- 3739
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  cycle <- yearly_cycle(station_daily_data)

  expect_equal(
    c(nrow(cycle), all(cycle$day == 1:366)),
    c(366, TRUE)
  )

  expect_equal(
    c(is.data.frame(cycle), is.numeric(cycle$expected_avg_temp)), c(TRUE, TRUE)
  )

}
)
