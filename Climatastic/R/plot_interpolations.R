plot_interpolations <- function(interpolations, usa_grids){
  maps::map("usa")
  points(usa_grids)
  points(interpolations$LONGITUDE, interpolations$LATITUDE, pch = "x", cex = 0.5)
}
