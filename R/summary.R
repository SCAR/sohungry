#' Diet summaries from the SCAR Southern Ocean Diet and Energetics Database
#'
#' Given a predator (prey) name, the prey (predators) are aggregated to group level.
#'
#' @param x data.frame: diet data, as returned by \code{so_diet}
#' @param predator_name string: name of predator taxon
#' @param prey_name string: name of prey taxon
#' @param minimum_importance numeric: ignore records with dietary importance less than this threshold
#' @param treat_trace_values_as numeric: what numeric value to use for a dietary item recorded as "trace"
#'
#' @return data.frame with columns:
#' \itemize{
#'    \item{fraction_diet_by_weight - mean fraction of diet by weight}
#'    \item{N_fraction_diet_by_weight - number of diet observations where fraction of diet by weight was quantified}
#'    \item{fraction_occurrence - mean fraction of occurrence}
#'    \item{N_fraction_occurrence - number of diet observations where fraction of occurrence quantified}
#'    \item{fraction_diet_by_prey_items - mean fraction of diet by number of prey items}
#'    \item{N_fraction_diet_by_prey_items - number of diet observations where fraction of diet by number of prey items was quantified}
#' }
#'
#' @examples
#' \dontrun{
#'   library(dplyr)
#'   x <- so_diet()
#'
#'   ## summary of what Electrona carlsbergi eats
#'   x %>% diet_summary(predator_name="Electrona carlsbergi")
#'
#'   ## summary of what eats Electrona carlsbergi
#'   x %>% diet_summary(prey_name="Electrona carlsbergi")
#' }
#'
#' @export
diet_summary <- function(x,predator_name,prey_name,minimum_importance=0,treat_trace_values_as=0) {
    if (missing(predator_name) && missing(prey_name)) stop("require one of predator_name or prey_name")

    ## retrieve data without applying min importance yet
    if (!missing(predator_name)) {
        out <- x %>% filter_by_name(name=predator_name,name_type="predator") %>% mutate_(group=~prey_group_name)
    } else if (!missing(prey_name)) {
        out <- x %>% filter_by_name(name=prey_name,name_type="prey") %>% mutate_(group=~predator_group_name)
    }
    out <- out %>% replace_trace_values(treat_trace_values_as)
    ## aggregate by group
    out <- out %>% group_by_(~group) %>%
        summarize_(fraction_diet_by_weight=~as.numeric(mean(fraction_diet_by_weight,na.rm=TRUE)),
                   N_fraction_diet_by_weight=~sum(!is.na(fraction_diet_by_weight)),
                   fraction_occurrence=~as.numeric(mean(fraction_occurrence,na.rm=TRUE)),
                   N_fraction_occurrence=~sum(!is.na(fraction_occurrence)),
                   fraction_diet_by_prey_items=~as.numeric(mean(fraction_diet_by_prey_items,na.rm=TRUE)),
                   N_fraction_diet_by_prey_items=~sum(!is.na(fraction_diet_by_prey_items))) %>%
        mutate_(all_zero_count=~N_fraction_diet_by_weight==0 & N_fraction_occurrence==0 & N_fraction_diet_by_prey_items==0) %>%
        mutate_(group=~replace(group,is.na(group),"Uncategorized group")) %>%
        filter_by_importance(threshold=minimum_importance) %>% ##apply minimum importance threshold now, after aggregation
        filter_(~(fraction_diet_by_weight>0 | fraction_occurrence>0 | fraction_diet_by_prey_items>0) | (all_zero_count))
    ##last OR condition is special case: if all dietary importance measures are null for this group, we still want to show it
    if (!missing(predator_name)) {
        out %>% select_(quote(-all_zero_count)) %>% rename_(prey=~group)
    } else {
        out %>% select_(quote(-all_zero_count)) %>% rename_(predator=~group)
    }
}

