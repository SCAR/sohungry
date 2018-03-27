#' SCAR Southern Ocean Diet and Energetics diet data
#'
#' @references \url{http://data.aad.gov.au/trophic/}
#' @param method string: "get" (fetch the data via a web GET call) or "direct" (direct database connection, for internal AAD use only)
#' @param cache_directory string: (optional) cache the data locally in this directory, so that they can be used offline later. The cache directory will be created if it does not exist. A warning will be given if a cached copy exists and is more than 30 days old. Note that even if no \code{cache_directory} is specified, a per-session cache will be used to reduce load on the server. Use \code{refresh_cache=TRUE} to re-load the data if necessary
#' @param refresh_cache logical: if TRUE, and data already exist in the cache_directory, they will be refreshed. If FALSE, the cached data will be used
#' @param public_only logical: only applicable to \code{method} "direct"
#' @param verbose logical: show progress messages?
#'
#' @return data.frame
#'
#' @examples
#' \dontrun{
#'   library(dplyr)
#'   x <- so_diet(cache_dir="c:/temp/diet_cache")
#'   x %>% filter(predator_name=="Electrona antarctica")
#' }
#' @export
so_diet <- function(method="get",cache_directory,refresh_cache=FALSE,public_only=TRUE,verbose=FALSE) {
    x <- get_so_data("diet", method, cache_directory, refresh_cache, public_only, verbose)
    ## ensure dietary importance measures are numeric
    x <- x %>% mutate_(fraction_diet_by_weight=~as.numeric(fraction_diet_by_weight),
                       fraction_diet_by_prey_items=~as.numeric(fraction_diet_by_prey_items),
                       fraction_occurrence=~as.numeric(fraction_occurrence))
    x

##    assert_that(is.string(method))
##    assert_that(is.flag(refresh_cache))
##    assert_that(is.flag(public_only))
##    method <- match.arg(tolower(method),c("get","direct"))
##    if (method=="direct") {
##        if (!requireNamespace("aadcdb", quietly=TRUE)) {
##            stop("The aadcdb package is required for method=\"direct\"",call.=FALSE)
##        }
##        on.exit(try(aadcdb::db_close(dbh),silent=TRUE))
##        where_string <- if (public_only) " where is_public_flag='Y'" else ""
##        dbh <- aadcdb::db_open()
##        x <- aadcdb::db_query(dbh,paste0("select * from ",so_opt("diet_table"),where_string))
##        if ("geometry_point" %in% names(x)) x <- x %>% select_(quote(-geometrypoint)) ## backwards compat
##        if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
##        xs <- aadcdb::db_query(dbh,paste0("select * from ",so_opt("sources_table")))
##        if ("ref_id" %in% names(xs)) xs <- xs %>% dplyr::rename(source_id="ref_id")
##    } else {
##        unzipped_data_dir <- soded_webget(cache_directory,refresh_cache=refresh_cache,verbose=verbose)
##        suppress <- if (!verbose) function(...)suppressWarnings(suppressMessages(...)) else function(...) identity(...)
##        suppress(x <- read_csv(file.path(unzipped_data_dir,so_opt("diet_file"))))
##        names(x) <- tolower(names(x))
##        ##if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
##        ## ensure dietary importance measures are numeric
##        x <- x %>% mutate_(fraction_diet_by_weight=~as.numeric(fraction_diet_by_weight),fraction_diet_by_prey_items=~as.numeric(fraction_diet_by_prey_items),fraction_occurrence=~as.numeric(fraction_occurrence))
##        suppress(xs <- read_csv(file.path(unzipped_data_dir,so_opt("sources_file"))))
##    }
##    xs <- dplyr::rename(xs, source_details="details", source_doi="doi")
##    x %>% left_join(xs %>% select_at(c("source_id", "source_details", "source_doi")),by="source_id")
}

