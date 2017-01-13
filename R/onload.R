.onLoad <- function(libname,pkgname) {
    ## populate the options slot
    this_options <- list(
        isotopes_table="ecology.dbo.scar_isotopes",
        isotopes_sources_table="ecology.dbo.scar_references",
        diet_table="ecology.dbo.trophic_diet",
        diet_sources_table="ecology.dbo.ecology_references",
        isotopes_file="scar_isotopes.csv",
        isotopes_sources_file="scar_sources.csv",
        diet_file="diet.csv",
        diet_sources_file="sources.csv"
    )
    options(list(sohungry=this_options))
    invisible()
}
