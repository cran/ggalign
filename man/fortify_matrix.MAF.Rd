% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fortify-matrix.R
\name{fortify_matrix.MAF}
\alias{fortify_matrix.MAF}
\title{Build a Matrix}
\usage{
\method{fortify_matrix}{MAF}(
  data,
  ...,
  genes = NULL,
  n_top = NULL,
  remove_empty_samples = TRUE,
  collapse_vars = FALSE
)
}
\arguments{
\item{data}{An object to be converted to a matrix.}

\item{...}{Not used currently.}

\item{genes}{An atomic character defines the genes to draw.}

\item{n_top}{A single number indicates how many top genes to be drawn.}

\item{remove_empty_samples}{A single boolean value indicating whether to drop
samples without any genomic alterations.}

\item{collapse_vars}{A single boolean value indicating whether to collapse
multiple alterations in the same sample and gene into a single value
\code{"Multi_Hit"}.}
}
\value{
A matrix.
}
\description{
By default, it calls \code{\link[=as.matrix]{as.matrix()}} to build a matrix.
}
\section{ggalign attributes}{

\itemize{
\item \code{gene_anno}: gene summary informations
\item \code{sample_anno}: sample summary informations
\item \code{n_genes}: Total of genes
\item \code{n_samples}: Total of samples
\item \code{breaks}: factor levels of \code{Variant_Classification}, if \code{collapse_vars = TRUE}, \code{"Multi_Hit"} will be added in the end.
}
}

\seealso{
Other fortify_matrix methods: 
\code{\link{fortify_matrix.default}()}
}
\concept{fortify_matrix methods}
