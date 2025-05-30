% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/alignpatch-inset.R
\name{inset}
\alias{inset}
\title{Create a ggplot inset}
\usage{
inset(plot, ..., align = "panel", on_top = TRUE, clip = TRUE, vp = NULL)
}
\arguments{
\item{plot}{Any graphic that can be converted into a \code{\link[grid:grid.grob]{grob}}
using \code{\link[=patch]{patch()}}.}

\item{...}{Additional arguments passed to the \code{\link[=patch]{patch()}} method.}

\item{align}{A string specifying the area to place the plot: \code{"full"} for the
full area, \code{"plot"} for the full plotting area (including the axis label), or
\code{"panel"} for only the actual area where data is drawn.}

\item{on_top}{A single boolean value indicates whether the graphic plot
should be put frontmost. Note: the graphic plot will always put above the
background.}

\item{clip}{A single boolean value indicating whether the grob should be
clipped if they expand outside their designated area.}

\item{vp}{A \code{\link[grid:viewport]{viewport}} object, you can use this to define
the plot area.}
}
\value{
A \code{patch_inset} object, which can be added in ggplot.
}
\description{
Create a ggplot inset
}
\examples{
library(grid)
p1 <- ggplot(mtcars) +
    geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) +
    geom_boxplot(aes(gear, disp, group = gear))
p1 + inset(p2, vp = viewport(0.6, 0.6,
    just = c(0, 0), width = 0.4, height = 0.4
))
}
