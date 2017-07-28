globalVariables("allometry_data") # To make R CMD Check happy

#' Allometric equations for cephalopods
#'
#' Estimate body size measurements (currently mantle length and/or body mass) from lower rostral length.
#' Either the taxon name or the Aphia ID must be provided.
#' Note that some allometric equations apply at the genus- or family-level. Currently these won't be found if a species
#' name or ID is provided here. Refer to \code{\link{allometry_data}} to see all available equations.
#'
#' @param taxon_name string: the name of the taxon
#' @param taxon_aphia_id numeric: the Aphia ID of the taxon
#' @param LRL numeric: one or more lower rostral lengths (in mm)
#'
#' @return list of data.frames, one per supplied lower rostral length value
#'
#' @seealso \code{\link{allometry_data}}
#'
#' @examples
#' so_allometry_cephalopods(taxon_name="Architeuthis dux",
#'   LRL=c(13.9,11.3))
#'
#' @export
so_allometry_cephalopods <- function(taxon_name,taxon_aphia_id,LRL) {
    if (!missing(taxon_name)) {
        idx <- allometry_data$taxon_name==taxon_name
    } else if (!missing(taxon_aphia_id)) {
        idx <- allometry_data$taxon_aphia_id==taxon_aphia_id
    } else {
        stop("need taxon_name or taxon_aphia_id")
    }
    idx <- which(idx & allometry_data$input_measurement=="lower rostral length")
    lapply(LRL,function(z) {
        bind_cols(tibble(input=z,
                         value=sapply(idx,function(i)allometry_data$equation[[i]](z))),
                  allometry_data[idx,])
    })
}
