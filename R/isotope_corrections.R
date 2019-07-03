#' Stable isotope corrections
#'
#' Apply stable isotope corrections following various published methods.
#'
#' Methods:
#' \itemize{
#'  \item "Weldrick 2019": lipid normalization of d13C values following Weldrick CK et al. (2019) Can lipid removal affect interpretation of resource partitioning from stable isotopes in Southern Ocean pteropods? Rapid Communications in Mass Spectrometry. https://doi.org/10.1002/rcm.8384
#'  \item "Kiljunen 2006": lipid normalization of d13C values following Kiljunen M et al. (2006) A revised model for lipid-normalizing d13C values from aquatic organisms, with implications for isotope mixing models. Journal of Applied Ecology. https://doi.org/10.1111/j.1365-2664.2006.01224.x
#'  \item "Kiljunen 2006 atomic": as for Kiljunen 2006 but using atomic C:N ratio
#'  \item "Post 2007": lipid normalization of d13C values followingPost DM et al. (2007) Getting to the fat of the matter: Models, methods and assumptions for dealing with lipids in stable isotope analyses. Oecologia. https://doi.org/10.1007/s00442-006-0630-x
#'  \item "Smyntek 2007": lipid normalization of d13C values following Smyntek PM et al. (2007) A standard protocol for stable isotope analysis of zooplankton in aquatic food web research using mass balance correction models. Limnol. Oceanogr. https://doi.org/10.4319/lo.2007.52.5.2135
#'  \item "Smyntek 2007 atomic": as for Smyntek 2007 but using atomic C:N ratio
#'  \item "Logan 2008": lipid normalization of d13C values following Logan JM et al. (2008) Lipid corrections in carbon and nitrogen stable isotope analyses: comparison of chemical extraction and modelling methods. Journal of Animal Ecology. https://doi.org/10.1111/j.1365-2656.2008.01394.x
#'  \item "Syvaranta 2010":  lipid normalization of d13C values following Syväranta J and Rautio M (2010) Zooplankton, lipids and stable isotopes: Importance of seasonal, latitudinal, and taxonomic differences. Canadian Journal of Fisheries and Aquatic Science. https://doi.org/10.1139/F10-091
#' }
#'
#' @param d13c numeric: d13C values
#' @param d15n numeric: d15n values
#' @param cn_ratio numeric: C:N ratio values
#' @param method string: one of "Weldrick 2019", "Kiljunen 2006", "Kiljunen 2006 atomic" "Post 2007" "Smyntek 2007" "Smyntek 2007 atomic" "Logan 2008" "Syvaranta 2010" (see Details)
#' @param cn_ratio_type string: the basis of the C:N ratio (either "mass" or "atomic")
#'
#' @return A data.frame with corrected values, comprising one or more of the columns "d13c", "d15n", "cn_ratio" depending on the method.
#'
#' @seealso \code{\link{so_isotopes}}
#'
#' @examples
#' ## lipid normalization of bulk d13C following Weldrick et al. 2019
#' so_isotope_adjust(d13c = -26.816, cn_ratio = 3.7014, cn_ratio_type = "mass",
#'                   method = "Weldrick 2019")
#'
#' @export
so_isotope_adjust <- function(d13c = NULL, d15n = NULL, cn_ratio = NULL, method, cn_ratio_type = "mass") {
    if (is.factor(method)) method <- as.character(method)
    assert_that(is.string(method))
    method <- match.arg(tolower(method), c("weldrick 2019", "kiljunen 2006", "kiljunen 2006 atomic", "post 2007", "smyntek 2007", "smyntek 2007 atomic", "logan 2008", "syvaranta 2010"))
    switch(method,
           "weldrick 2019" = {
               assert_that(!is.null(d13c))
               data.frame(d13c = d13c + 2.43)
           },
           "kiljunen 2006" =,
           "kiljunen 2006 atomic" = {
               assert_that(!is.null(d13c))
               assert_that(!is.null(cn_ratio))
               L <- calc_L(cn_ratio, cn_ratio_type = cn_ratio_type, type = if (grepl("atomic", method)) "atomic" else "mass")
               data.frame(d13c = d13c+7.018*((0.048+3.9)/(1+(287/L))))
           },
           "post 2007" = {
               assert_that(!is.null(d13c))
               assert_that(!is.null(cn_ratio))
               data.frame(d13c = (-3.32+(0.99*cn_ratio_convert(cn_ratio, from = cn_ratio_type, to = "mass")))+d13c)
           },
           "smyntek 2007" =,
           "smyntek 2007 atomic" = {
               assert_that(!is.null(d13c))
               assert_that(!is.null(cn_ratio))
               cn_ratio <- cn_ratio_convert(cn_ratio, from = cn_ratio_type, to = if (grepl("atomic", method)) "atomic" else "mass")
               data.frame(d13c = d13c+6.3*((cn_ratio-3.3)/cn_ratio))
           },
           "logan 2008" = {
               assert_that(!is.null(d13c))
               assert_that(!is.null(cn_ratio))
               data.frame(d13c = d13c-2.06+1.91*log(cn_ratio_convert(cn_ratio, from = cn_ratio_type, to = "mass")))
           },
           "syvaranta 2010" = {
               assert_that(!is.null(d13c))
               assert_that(!is.null(cn_ratio))
               data.frame(d13c = d13c+7.95*((cn_ratio_convert(cn_ratio, from = cn_ratio_type, to = "atomic")-3.3)/cn_ratio_convert(cn_ratio, from = cn_ratio_type, to = "mass")))
           },
           stop("unrecognized method: ", method))
}


calc_L <- function(cn_ratio, cn_ratio_type = "mass", type = "mass") {
    cn_ratio <- cn_ratio_convert(cn_ratio, from = cn_ratio_type, to = type)
    93/(1+(1/((0.246*cn_ratio)-0.775)))
}

## convert C:N ratio from mass to atomic basis and vice-versa
cn_ratio_convert <- function(cn_ratio, from, to) {
    if (is.factor(from)) from <- as.character(from)
    assert_that(is.string(from), !is.na(from))
    from <- match.arg(tolower(from), c("mass", "atomic"))
    if (is.factor(to)) to <- as.character(to)
    assert_that(is.string(to), !is.na(to))
    to <- match.arg(tolower(to), c("mass", "atomic"))
    if (!identical(from, to)) {
        if (from == "atomic") {
            cn_ratio*12/14 ## atomic to mass is *12/14
        } else {
            cn_ratio*14/12 ## mass to atomic is *14/12,
        }
    } else {
        cn_ratio
    }
}
