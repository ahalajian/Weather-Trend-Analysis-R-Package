#' Grid of points that fall within the contiguous USA.
#'
#' Return an dataframe containing longitude and latitudes
#' of grid points within the contiguous USA based on the resolution.
#'
#' @param resolution number: increment of the sequence of longitude and
#' latitude grid points
#' @return a data-frame with the longitudes and latitudes of grid points within
#' contiguous USA based on specified resolution.
#'
#' @examples
#' grid_pts <- create_grid_pts( 0.1 )
#' plot(grid_pts)
#' @export
create_grid_pts <- function(resolution = 0.1) {

  usa_map <- maps::map("usa", plot = FALSE) # Load map data for the contiguous USA

  usa_boundary <- usa_map$range # Extract the boundary coordinates of the contiguous USA

  lon <- seq(usa_boundary[1], usa_boundary[2], by = resolution)
  lat <- seq(usa_boundary[3], usa_boundary[4], by = resolution)
  grid_points <- expand.grid(lon = lon, lat = lat) # Create a grid of points within the boundary

  inside_usa <- which(sp::point.in.polygon(grid_points$lon, grid_points$lat, usa_map$x[1:6886], usa_map$y[1:6886]) == 1)

  return(grid_points[inside_usa, ])

}
