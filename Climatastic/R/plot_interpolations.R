#' Plot the gridded interpolations on a map
#'
#' This function plots all the gridded interpolations on a map, along with the
#' contiguous border of the USA, and its grid points.
#'
#' @param interpolations a "Dataframe" object returned from
#' \code{\link{interpolate_grid_pts}}, containing columns \code{LONGITUDE}
#' and \code{LATITUDE}.
#' @param grid_pts a "Dataframe" object returned from
#' \code{\link{create_grid_pts}}, containing columns \code{LONGITUDE},
#' \code{LATITUDE}, and \code{inside_usa}.
#' @return NULL
#' @examples
#' grid_pts <- create_grid_pts()
#' interpolations <- cbind(grid_pts[,c(1,2)], predictions = rep(1:16, length.out = nrow(grid_pts)))
#' plot_interpolations(interpolations, grid_pts)
#' @export
plot_interpolations <- function(interpolations, grid_pts){

  #computations for matrix and plot creation
  unique_longitude <- unique(grid_pts$LONGITUDE)
  unique_latitude <- unique(grid_pts$LATITUDE)
  resolution <- grid_pts$LONGITUDE[2] - grid_pts$LONGITUDE[1]
  lon_length <- (max(grid_pts$LONGITUDE) - min(grid_pts$LONGITUDE)) / resolution + 1
  lat_length <- (max(grid_pts$LATITUDE) - min(grid_pts$LATITUDE)) / resolution + 1

  #replace predictions not inside contiguous USA with NA
  predictions <- replace(interpolations$predictions, !grid_pts$inside_usa, NA)

  #predictions matrix
  pred_matrix <- matrix(predictions, lon_length, lat_length)

  fields::image.plot(unique_longitude, unique_latitude, pred_matrix,
                     main = "Plotted Gridded Interpolations",
                     xlab = "Longitude", ylab = "Latitude")
}
