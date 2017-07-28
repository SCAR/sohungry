#' Allometric equation data.
#'
#' A dataset containing allometric equations (relationships between
#' the size of an organism and the size of its body parts).
#'
#' @format A data frame with variables:
#' \describe{
#'   \item{taxon_name}{name of the taxon}
#'   \item{taxon_aphia_id}{the Aphia ID of the taxon (identifier within the World Register of Marine Species)}
#'   \item{equation}{a function encoding the allometric equation}
#'   \item{input_measurement}{the name of the measurement needed}
#'   \item{return_measurement}{the name of the body size characteristic that is estimated by this equation (e.g. 'mass')}
#'   \item{units}{the units of measurement of the returned characteristic}
#'   \item{N}{the sample size used by the authors of the equation}
#'   \item{notes}{notes}
#'   \item{reference}{the source of the equation}
#' }
"allometry_data"

# @source \url{}
