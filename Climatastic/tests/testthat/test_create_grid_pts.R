test_that("grid points creation (1)", {
  #default resolution
  grid_pts <- create_grid_pts()

  expect_equal(
    names(grid_pts),
    c("LONGITUDE", "LATITUDE")
  )

  usa_boundary <- maps::map("usa", plot = FALSE)$range
  expect_equal(
    c(all(usa_boundary[1] <= grid_pts$LONGITUDE),
      all(usa_boundary[2] >= grid_pts$LONGITUDE),
      all(usa_boundary[3] <= grid_pts$LATITUDE),
      all(usa_boundary[4] >= grid_pts$LATITUDE)
      ),
    c(TRUE, TRUE, TRUE, TRUE)
  )
}
)

#test_that("grid points creation (2)", {
#  resolution <- 0.1
#  grid_pts <- create_grid_pts(resolution)

#  expect_equal( names(grid_pts), c("LONGITUDE", "LATITUDE") )
  # maps::map("usa", plot = FALSE)$range
#}
#)


#makes data frame with two columns
#names of two columns are longitude and latitude
#test within minimum and maximum bound
