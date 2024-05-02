#' Interpolate data from the stations to grid points within the contiguous USA
#'
#' This function interpolates (predicts) all the stations to grid points by returning the
#' stations that are within the contiguous USA.
#'
#' @param station_weather_data a "data.frame" object containing the following two
#' columns
#' \itemize{
#'   \item \code{LONGITUDE} station longitudes
#'   \item \code{LATITUDE} station latitudes
#'   Additionally, there must be a third column, which is the data the we
#'   interpolate from the stations to the grid points. Please note that the
#'   non-longitude and non-latitude column must be last among all columns.
#' }
#' @param grid_pts a "data.frame" object returned from
#' \code{\link{create_grid_pts}}, containing columns \code{LONGITUDE}
#' and \code{LATITUDE}.
#' @return a dataframe containing the following columns
#' \itemize{
#'   \item \code{LONGITUDE} grid point longitudes from \code{grid_pts$LONGITUDE}
#'   \item \code{LATITUDE} grid point latitudes from \code{grid_pts$LATITUDE}
#'   \item \code{predictions} interpolated grid point longitudes and latitudes
#'   for \code{station_weather_data[,3]}
#' }
#' @examples
#' # Interpolate T_DAILY_AVG from stations to grid points
#' grid_pts <- create_grid_pts()
#' station_locs <- station_data[, c("LONGITUDE", "LATITUDE")]
#' avg_T_DAILY_AVG <- tapply(daily_weather_data$T_DAILY_AVG,
#' daily_weather_data$station_name, mean, na.rm = TRUE)
#' station_weather_data <- cbind(station_locs, avg_T_DAILY_AVG)
#' interpolations <- interpolate_grid_pts(station_weather_data, grid_pts)
#' @export
interpolate_grid_pts <- function(station_weather_data, grid_pts){

  #ensures that longitudes and latitudes are numeric
  station_weather_data$LONGITUDE <- as.numeric(station_weather_data$LONGITUDE)
  station_weather_data$LATITUDE <- as.numeric(station_weather_data$LATITUDE)

  #remove all rows with NA's in the third column
  station_weather_data <-
    station_weather_data[!is.na(station_weather_data[,3]), ]

  #design matrix and locs for training
  X <- stats::model.matrix(~ LONGITUDE + LATITUDE, data = station_weather_data)
  locs <- station_weather_data[, c(1,2)]

  spatial_model <- GpGp::fit_model(y = station_weather_data[,3],
                             locs = locs,
                             X = X,
                             covfun_name = "matern_sphere",
                             silent = TRUE)


  #design matrix for predictions
  X_pred = stats::model.matrix(~ LONGITUDE + LATITUDE, data = grid_pts)

  predictions <- GpGp::predictions(fit = spatial_model,
                                   locs_pred = grid_pts, X_pred = X_pred)

  return (cbind(grid_pts, predictions))
}
