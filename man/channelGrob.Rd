% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grid-grob-channel.R
\name{channelGrob}
\alias{channelGrob}
\title{Create a Grob That Spans Multiple Viewports}
\usage{
channelGrob(make_content, ..., name = NULL, vp = NULL)
}
\arguments{
\item{make_content}{A function that accepts the list of signal locations and
returns a \code{\link[grid:grid.grob]{grob}}.}

\item{...}{Additional arguments passed to \code{make_content}.}

\item{name}{a character identifier for the grob.  Used to find the
    grob on the display list and/or as a child of another grob. }

\item{vp}{a \code{\link[grid]{viewport}} object (or \code{NULL}).}
}
\value{
A \code{channelSenderGrob} object.
}
\description{
This function initializes a communication channel to share location signals
across different viewports. It returns a \code{channelSenderGrob} object, which
can transmit multiple signals using its \verb{$signal} method (see the "Signal"
section below for details). When drawn, all collected signals are passed to
the \code{make_content} function to generate the final \code{\link[grid:grid.grob]{grob}}.
}
\section{Signal}{

A \code{channelSenderGrob} can emit multiple location signals using the \verb{$signal}
method. This method accepts the following arguments:
\itemize{
\item \code{x}: X-coordinate.
\item \code{y}: Y-coordinate.
\item \code{default.units}: The default units for \code{x} and \code{y}.
\item \code{tag}: A character string used to identify the location.
\item \code{name}: A name for the returned grob.
\item \code{vp}: A \code{\link[grid:viewport]{viewport}} for the returned grob.
}

The \verb{$signal} method returns a \code{channelSignalGrob}.
}

\examples{
# we create a new channel, we will emit two singals
# here: we just add a line between the two signals
channel <- channelGrob(function(locations) {
    # you can also use `tag` to identify the locations
    loc1 <- .subset2(locations, 1L)
    loc2 <- .subset2(locations, 2L)
    grid::segmentsGrob(loc1$x, loc1$y, loc2$x, loc2$y)
})

gt <- gtable::gtable(unit(1:2, c("cm")), unit(5, "cm"))
gt <- gtable::gtable_add_grob(
    gt,
    list(
        grid::rectGrob(gp = gpar(color = "black", fill = NA)),
        channel$signal(0.5, 0.5, "npc")
    ),
    t = 1, l = 1, name = c("rect1", "signal1")
)
gt <- gtable::gtable_add_grob(
    gt,
    list(
        grid::rectGrob(gp = gpar(color = "red", fill = NA)),
        channel$signal(0.5, 0.5, "npc")
    ),
    t = 1, l = 2, name = c("rect2", "signal2")
)
grid::grid.newpage()
grid::grid.draw(gt)
}
