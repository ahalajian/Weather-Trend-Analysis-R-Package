#' Interpolate data from the stations to grid points within the contiguous USA
#'
#' This function interpolates all the stations to grid points by returning the
#' stations that are within the contiguous USA.
#'
#' @return a Dataframe containing the following columns
#' \itemize{
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
interpolate_station_data <- function(){
  #remove station data in Alaska, Hawaii, Ontario, and Sakha Republic
  #remove duplicate station longitude and latitude information
  return (unique(data[!data$state %in% c("ON", "SA", "HI", "AK"), c("WBANNO", "station_name", "LONGITUDE", "LATITUDE")]) )
}
