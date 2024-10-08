% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_time_series.R
\name{extract_time_series}
\alias{extract_time_series}
\title{Extract the time series for a specific station by station id.}
\usage{
extract_time_series(
  station_daily_data,
  start = as.Date("2000-11-14"),
  end = as.Date("2024-04-08")
)
}
\arguments{
\item{station_daily_data}{daily weather data for a specific USCRN station id}

\item{start}{a "Date" object, returned from \code{\link{as.Date}}. Starting
datefor time series. Defaults to \code{as.Date("2000-11-14")}
(earliest entry in data).}

\item{end}{a "Date" object, returned from \code{\link{as.Date}}. Ending
date for time series. Defaults to \code{as.Date("2024-04-08")}
(when data was retrieved).}
}
\value{
a Dataframe containing all the columns of allweather within the
specified start and end date.
}
\description{
Get the USCRN time series weather data for a given station id within the
optionally specified start and end dates.
}
\examples{
# get time series for station NC_Asheville_8_SSW from 2000-2020
end_date <- as.Date("2020-12-31")
station_id <- 53877
station_daily_data <- daily_weather_data[daily_weather_data$WBANNO == station_id, ]
asheville_2000_2020 <- extract_time_series(station_daily_data, end = end_date)
print(asheville_2000_2020$T_DAILY_MAX)
}
