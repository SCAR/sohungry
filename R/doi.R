#' Return the DOI of the SCAR Diet and Energetics Database being used
#'
#' @param cache_directory string: (optional) the local cache directory containing the data. If no valid DOI is found in that directory, the return value will be \code{NA_character_}. If \code{cache_directory} is not supplied, the DOI of the data last accessed in this session will be returned (and if no data has yet been accessed, the most recent known DOI will be returned)
#' @param ... : additional parameters passed to \code{so_diet} etc
#'
#' @return string
#'
#' @seealso \code{\link{so_diet}}, \code{\link{so_dna_diet}}, \code{\link{so_isotopes}}, \code{\link{so_energetics}}, \code{\link{so_lipids}}
#'
#' @examples
#' \dontrun{
#'   xd <- so_diet(cache_directory = "session")
#'   ## the DOI of the data just read
#'   so_doi()
#'
#'   ## the DOI of the data in a particular cache directory
#'   so_doi(cache_directory = "c:/my/cache/dir")
#' }
#'
#' @export
so_doi <- function(cache_directory, ...) {
    if (!missing(cache_directory)) {
        doi <- get_so_data("doi", method = "get", cache_directory = cache_directory, ...)
    } else {
        doi <- so_opt("DOI") ## this is updated each time the data is read, so that it reflects the version being used
        ## if no data has yet been read, use default (latest) DOI
        if (is.null(doi)) doi <- so_default_doi()
    }
    doi
}

## internal, default to this DOI if necessary
## this is the DOI of the latest version
so_default_doi <- function() "10.26179/5d1aec22f41d5"

## DOI versions
##
## 2-Jul-2019 "10.26179/5d1aec22f41d5"
## 21-Sep-2018 "10.26179/5ba3396f46e42"
## 9-Aug-2018 "10.26179/5b6cd40bb6935"
