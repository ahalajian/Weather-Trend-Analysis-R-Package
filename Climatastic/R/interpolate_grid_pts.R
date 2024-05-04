#' Interpolate data from the stations to grid points within the contiguous USA
#'
#' This function interpolates (predicts) all the station data to grid points by
#' fitting a spatial model to the provided data.
#'
#' @param station_locs a "data.frame" object containing the following two
#' columns
#' \itemize{
#'   \item \code{LONGITUDE} station longitudes
#'   \item \code{LATITUDE} station latitudes
#' }
#' @param station_covariates a "data.frame" object containing any covariate
#' data to include in the spatial model. If not provided, station longitudes
#' and latitudes would be used instead.
#' @param interpolation_data a vector containing the data to interpolate.
#' @param grid_covariates a "data.frame" object containing any covariate data to
#' include in the spatial model. If not provided, grid longitudes and
#' latitudes would be used instead.
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
#'
#' Note that if either \code{station_covariates} or \code{grid_covariates} are left empty,
#' then they will both be replaced with their respective longitudes and
#' latitudes.
#'
#' Additionally, note that all arguments provided must respect the dimensions
#' of all other arguments.
#' @examples
#' # Interpolate T_DAILY_AVG from stations to grid points
#' grid_pts <- create_grid_pts()
#' station_locs <- station_data[, c("LONGITUDE", "LATITUDE")]
#' interpolation_data <- tapply(daily_weather_data$T_DAILY_AVG,
#' daily_weather_data$station_name, mean, na.rm = TRUE)
#' interpolations <- interpolate_grid_pts(station_locs,
#' interpolation_data = interpolation_data, grid_pts = grid_pts[,c(1,2)])
#' @export
interpolate_grid_pts <- function(station_locs, station_covariates = NULL,
                                 interpolation_data, grid_pts, grid_covariates = NULL){

  #ensures that longitudes and latitudes are numeric
  station_locs$LONGITUDE <- as.numeric(station_locs$LONGITUDE)
  station_locs$LATITUDE <- as.numeric(station_locs$LATITUDE)

  #if either set of covariates are empty, then just use longitude and latitude
  if(is.null(station_covariates) | is.null(grid_covariates)){
    station_covariates <- station_locs
    grid_covariates <- grid_pts
  }

  #remove all rows with NA's in the third column
  ii <- !is.na(interpolation_data)
  interpolation_data <- interpolation_data[ii]
  station_locs <- station_locs[ii, ]
  station_covariates <- station_covariates[ii, ]


  #design matrix and locs for training
  X <- stats::model.matrix(~ ., data = station_covariates)
  locs <- station_locs

  spatial_model <- GpGp::fit_model(y = interpolation_data,
                             locs = locs,
                             X = X,
                             covfun_name = "matern_sphere",
                             silent = TRUE)

  #design matrix for predictions
  X_pred = stats::model.matrix(~ ., data = grid_covariates)

  predictions <- GpGp::predictions(fit = spatial_model,
                                   locs_pred = grid_pts, X_pred = X_pred)

  return (cbind(grid_pts, predictions))
}
