#' Plot the gridded interpolations on a map
#'
#' This function plots all the gridded interpolations on a map, along with the
#' contiguous border of the USA, and its grid points.
#'
#' @param interpolations a "Dataframe" object returned from
#' \code{\link{interpolate_station_data}}, containing columns \code{LONGITUDE}
#' and \code{LATITUDE}.
#' @param grid_pts a "Dataframe" object returned from
#' \code{\link{create_grid_pts}}, containing columns \code{LONGITUDE}
#' and \code{LATITUDE}.
#' @return NULL
#' @examples
#' # Plot gridded interpolations
#' interpolations <- interpolate_station_data()
#' grid_pts <- create_grid_pts()
#' plot_interpolations(interpolations, grid_pts)
#' @export
plot_interpolations <- function(interpolations, grid_pts){
  maps::map("usa")
  points(grid_pts, pch = 19, cex = 0.5)
  points(interpolations$LONGITUDE, interpolations$LATITUDE, pch = 4, col = "red", cex = 1)
}
