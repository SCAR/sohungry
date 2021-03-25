#' Replace "trace" values in diet data
#'
#' Some diet studies record small amounts of a prey item as "trace".
#' These are encoded in the diet database using the value -999.
#' This function replaces those entries with the nominated numeric value.
#'
#' @param x data.frame: diet data, as returned by \code{so_diet}
#' @param replace_with numeric: value to use as a replacement for "trace" values
#'
#' @return data.frame
#'
#' @seealso \code{\link{so_diet}}
#'
#' @examples
#' \dontrun{
#'   x <- so_diet() %>% replace_trace_values()
#' }
#'
#' @export
replace_trace_values <- function(x, replace_with = 0) {
    assert_that(is.number(replace_with) || is.na(replace_with))
    is_trace <- function(z) z == -999
    mutate(x, fraction_diet_by_weight = replace(.data$fraction_diet_by_weight, is_trace(.data$fraction_diet_by_weight), replace_with)) %>%
        mutate(fraction_diet_by_prey_items = replace(.data$fraction_diet_by_prey_items, is_trace(.data$fraction_diet_by_prey_items), replace_with)) %>%
        mutate(fraction_occurrence = replace(.data$fraction_occurrence, is_trace(.data$fraction_occurrence), replace_with))
}


#' Replace diet data entries below a given importance threshold
#'
#' @param x data.frame: diet data, as returned by \code{so_diet}
#' @param threshold numeric: replace entries below this threshold
#' @param replace_with numeric: value to replace with
#' @param which_measures string: one or more of "fraction_diet_by_weight", "fraction_diet_by_prey_items", "fraction_occurrence", or "all" (shorthand for all three)
#'
#' @return data.frame
#'
#' @seealso \code{\link{so_diet}} \code{\link{filter_by_importance}}
#'
#' @examples
#' \dontrun{
#'   x <- so_diet()
#'   ## discard entries representing less than 10% of diet
#'   x <- x %>% replace_by_importance(0.1)
#' }
#'
#' @export
replace_by_importance <- function(x, threshold, replace_with = NA, which_measures = "all") {
    assert_that(is.number(threshold))
    assert_that(is.number(replace_with) || is.na(replace_with))
    assert_that(is.character(which_measures))
    which_measures <- match.arg(tolower(which_measures), c("all", "fraction_diet_by_weight", "fraction_diet_by_prey_items", "fraction_occurrence"))
    if (any(c("all", "fraction_diet_by_weight") %in% which_measures))
        x <- mutate(x, fraction_diet_by_weight = replace(.data$fraction_diet_by_weight, .data$fraction_diet_by_weight < threshold, replace_with))
    if (any(c("all", "fraction_diet_by_prey_items") %in% which_measures))
        x <- mutate(x, fraction_diet_by_prey_items = replace(.data$fraction_diet_by_prey_items, .data$fraction_diet_by_prey_items < threshold, replace_with))
    if (any(c("all", "fraction_occurrence") %in% which_measures))
        x <- mutate(x, fraction_occurrence = replace(.data$fraction_occurrence, .data$fraction_occurrence < threshold, replace_with))
    x
}
