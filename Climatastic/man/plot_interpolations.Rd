% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_interpolations.R
\name{plot_interpolations}
\alias{plot_interpolations}
\title{Plot the gridded interpolations on a map}
\usage{
plot_interpolations(interpolations, grid_pts, ...)
}
\arguments{
\item{interpolations}{a "Dataframe" object returned from
\code{\link{interpolate_grid_pts}}, containing columns \code{LONGITUDE}
and \code{LATITUDE}.}

\item{grid_pts}{a "Dataframe" object returned from
\code{\link{create_grid_pts}}, containing columns \code{LONGITUDE},
\code{LATITUDE}, and \code{inside_usa}.}

\item{...}{further graphical parameters from \link{par} to appear in the
output graph. Note that the x-axis and y-axis titles cannot be modified.
They will always be Longitude and Latitude respectively.}
}
\description{
This function plots all the gridded interpolations on a map, along with the
contiguous border of the USA, and its grid points.
}
\examples{
grid_pts <- create_grid_pts()
interpolations <- cbind(grid_pts[,c(1,2)], predictions = rep(1:16, length.out = nrow(grid_pts)))
plot_interpolations(interpolations, grid_pts)
}
