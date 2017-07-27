#' Allometric equations for cephalopods
#'
#' Estimate body size (currently mantle length and/or body mass) from lower rostral length.
#' Either the taxon name or the aphia ID must be provided.
#'
#' @param taxon_name string: the name of the taxon
#' @param aphia_id numeric: the aphia ID of the taxon
#' @param LRL numeric: one or more lower rostral lengths (in mm)
#'
#' @return list of data.frames, one per supplied lower rostral length value
#'
#' @examples
#' so_allometry_cephalopods(taxon_name="Architeuthis dux",
#'   LRL=c(13.9,11.3))
#'
#' @export
so_allometry_cephalopods <- function(taxon_name,aphia_id,LRL) {
    if (!missing(taxon_name)) {
        idx <- allometry_data$taxon_name==taxon_name
    } else if (!missing(aphia_id)) {
        idx <- allometry_data$aphia_id==aphia_id
    } else {
        stop("need taxon_name or aphia_id")
    }
    idx <- which(idx & allometry_data$input=="lower rostral length")
    lapply(LRL,function(z) {
        bind_cols(tibble(LRL=z,
                         value=sapply(idx,function(i)allometry_data$equation[[i]](z))),
                  allometry_data[idx,])
    })
}



