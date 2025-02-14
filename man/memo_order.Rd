% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layout-heatmap-oncoplot.R
\name{memo_order}
\alias{memo_order}
\title{Sort matrix for better visualization}
\usage{
memo_order(x)
}
\arguments{
\item{x}{A matrix, where \code{NA} values will be treated as empty.}
}
\value{
A vector of ordering weights.
}
\description{
Helper function used to order the Oncoplot samples. Typically, you would use
this in combination with \code{\link[=align_reorder]{align_reorder()}}, e.g.,
\code{align_reorder(memo_order)}.
}
