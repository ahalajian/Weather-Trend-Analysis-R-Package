test_that("grid points creation (1)", {
  #default resolution
  grid_pts <- create_grid_pts()

  expect_equal(
    names(grid_pts),
    c("LONGITUDE", "LATITUDE", "inside_usa")
  )

  #checking if longitudes and latitudes are within minimum and maximum usa bounds
  usa_boundary <- maps::map("usa", plot = FALSE)$range
  expect_equal(
    c(all(usa_boundary[1] <= grid_pts$LONGITUDE),
      all(usa_boundary[2] >= grid_pts$LONGITUDE),
      all(usa_boundary[3] <= grid_pts$LATITUDE),
      all(usa_boundary[4] >= grid_pts$LATITUDE)
      ),
    c(TRUE, TRUE, TRUE, TRUE)
  )

  expect_equal(
    is.data.frame(grid_pts), TRUE
  )
}
)

test_that("grid points creation (2)", {
  #different resolution
  grid_pts <- create_grid_pts(resolution = 0.5)

  expect_equal(
    names(grid_pts),
    c("LONGITUDE", "LATITUDE", "inside_usa")
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

  expect_equal(
    is.data.frame(grid_pts), TRUE
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


#makes data frame with three columns
#names of two columns are longitude and latitude, and inside_usa
#test within minimum and maximum bound
#type dataframe
#different reoslution
