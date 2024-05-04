#Note that start and end dates were obtained manually from data themselves, if
#we did not specify a start/end date

test_that("time series extracted (1)", {
  station <- 53878
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  start <- as.Date("2010-01-01")
  end <- as.Date("2019-02-02")
  time_series <- extract_time_series(station_daily_data, start, end)

  #first date is consistent with start date
  expect_equal(
    time_series[1,2],
    as.Date("2010-01-01")
  )

  #last date is consistent with end date
  expect_equal(
    time_series[nrow(time_series),2],
    as.Date("2019-02-02")
  )

  #random row's WBANNO is consistent with specified station
  expect_equal(
    time_series[nrow(time_series)-21,1],
    53878
  )
}
)



test_that("time series extracted (2)", {
  station <- 53024
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  #this station has start and end date that's not 1/1/2000 and 4/7/2024
  time_series <- extract_time_series(station_daily_data)

  #first date is its expected first measurement date
  expect_equal(
    time_series[1,2],
    as.Date("2011-06-24")
  )

  #last date is its expected last measurement date
  expect_equal(
    time_series[nrow(time_series),2],
    as.Date("2014-06-01")
  )

  #random row's WBANNO is consistent with specified station
  expect_equal(
    time_series[nrow(time_series)-56,1],
    53024
  )
}
)

test_that("time series extracted (3)", {
  station <- 54937
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  #has start date that's not 1/1/2000, but end date is 4/7/2024
  time_series <- extract_time_series(station_daily_data)

  #first date is its expected first measurement date
  expect_equal(
    time_series[1,2],
    as.Date("2008-07-29")
  )

  #last date is its expected last measurement date
  expect_equal(
    time_series[nrow(time_series),2],
    as.Date("2024-04-07")
  )

  #random row's WBANNO is consistent with specified station
  expect_equal(
    time_series[nrow(time_series)-1654,1],
    54937
  )
}
)

test_that("time series extracted (4)", {
  station <- 4141 #specified start date, but did not specify end date
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  start <- as.Date("2020-02-02")
  time_series <- extract_time_series(station_daily_data, start)

  #first date is its expected first measurement date
  expect_equal(
    time_series[1,2],
    as.Date("2020-02-02")
  )

  #last date is its expected last measurement date
  expect_equal(
    time_series[nrow(time_series),2],
    as.Date("2024-04-07")
  )

  #testing that all WBANNO's are correct and the same
  expect_equal(
    time_series[nrow(time_series)-99,1],
    4141
  )
  expect_equal(
    all(time_series$WBANNO == time_series$WBANNO[1]),
    TRUE
  )
}
)


test_that("time series extracted (5)", {
  station <- 94088
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  end <- as.Date("2020-02-02")
  time_series <- extract_time_series(station_daily_data, end = end)

  #first date is its expected first measurement date
  expect_equal(
    time_series[1,2],
    as.Date("2007-08-22")
  )

  #last date is its expected last measurement date
  expect_equal(
    time_series[nrow(time_series),2],
    as.Date("2020-02-02")
  )
  expect_equal(
    time_series[nrow(time_series)-178,1],
    94088
  )
}
)

test_that("time series extracted (6)", {
  station <- 53877
  station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station, ]
  time_series <- extract_time_series(station_daily_data)

  #first date and end date is its expected first measurement date
  expect_equal(
    c(time_series[1,2],time_series[nrow(time_series),2]),
    c(as.Date("2000-11-14"), as.Date("2024-04-07"))
  )


  expect_equal(
    c(time_series[nrow(time_series)-99,1], all(time_series$WBANNO == time_series$WBANNO[1]) ),
    c(53877, TRUE)
    )

}

)

