#' Filter data by predator, prey, or taxon name
#'
#' A convenience function that matches on the species and/or group names.
#' \code{filter_by_predator_name} is a convenience shorthand for \code{filter_by_name(...,name_type="predator")}
#' \code{filter_by_prey_name} is a convenience shorthand for \code{filter_by_name(...,name_type="prey")}
#'
#' @param x data.frame: diet data as returned by e.g. \code{so_diet} or \code{so_isotopes}
#' @param name character: vector of one or more names to match on
#' @param name_type string: one of "predator", "prey", "predatorprey" (to match on either predator names or prey names), or "taxon". If missing will default to predator names for diet data, and taxon names for isotope data
#'
#' @return data.frame
#'
#' @seealso \code{\link{so_diet}}, \code{\link{so_isotopes}}
#'
#' @examples
#' \dontrun{
#'   x <- so_isotopes()
#'   x %>% filter_by_name(c("Electrona","Gymnoscopelus"),"taxon")
#'
#'   x <- so_diet()
#'   x %>% filter_by_name("Electrona carlsbergi",name_type="predator")
#'   ## equivalent to
#'   x %>% filter_by_predator_name("Electrona carlsbergi")
#' }
#'
#' @export
filter_by_name <- function(x,name,name_type) {
    if (missing(name_type)) {
        if (any(names(x)=="predator_name")) {
            name_type <- "predator"
        } else if (any(names(x)=="taxon_name")) {
            name_type <- "taxon"
        }
    }
    name_type <- match.arg(tolower(name_type),c("predator","prey","predatorprey","taxon"))
    ## check that we have the expected column names
    if (name_type %in% c("predator","predatorprey")) {
        if (!all(c("predator_name","predator_group_soki") %in% names(x))) stop("data.frame must contain columns predator_name, predator_group_soki")
    }
    if (name_type %in% c("prey","predatorprey")) {
        if (!all(c("prey_name","prey_group_soki") %in% names(x))) stop("data.frame must contain columns prey_name, prey_group_soki")
    }
    if (name_type %in% c("taxon")) {
        if (!all(c("taxon_name","taxon_group_soki") %in% names(x))) stop("data.frame must contain columns taxon_name, taxon_group_soki")
    }
    ## name is a character vector (one or more names)
    name <- tolower(name)
    is_single_word <- function(z) !grepl("[[:space:]]",z)
    ## filter on each entry in input parm name in turn, then OR these all together
    ## build as string first
    flt <- sapply(name,function(z) {if (is_single_word(z)) paste0("grepl(\"^",z,"\",predator_name,ignore.case=TRUE) | grepl(\"",z,"\",predator_group_soki,ignore.case=TRUE)") else paste0("tolower(predator_name)==\"",z,"\" | grepl(\"",z,"\",predator_group_soki,ignore.case=TRUE)")})
    if (name_type=="prey") {
        flt <- gsub("predator_","prey_",flt)
    } else if (name_type=="predatorprey") {
        ## match on predator or prey
        flt <- paste0("((",flt,") OR (",gsub("predator_","prey_",flt),"))")
    } else if (name_type=="taxon") {
        flt <- gsub("predator_","taxon_",flt)
    }
    flt <- paste(flt,collapse=" | ")
    x %>% filter_(flt)
}


#' @rdname filter_by_name
#' @export
filter_by_predator_name <- function(x,name) filter_by_name(x,name,name_type="predator")

#' @rdname filter_by_name
#' @export
filter_by_prey_name <- function(x,name) filter_by_name(x,name,name_type="prey")

#' Filter out diet data below a given importance threshold
#'
#' A diet record is retained if any of the importance measures are above the threshold.
#' Records with all-NA importance values will be removed.
#'
#' @param x data.frame: diet data, as returned by \code{so_diet}
#' @param threshold numeric: remove entries below this threshold
#' @param which_measures string: one or more of "fraction_diet_by_weight", "fraction_diet_by_prey_items", "fraction_occurrence", or "any" (shorthand for all three)
#'
#' @return data.frame
#'
#' @seealso \code{\link{so_diet}}, \code{\link{replace_by_importance}}
#'
#' @examples
#' \dontrun{
#'   x <- so_isotopes()
#'   x %>% filter_by_importance(0.1)
#' }
#'
#' @export
filter_by_importance <- function(x,threshold,which_measures="any") {
    assert_that(is.number(threshold))
    assert_that(is.character(which_measures))
    which_measures <- match.arg(tolower(which_measures),c("any","fraction_diet_by_weight","fraction_diet_by_prey_items","fraction_occurrence"))
    if (which_measures=="any") which_measures <- c("fraction_diet_by_weight","fraction_diet_by_prey_items","fraction_occurrence")
    flt <- paste0(which_measures,">=threshold",collapse=" | ")
    x %>% filter_(as.formula(paste0("~",flt)))
}
