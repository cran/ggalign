% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/attributes.R
\name{ggalign_attr}
\alias{ggalign_attr}
\alias{ggalign_lvls}
\title{Get Data from the Attribute Attached by ggalign}
\usage{
ggalign_attr(x, field = NULL, check = TRUE)

ggalign_lvls(x)
}
\arguments{
\item{x}{Data used, typically inherited from the layout \code{\link[=quad_layout]{quad_layout()}}/\code{\link[=ggheatmap]{ggheatmap()}} or \code{\link[=stack_layout]{stack_layout()}} object.}

\item{field}{A string specifying the particular data to retrieve from the
attached attribute. If \code{NULL}, the entire attached attribute list will be
returned.}

\item{check}{A boolean indicating whether to check if the \code{field} exists. If
\code{TRUE}, an error will be raised if the specified \code{field} does not exist.}
}
\value{
\itemize{
\item \code{ggalign_attr}: The specified data from the attached supplementary data or
\code{NULL} if it is unavailable.
\item \code{ggalign_lvls}: The attached supplementary levels or \code{NULL} if it is
unavailable.
}
}
\description{
\code{ggalign_attr} retrieves supplementary information stored as attributes
during the layout rendering process. These attributes—typically added during
data transformation by functions such as \code{\link[=fortify_matrix]{fortify_matrix()}} or
\code{\link[=fortify_data_frame]{fortify_data_frame()}}—may contain filtered data, auxiliary metadata, or
other context essential for downstream operations.

Factor level information, stored as a separate attribute, can be accessed via
\code{ggalign_lvls}.
}
\details{
Attributes attached to the data are especially useful when the input data is
transformed in ways that limit access to the complete dataset. For example,
\code{\link[=fortify_matrix.MAF]{fortify_matrix.MAF()}} might filter mutation data while adding attributes
that retain important context, such as the total number of observations, for
detailed or aggregated analyses. Additionally, it stores the levels of
\code{Variant_Classification} for further usage.
}