#' SCAR Southern Ocean Diet and Energetics isotope data
#'
#' @references \url{http://data.aad.gov.au/trophic/}
#' @param method string: "get" (fetch the data via a web GET call) or "direct" (direct database connection, for internal AAD use only. Note that direct does not include some columns, notably WoRMS taxonomic info)
#' @param cache_directory string: (optional) cache the data locally in this directory, so that they can be used offline later. The cache directory will be created if it does not exist. A warning will be given if a cached copy exists and is more than 30 days old. Note that even if no \code{cache_directory} is specified, a per-session cache will be used to reduce load on the server. Use \code{refresh_cache=TRUE} to re-load the data if necessary
#' @param refresh_cache logical: if TRUE, and data already exist in the cache_directory, they will be refreshed. If FALSE, the cached data will be used
#' @param public_only logical: only applicable to \code{method} "direct"
#' @param verbose logical: show progress messages?
#'
#' @return data.frame
#'
#' @examples
#' \dontrun{
#'   x <- so_isotopes(cache_dir="c:/temp/diet_cache")
#' }
#' @export
so_isotopes <- function(method="get", cache_directory, refresh_cache=FALSE, public_only=TRUE, verbose=FALSE) {
    get_so_data("isotopes", method, cache_directory, refresh_cache, public_only, verbose)
##    assert_that(is.string(method))
##    assert_that(is.flag(refresh_cache))
##    assert_that(is.flag(public_only))
##    method <- match.arg(tolower(method), c("get","direct"))
##    if (method=="direct") {
##        if (!requireNamespace("aadcdb", quietly=TRUE)) {
##            stop("The aadcdb package is required for method=\"direct\"",call.=FALSE)
##        }
##        on.exit(try(aadcdb::db_close(dbh),silent=TRUE))
##        where_string <- if (public_only) " where is_public_flag='Y'" else ""
##        dbh <- aadcdb::db_open()
##        x <- aadcdb::db_query(dbh,paste0("select * from ",so_opt("isotopes_table"),where_string))
##        if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
##        if ("taxon_group" %in% names(x) && nrow(x)>0) x <- x %>% dplyr::rename(taxon_group_soki="taxon_group")
##        xs <- aadcdb::db_query(dbh,paste0("select * from ",so_opt("sources_table")))
##    } else {
##        unzipped_data_dir <- soded_webget(cache_directory,refresh_cache=refresh_cache,verbose=verbose)
##        suppress <- if (!verbose) function(...)suppressWarnings(suppressMessages(...)) else function(...) identity(...)
##        suppress(x <- read_csv(file.path(unzipped_data_dir,so_opt("isotopes_file"))))
##        ##if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
##        suppress(xs <- read_csv(file.path(unzipped_data_dir,so_opt("sources_file"))))
##    }
##    xs <- dplyr::rename(xs, source_details="details", source_doi="doi")
##    x %>% left_join(xs %>% select_at(c("source_id", "source_details", "source_doi")),by="source_id")
}

#' SCAR Southern Ocean Diet and Energetics energetics data
#'
#' @references \url{http://data.aad.gov.au/trophic/}
#' @param method string: "get" (fetch the data via a web GET call) or "direct" (direct database connection, for internal AAD use only. Note that direct does not include some columns, notably WoRMS taxonomic info)
#' @param cache_directory string: (optional) cache the data locally in this directory, so that they can be used offline later. The cache directory will be created if it does not exist. A warning will be given if a cached copy exists and is more than 30 days old. Note that even if no \code{cache_directory} is specified, a per-session cache will be used to reduce load on the server. Use \code{refresh_cache=TRUE} to re-load the data if necessary
#' @param refresh_cache logical: if TRUE, and data already exist in the cache_directory, they will be refreshed. If FALSE, the cached data will be used
#' @param public_only logical: only applicable to \code{method} "direct"
#' @param verbose logical: show progress messages?
#'
#' @return data.frame
#'
#' @examples
#' \dontrun{
#'   x <- so_energetics(cache_dir="c:/temp/diet_cache")
#' }
#' @export
so_energetics <- function(method="get",cache_directory,refresh_cache=FALSE,public_only=TRUE,verbose=FALSE) {
    get_so_data("energetics", method, cache_directory, refresh_cache, public_only, verbose)
}


#' SCAR Southern Ocean Diet and Energetics lipids and fatty acids data
#'
#' @references \url{http://data.aad.gov.au/trophic/}
#' @param method string: "get" (fetch the data via a web GET call) or "direct" (direct database connection, for internal AAD use only. Note that direct does not include some columns, notably WoRMS taxonomic info)
#' @param cache_directory string: (optional) cache the data locally in this directory, so that they can be used offline later. The cache directory will be created if it does not exist. A warning will be given if a cached copy exists and is more than 30 days old. Note that even if no \code{cache_directory} is specified, a per-session cache will be used to reduce load on the server. Use \code{refresh_cache=TRUE} to re-load the data if necessary
#' @param refresh_cache logical: if TRUE, and data already exist in the cache_directory, they will be refreshed. If FALSE, the cached data will be used
#' @param public_only logical: only applicable to \code{method} "direct"
#' @param verbose logical: show progress messages?
#'
#' @return data.frame
#'
#' @examples
#' \dontrun{
#'   x <- so_lipids(cache_dir="c:/temp/diet_cache")
#' }
#' @export
so_lipids <- function(method="get",cache_directory,refresh_cache=FALSE,public_only=TRUE,verbose=FALSE) {
    get_so_data("lipids", method, cache_directory, refresh_cache, public_only, verbose)
}

