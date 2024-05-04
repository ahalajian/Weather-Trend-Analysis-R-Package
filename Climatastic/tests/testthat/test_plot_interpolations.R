test_that("plot interpolations (1)", {
  #default resolution
  grid_pts <- create_grid_pts()
  #fake interpolations
  interpolations <- cbind(grid_pts[,c(1,2)], predictions = rep(1:16, length.out = nrow(grid_pts)))

  #checking that it does not produce an error
  expect_equal(
    plot_interpolations(interpolations, grid_pts), NULL
  )
}
)
