#' Diet summaries from the SCAR Southern Ocean Diet and Energetics Database
#'
#' Given a diet data.frame, the prey or predators are aggregated to group level and dietary importance values reported.
#' Note that dietary importance values are currently calculated by unweighted averaging across studies (so that e.g. a
#' study of 100 individuals will carry the same weight as a study of one individual).
#'
#' @param x data.frame: diet data, as returned by \code{so_diet}
#' @param summary_type string: either "predators" (report the predators in the data) or "prey" (report the prey items)
#' @param minimum_importance numeric: ignore records with dietary importance less than this threshold
#' @param treat_trace_values_as numeric: what numeric value to use for a dietary item recorded as "trace"
#'
#' @return data.frame with columns:
#' \itemize{
#'    \item{N_fraction_diet_by_weight - number of diet observations where fraction of diet by weight was quantified}
#'    \item{fraction_diet_by_weight - mean fraction of diet by weight}
#'    \item{N_fraction_occurrence - number of diet observations where fraction of occurrence quantified}
#'    \item{fraction_occurrence - mean fraction of occurrence}
#'    \item{N_fraction_diet_by_prey_items - number of diet observations where fraction of diet by number of prey items was quantified}
#'    \item{fraction_diet_by_prey_items - mean fraction of diet by number of prey items}
#' }
#'
#' @examples
#' \dontrun{
#'   x <- so_diet()
#'
#'   ## summary of what Electrona carlsbergi eats
#'   x %>% filter_by_predator_name("Electrona carlsbergi") %>%
#'   diet_summary(summary_type = "prey")
#'
#'   ## summary of what eats Electrona carlsbergi
#'   x %>% filter_by_prey_name("Electrona carlsbergi") %>%
#'   diet_summary(summary_type = "predators")
#' }
#'
#' @export
diet_summary <- function(x, summary_type = "prey", minimum_importance = 0, treat_trace_values_as = 0) {
    assert_that(is.string(summary_type))
    summary_type <- match.arg(tolower(summary_type), c("prey", "predators"))
    ## rename appropriate col to "group"
    if (summary_type == "prey") {
        out <- mutate(x, group = .data$prey_group_soki)
    } else {
        out <- mutate(x, group = .data$predator_group_soki)
    }
    ## deal with trace values before aggregation
    out <- replace_trace_values(out, treat_trace_values_as)
    ## aggregate by group
    out <- group_by(out, .data$group) %>%
        summarize(N_fraction_diet_by_weight = sum(!is.na(.data$fraction_diet_by_weight)),
                  fraction_diet_by_weight = as.numeric(mean(.data$fraction_diet_by_weight, na.rm = TRUE)),
                  N_fraction_occurrence = sum(!is.na(.data$fraction_occurrence)),
                  fraction_occurrence = as.numeric(mean(.data$fraction_occurrence, na.rm = TRUE)),
                  N_fraction_diet_by_prey_items = sum(!is.na(.data$fraction_diet_by_prey_items)),
                  fraction_diet_by_prey_items = as.numeric(mean(.data$fraction_diet_by_prey_items, na.rm = TRUE))) %>%
        mutate(all_zero_count = .data$N_fraction_diet_by_weight == 0 & .data$N_fraction_occurrence == 0 & .data$N_fraction_diet_by_prey_items == 0) %>%
        mutate(group = replace(.data$group, is.na(.data$group), "Uncategorized group")) %>%
        filter_by_importance(threshold = minimum_importance) %>% ##apply minimum importance threshold now, after aggregation
        dplyr::filter((.data$fraction_diet_by_weight>0 | .data$fraction_occurrence>0 | .data$fraction_diet_by_prey_items>0) | (.data$all_zero_count))
    ##last OR condition is special case: if all dietary importance measures are null for this group, we still want to show it
    if (summary_type == "prey") {
        dplyr::rename(dplyr::select(out, -"all_zero_count"), prey = "group")
    } else {
        dplyr::rename(dplyr::select(out, -"all_zero_count"), predator = "group")
    }
}

