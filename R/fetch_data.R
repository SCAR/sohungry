#' SCAR Southern Ocean Diet and Energetics diet data
#'
#' @references \url{http://data.aad.gov.au/trophic/}
#' @param method string: "get" (fetch the data via a web GET call) or "direct" (direct ODBC database connection, for internal AAD use only)
#' @param cache_directory string: (optional) cache the data locally in this directory, so that they can be used offline later. The cache directory will be created if it does not exist. A warning will be given if a cached copy exists and is more than 30 days old
#' @param refresh_cache logical: if TRUE, and data already exist in the cache_directory, they will be refreshed. If FALSE, the cached copy will be used
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
    assert_that(is.string(method))
    assert_that(is.flag(refresh_cache))
    assert_that(is.flag(public_only))
    method <- match.arg(tolower(method),c("get","direct"))
    if (method=="direct") {
        if (!requireNamespace("aadcdb", quietly = TRUE)) {
            stop("The aadcdb package is required for method=\"direct\"",call.=FALSE)
        }
        on.exit(try(aadcdb::db_close(dbh),silent=TRUE))
        where_string <- if (public_only) " where is_public_flag='Y'" else ""
        dbh <- aadcdb::db_open()
        x <- aadcdb::db_query(dbh,paste0("select * from ",getOption("sohungry")$diet_table,where_string))
        if ("geometry_point" %in% names(x)) x <- x %>% select_(quote(-geometrypoint)) ## backwards compat
        if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
        xs <- aadcdb::db_query(dbh,paste0("select * from ",getOption("sohungry")$diet_sources_table))
        if ("ref_id" %in% names(xs)) xs <- xs %>% rename_(source_id=~ref_id)
    } else {
        unzipped_data_dir <- soded_webget(cache_directory,refresh_cache=refresh_cache,verbose=verbose)
        suppress <- if (!verbose) function(...)suppressWarnings(suppressMessages(...)) else function(...) identity(...)
        suppress(x <- read_csv(file.path(unzipped_data_dir,getOption("sohungry")$diet_file)))
        names(x) <- tolower(names(x))
        ##if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
        ## ensure dietary importance measures are numeric
        x <- x %>% mutate_(fraction_diet_by_weight=~as.numeric(fraction_diet_by_weight),fraction_diet_by_prey_items=~as.numeric(fraction_diet_by_prey_items),fraction_occurrence=~as.numeric(fraction_occurrence))
        suppress(xs <- read_csv(file.path(unzipped_data_dir,getOption("sohungry")$diet_sources_file)))
        names(xs) <- tolower(names(xs))
        xs$doi <- as.character(NA)
    }
    x %>% left_join(xs %>% select_("source_id",source_details=~details,source_doi=~doi),by="source_id")
}

#' SCAR Southern Ocean Diet and Energetics isotope data
#'
#' @references \url{http://data.aad.gov.au/trophic/}
#' @param method string: "get" (fetch the data via a web GET call) or "direct" (direct ODBC database connection, for internal AAD use only. Note that direct does not include some columns, notably worms taxonomic info)
#' @param cache_directory string: (optional) cache the data locally in this directory, so that they can be used offline later. The cache directory will be created if it does not exist. A warning will be given if a cached copy exists and is more than 30 days old
#' @param refresh_cache logical: if TRUE, and data already exist in the cache_directory, they will be refreshed. If FALSE, the cached copy will be used
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
so_isotopes <- function(method="get",cache_directory,refresh_cache=FALSE,public_only=TRUE,verbose=FALSE) {
    assert_that(is.string(method))
    assert_that(is.flag(refresh_cache))
    assert_that(is.flag(public_only))
    method <- match.arg(tolower(method),c("get","direct"))
    if (method=="direct") {
        if (!requireNamespace("aadcdb", quietly = TRUE)) {
            stop("The aadcdb package is required for method=\"direct\"",call.=FALSE)
        }
        on.exit(try(aadcdb::db_close(dbh),silent=TRUE))
        where_string <- if (public_only) " where is_public_flag='Y'" else ""
        dbh <- aadcdb::db_open()
        x <- aadcdb::db_query(dbh,paste0("select * from ",getOption("sohungry")$isotopes_table,where_string))
        if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
        if ("taxon_group" %in% names(x) && nrow(x)>0) x <- x %>% rename_(taxon_group_soki=~taxon_group)
        xs <- aadcdb::db_query(dbh,paste0("select * from ",getOption("sohungry")$isotopes_sources_table))
    } else {
        unzipped_data_dir <- soded_webget(cache_directory,refresh_cache=refresh_cache,verbose=verbose)
        suppress <- if (!verbose) function(...)suppressWarnings(suppressMessages(...)) else function(...) identity(...)
        suppress(x <- read_csv(file.path(unzipped_data_dir,getOption("sohungry")$isotopes_file)))
        ##if ("last_modified" %in% names(x) && nrow(x)>0) x$last_modified <- ymd_hms(x$last_modified)
        suppress(xs <- read_csv(file.path(unzipped_data_dir,getOption("sohungry")$isotopes_sources_file)))
    }
    x %>% left_join(xs %>% select_("source_id",source_details=~details,source_doi=~doi),by="source_id")
}

## internal function to retrieve the zipped data file and unpack it
soded_webget <- function(cache_directory,refresh_cache=FALSE,verbose=FALSE) {
    ## fetch via GET, with local caching support
    unzipped_data_dir <- tempfile(pattern="soded_")
    dir.create(unzipped_data_dir)
    if (!dir.exists(unzipped_data_dir)) stop("could not create temporary data directory")

    use_cache <- FALSE ## use cached copy without re-retrieving
    local_file_name <- "soded_data.zip"

    download_url <- "http://data.aad.gov.au/database/trophic/scar_dump_v2.zip" ## temporary location, will be moved to registered AADC download file or geoserver endpoint
    ## http://data.aad.gov.au/geoserver/aadc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=aadc:TROPHIC_DIET&maxFeatures=100000&outputFormat=csv
    if (!missing(cache_directory)) {
        assert_that(is.string(cache_directory))
        if (!dir.exists(cache_directory)) {
            if (verbose) cat("creating data cache directory: ",cache_directory,"\n")
            ok <- dir.create(cache_directory)
            if (!ok) stop("could not create cache directory: ",cache_directory)
        } else {
            ## cache dir exists
            use_cache <- TRUE
            temp <- file.path(cache_directory,local_file_name)
            ## but don't use_cache if we are refreshing it, or if the file doesn't exist
            if (refresh_cache || !file.exists(temp)) use_cache <- FALSE
            ## is cached copy old?
            if (file.exists(temp)) {
                if (difftime(Sys.time(),file.info(temp)$mtime,units="days")>30)
                    warning("cached copy of data is more than 30 days old, consider refreshing your copy")
            }
        }
    } else {
        ## save to tempdir
        cache_directory <- tempdir()
    }
    local_file_name <- file.path(cache_directory,local_file_name)
    ## fetch data if needed
    if (!use_cache) {
        if (verbose) cat("downloading data file from ",download_url," to ",local_file_name," ...")
        chand <- new_handle()
        handle_setopt(chand,ssl_verifypeer=0) ## temporarily, to avoid issues with AAD certs
        curl_download(download_url,destfile=local_file_name,quiet=!verbose,mode="wb",handle=chand)
        if (verbose) cat("done.\n")
    }
    ## unzip
    unzip(local_file_name,exdir=unzipped_data_dir)
    unzipped_data_dir
}

