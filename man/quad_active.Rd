% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layout-quad-switch.R
\name{quad_active}
\alias{quad_active}
\alias{quad_anno}
\alias{anno_top}
\alias{anno_left}
\alias{anno_bottom}
\alias{anno_right}
\title{Determine the Active Context of Quad-Layout}
\usage{
quad_active(width = NULL, height = NULL)

quad_anno(position, size = NULL, free_guides = waiver(), what = waiver())

anno_top(size = NULL, free_guides = waiver(), what = waiver())

anno_left(size = NULL, free_guides = waiver(), what = waiver())

anno_bottom(size = NULL, free_guides = waiver(), what = waiver())

anno_right(size = NULL, free_guides = waiver(), what = waiver())
}
\arguments{
\item{width, height}{The relative width/height of the main plot, can be a
\code{\link[grid:unit]{unit}} object.}

\item{position}{A string of \code{"top"}, \code{"left"}, \code{"bottom"}, or \code{"right"} indicates which annotation stack should be activated.}

\item{size}{A numeric value or an \code{\link[grid:unit]{unit}} object to set the
total \code{height}/\code{width} of the annotation stack.
\itemize{
\item If \code{position} is \code{"top"} or \code{"bottom"}, \code{size} sets the total height of
the annotation.
\item If \code{position} is \code{"left"} or \code{"right"}, \code{size} sets the total width of the
annotation.
}}

\item{free_guides}{Override the \code{guides} collection behavior specified in the
\code{\link[=quad_layout]{quad_layout()}}/\code{\link[=ggheatmap]{ggheatmap()}} for the annotation stack.}

\item{what}{What should get activated in the annotation stack?
A single number or string of the plot elements in the stack layout. If \code{NULL}, will remove any active context.}
}
\value{
An object that can be added to \code{\link[=quad_layout]{quad_layout()}}/\code{\link[=ggheatmap]{ggheatmap()}}.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}
\itemize{
\item \code{quad_active}: Sets the active context to the \code{\link[=quad_layout]{quad_layout()}}/\code{\link[=ggheatmap]{ggheatmap()}} itself.
\item \code{quad_anno}: Sets the active context to the specified annotation stack
based on the \code{position} argument.
\item \code{anno_top}: A special case of \code{quad_anno} with \code{position = "top"}.
\item \code{anno_left}: A special case of \code{quad_anno} with \code{position = "left"}.
\item \code{anno_bottom}: A special case of \code{quad_anno} with \code{position = "bottom"}.
\item \code{anno_right}: A special case of \code{quad_anno} with \code{position = "right"}.
}
}
\details{
By default, \code{quad_anno()} will try to initialize the annotation stack layout
using data from \code{\link[=quad_layout]{quad_layout()}}/\code{\link[=ggheatmap]{ggheatmap()}}. However, there are situations where the
annotation stack cannot be initialized due to incompatible data formats
between \code{\link[=quad_layout]{quad_layout()}} and the required format for the annotation stack.
This often occurs in \code{\link[=quad_alignh]{quad_alignh()}} and \code{\link[=quad_alignv]{quad_alignv()}}, where the
layout data is a matrix, but top and bottom annotations (in
\code{\link[=quad_alignh]{quad_alignh()}}) or left and right annotations (in \code{\link[=quad_alignv]{quad_alignv()}})
require a data frame. In such cases, you must use \code{\link[=quad_init]{quad_init()}} to manually
initialize the annotation stack.
}
\seealso{
\itemize{
\item \code{\link[=quad_switch]{quad_switch()}}
\item \code{\link[=quad_init]{quad_init()}}
}
}
