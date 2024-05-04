test_that("test trend estimate (1)", {
  station <- 96409
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  trend <- trend_estimate(station_daily_data)

  #checking that output has both coefficient and standard error
  expect_equal(
    length(trend), 2
  )

  expect_equal(
    names(trend), c("Coefficient", "Standard Error")
  )

  #type check
  expect_equal(
    is.numeric(trend), TRUE
  )
}
)

test_that("test trend estimate (2)", {
  station <- 3758
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  trend <- trend_estimate(station_daily_data)

  #checking that output has both coefficient and standard error
  expect_equal(
    length(trend), 2
  )

  expect_equal(
    names(trend), c("Coefficient", "Standard Error")
  )

  #type check
  expect_equal(
    is.numeric(trend), TRUE
  )
}
)
