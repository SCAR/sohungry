#' Allometric equation data.
#'
#' A dataset containing allometric equations (relationships between
#' the size of an organism and the size of its body parts).
#'
#' @format A data frame with variables:
#' \describe{
#'   \item{equation_id}{the identifier of this equation}
#'   \item{taxon_name}{name of the taxon}
#'   \item{taxon_aphia_id}{the Aphia ID of the taxon (identifier within the World Register of Marine Species)}
#'   \item{equation}{a function encoding the allometric equation}
#'   \item{input_measurement}{the name of the measurement needed}
#'   \item{input_measurement_units}{the units of the measurement needed}
#'   \item{return_measurement}{the name of the body size characteristic that is estimated by this equation (e.g. 'mass')}
#'   \item{return_measurement_units}{the units of measurement of the returned characteristic}
#'   \item{goodness_of_fit}{a measure of the goodness-of-fit of the equation}
#'   \item{goodness_type}{a description of how the goodness-of-fit was assessed, e.g. 'R^2' or 'N' (the sample size used by the authors of the equation)}
#'   \item{notes}{notes}
#'   \item{reference}{the source of the equation}
#' }
"allometry_data"

# @source \url{}
