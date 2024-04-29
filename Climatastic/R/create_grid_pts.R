#' Create grid of points that fall within the contiguous USA.
#'
#' Return a Dataframe containing longitude and latitudes
#' of grid points within the contiguous USA based on the resolution specified.
#'
#' @param resolution number: increment of the sequence of longitude and
#' latitude grid points
#' @return a data-frame with the longitudes and latitudes of grid points within
#' contiguous USA based on specified resolution.
#' @return a Dataframe containing the following columns
#' \itemize{
#'   \item \code{LONGITUDE} longitude of grid points within contiguous USA
#'   \item \code{LATITUDE} latitude of grid points within contiguous USA
#' }
#'
#' @examples
#' # create grid points with high resolution
#' grid_pts <- create_grid_pts(0.1)
#' plot(grid_pts)
#' @export
create_grid_pts <- function(resolution = 1) {

  # get data about contiguous US boundary coordinates and ranges
  usa_map <- maps::map("usa", plot = FALSE)
  usa_boundary <- usa_map$range

  #generate longitude and latitude based on resolution within max and min
  longitude <- seq(usa_boundary[1], usa_boundary[2], by = resolution)
  latitude <- seq(usa_boundary[3], usa_boundary[4], by = resolution)
  grid_points <- expand.grid(LONGITUDE = longitude, LATITUDE = latitude)

  #determine which grid_points are actually in contiguous US
  inside_usa <-
    which(sp::point.in.polygon(
      grid_points$LONGITUDE, grid_points$LATITUDE,
      usa_map$x[1:6886], usa_map$y[1:6886]) == 1)

  #There are several NA's in our x and y boundaries for contiguous USA, which
  #denote the boundaries for an island that are connected to mainland USA.
  #We thus identify individually whether there exist grid points within those
  #island boundaries.
  inside_usa <- c()
  start <- 1
  na_vals <- which(is.na(usa_map$x))

  for (na_val in na_vals) {

    inside_island <- which(sp::point.in.polygon(
      grid_points$LONGITUDE, grid_points$LATITUDE,
      usa_map$x[start:na_val - 1], usa_map$y[start:na_val - 1]) == 1)

    inside_usa <- c(inside_usa, inside_island)
    start <- na_val + 1
  }

  result <- grid_points[inside_usa, ]
  rownames(result) <- NULL #reset subsetted indices

  return(result)

}