## common code
get_so_data <- function(which_data, method, cache_directory, refresh_cache, public_only, verbose) {
    assert_that(is.string(which_data))
    which_data <- match.arg(tolower(which_data), c("diet", "dna_diet", "energetics", "isotopes", "lipids"))
    assert_that(is.string(method))
    assert_that(is.flag(refresh_cache))
    assert_that(is.flag(public_only))
    method <- match.arg(tolower(method),c("get","direct"))
    if (method=="direct") {
        if (!requireNamespace("aadcdb", quietly=TRUE)) {
            stop("The aadcdb package is required for method=\"direct\"",call.=FALSE)
        }
        on.exit(try(aadcdb::db_close(dbh), silent=TRUE))
        where_string <- if (public_only) " where is_public_flag='Y'" else ""
        dbh <- aadcdb::db_open()
        x <- aadcdb::db_query(dbh,paste0("select * from ",so_opt(paste0(which_data, "_table")),where_string))
        ## backwards compat
        if ("geometry_point" %in% names(x)) x <- x %>% select_(quote(-geometrypoint))
        if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
        if ("taxon_group" %in% names(x) && nrow(x)>0) x <- x %>% dplyr::rename(taxon_group_soki="taxon_group")
        xs <- aadcdb::db_query(dbh,paste0("select * from ",so_opt("sources_table")))
    } else {
        unzipped_data_dir <- soded_webget(cache_directory,refresh_cache=refresh_cache,verbose=verbose)
        suppress <- if (!verbose) function(...)suppressWarnings(suppressMessages(...)) else function(...) identity(...)
        suppress(x <- read_csv(file.path(unzipped_data_dir,so_opt(paste0(which_data, "_file")))))
        suppress(xs <- read_csv(file.path(unzipped_data_dir,so_opt("sources_file"))))
    }
    xs <- dplyr::rename(xs, source_details="details", source_doi="doi")
    x %>% left_join(xs %>% select_at(c("source_id", "source_details", "source_doi")),by="source_id")
}


## internal function to retrieve the zipped data file and unpack it
soded_webget <- function(cache_directory,refresh_cache=FALSE,verbose=FALSE) {
    ## fetch via GET, with local caching support
    zip_file_name <- "soded_data.zip" ## local name for the zip file
    use_existing_zip <- FALSE
    if (!missing(cache_directory)) {
        assert_that(is.string(cache_directory))
        if (!dir.exists(cache_directory)) {
            if (verbose) message("creating data cache directory: ",cache_directory,"\n")
            ok <- dir.create(cache_directory)
            if (!ok) stop("could not create cache directory: ",cache_directory)
        } else {
            ## cache dir exists
            use_existing_zip <- TRUE
            cache_directory <- sub("[/\\]+$", "", cache_directory) ## remove trailing file sep
            temp <- file.path(cache_directory,zip_file_name)
            ## but don't use_existing_zip if we are refreshing it, or if the file doesn't exist
            if (refresh_cache || !file.exists(temp)) use_existing_zip <- FALSE
            ## is cached copy old?
            if (file.exists(temp)) {
                if (difftime(Sys.time(),file.info(temp)$mtime,units="days")>30)
                    warning("cached copy of data is more than 30 days old, consider refreshing your copy")
            }
        }
    } else {
        cache_directory <- so_opt("session_cache_dir") ## use the per-session cache dir
        if (!dir.exists(cache_directory)) {
            ok <- dir.create(cache_directory)
            if (!ok) stop("could not create session cache directory: ",cache_directory)
        }
        ## do we already have zip file here?
        if (!refresh_cache && file.exists(file.path(cache_directory, zip_file_name))) use_existing_zip <- TRUE
    }
    zip_file_name <- file.path(cache_directory,zip_file_name)

    download_url <- "http://data.aad.gov.au/database/trophic/scar_dump_v2.zip" ## temporary location, will be moved to registered AADC download file or geoserver endpoint
    ## http://data.aad.gov.au/geoserver/aadc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=aadc:TROPHIC_DIET&maxFeatures=100000&outputFormat=csv
    ## fetch data if needed
    if (!use_existing_zip) {
        if (verbose) message("downloading data file from ",download_url," to ",zip_file_name," ...")
        chand <- new_handle()
        handle_setopt(chand,ssl_verifypeer=0) ## temporarily, to avoid issues with AAD certs
        curl_download(download_url,destfile=zip_file_name,quiet=!verbose,mode="wb",handle=chand)
        do_unzip <- TRUE
    } else {
        ## using the existing zip
        if (verbose) message("using existing data file: ", zip_file_name)
        ## need to unzip if all files not present
        do_unzip <- vapply(c(so_opt("sources_file"), so_opt("energetics_file"), so_opt("isotopes_file"), so_opt("diet_file")),## these not there yet, so_opt("dna_diet_file"), so_opt("lipids_file")),
                           function(z) file.exists(file.path(cache_directory, z)), FUN.VALUE=TRUE)
        do_unzip <- !all(do_unzip)
    }
    if (do_unzip) {
        if (verbose) message("unzipping ", zip_file_name)
        unzip(zip_file_name,exdir=cache_directory)
    }
    cache_directory
}

