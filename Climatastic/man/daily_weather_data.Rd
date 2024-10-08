% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/daily_weather_data.R
\docType{data}
\name{daily_weather_data}
\alias{daily_weather_data}
\title{Daily Weather Data of USCRN Stations}
\format{
a dataframe with 1134351 rows and 13 columns
\describe{
    \item{WBANNO}{station WBAN number}
    \item{LST_DATE}{the Local Standard Time (LST) date of the observation.}
    \item{CRX_VN}{The version number of the station datalogger program that
    was in effect at the time of the observation}
    \item{LONGITUDE}{Station longitude}
    \item{LATITUDE}{Station latitude}
    \item{T_DAILY_MAX}{Maximum air temperature, in degrees C}
    \item{T_DAILY_MIN}{Minimum air temperature, in degrees C}
    \item{T_DAILY_MEAN}{Mean air temperature, in degrees C, calculated using the typical
    historical approach: (T_DAILY_MAX + T_DAILY_MIN) / 2}
    \item{T_DAILY_AVG}{Average air temperature, in degrees C}
    \item{P_DAILY_CALC}{Total amount of precipitation, in mm}
    \item{SOLARAD_DAILY}{Total solar energy, in MJ/meter^2, calculated from the hourly average
    global solar radiation rates and converted to energy by integrating
    over time}
    \item{state}{U.S. state that the station is located in}
    \item{station_name}{name of the USCRN station}
}
}
\usage{
daily_weather_data
}
\description{
A dataset with the daily data from USCRN weather stations within contiguous
USA, including station identifier, longitude, latitude, station name, and
state.
}
\keyword{datasets}
