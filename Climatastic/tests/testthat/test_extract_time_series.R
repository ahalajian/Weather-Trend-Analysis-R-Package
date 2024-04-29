library("testthat")

test_that("time series extracted (1)", {
  station <- 53878
  start <- "2010-01-01"
  end <- "2019-02-02"
  time_series <- extract_time_series(station, start, end)
  
  expect_equal(
    time_series[1,2],
    "2010-01-01"
  )
  expect_equal(
    time_series[nrow(time_series),2],
    "2019-02-02"
  )
  expect_equal(
    time_series[nrow(time_series)-21,1],
    53878
  )
}
)



test_that("time series extracted (2)", {
  station <- 53024
  time_series <- extract_time_series(station)
  
  expect_equal(
    time_series[1,2],
    "2011-06-24"
  )
  expect_equal(
    time_series[nrow(time_series),2],
    "2014-06-01"
  )
  expect_equal(
    time_series[nrow(time_series)-56,1],
    53024
  )
}
)


test_that("time series extracted (3)", {
  station <- 54937
  time_series <- extract_time_series(station)
  
  expect_equal(
    time_series[1,2],
    "2008-07-29"
  )
  expect_equal(
    time_series[nrow(time_series),2],
    "2024-04-07"
  )
  expect_equal(
    time_series[nrow(time_series)-1654,1],
    54937
  )
}
)

test_that("time series extracted (4)", {
  station <- 4141
  start <- "2020-02-02"
  time_series <- extract_time_series(station, start)
  
  expect_equal(
    time_series[1,2],
    "2020-02-02"
  )
  expect_equal(
    time_series[nrow(time_series),2],
    "2024-04-07"
  )
  expect_equal(
    time_series[nrow(time_series)-500,1],
    4141
  )
}
)


test_that("time series extracted (5)", {
  station <- 94088
  end <- "2020-02-02"
  time_series <- extract_time_series(station, end)
  
  expect_equal(
    time_series[1,2],
    "2007-08-22"
  )
  expect_equal(
    time_series[nrow(time_series),2],
    "2020-02-02"
  )
  expect_equal(
    time_series[nrow(time_series)-178,1],
    94088
  )
}
)
