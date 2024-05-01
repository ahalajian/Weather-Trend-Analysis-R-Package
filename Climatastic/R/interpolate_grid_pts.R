#' Interpolate data from the stations to grid points within the contiguous USA
#'
#' This function interpolates all the stations to grid points by returning the
#' stations that are within the contiguous USA.
#'
#' @return a Dataframe containing the following columns
#' \itemize{
#'   \item \code{WBANNO} station WBAN number
#'   \item \code{station_name} name of the USCRN station
#'   \item \code{LONGITUDE} Station longitude
#'   \item \code{LATITUDE} Station latitude
#' }
#' @examples
#' # Get yearly cycle for station NC_Asheville_8_SSW
#' interpolations <- interpolate_station_data()
#' plot(interpolations$LONGITUDE, interpolations$LATITUDE)
#' plot_interpolations(interpolations, create_grid_pts())
#' @export
interpolate_grid_pts <- function(station_weather_data, grid_pts){
  #station_weather_data: longitude, latitude, and some third column that we predict
  #grid_pts has two columns of longitude and latitude

  X <- model.matrix(~ LONGITUDE + LATITUDE, data = station_weather_data)

  #longitudes and latitudes
  locs <- station_weather_data[, c(1,2)]


  spatial_model <- fit_model(y = station_weather_data[,3],
                             locs = locs,
                             covfun_name = "matern_sphere",
                             silent = TRUE)

  X_pred = model.matrix(~ LONGITUDE + LATITUDE, data = grid_pts)

  predictions(fit = spatial_model, locs_pred = grid_pts, X_pred = X_pred)

  return (cbind(grid_pts, predictions))
}
