% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter.R
\name{filter_by_importance}
\alias{filter_by_importance}
\title{Filter out diet data below a given importance threshold}
\usage{
filter_by_importance(x, threshold, which_measures = "any")
}
\arguments{
\item{x}{data.frame: diet data, as returned by \code{so_diet}}

\item{threshold}{numeric: remove entries below this threshold}

\item{which_measures}{string: one or more of "fraction_diet_by_weight", "fraction_diet_by_prey_items", "fraction_occurrence", or "any" (shorthand for all three)}
}
\value{
data.frame
}
\description{
A diet record is retained if any of the importance measures are above the threshold.
Records with all-NA importance values will be removed.
}
\examples{
\dontrun{
  x <- so_diet()
  x \%>\% filter_by_importance(0.1)
}

}
\seealso{
\code{\link{so_diet}}, \code{\link{replace_by_importance}}
}
