#' \pkg{sohungry}
#'
#' Provides access to data from the SCAR Southern Ocean Diet and Energetics Database.
#'
#' @name sohungry
#' @docType package
#' @references \url{http://data.aad.gov.au/trophic}
#' @importFrom assertthat assert_that is.flag is.number is.string
#' @importFrom curl curl_download handle_setopt handle_setheaders new_handle
#' @importFrom dplyr %>% bind_rows bind_cols group_by left_join mutate rename summarize tibble
#' @importFrom lubridate ymd_hms
#' @importFrom readr cols read_csv
#' @importFrom rlang .data
#' @importFrom stats as.formula
#' @importFrom utils unzip
NULL
