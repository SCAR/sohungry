.onLoad <- function(libname,pkgname) {
    ## populate the options slot
    cachedir <- file.path(tempdir(),"sohungry")
    this_options <- list(
        sources_table="ecology.dbo.scar_references",
        sources_file="scar_sources.csv",
        energetics_table="ecology.dbo.scar_energetics",
        energetics_file="scar_energetics.csv",
        isotopes_table="ecology.dbo.scar_isotopes",
        isotopes_file="scar_isotopes.csv",
        diet_table="ecology.dbo.scar_diet",
        diet_file="scar_diet.csv",
        lipids_table="ecology.dbo.scar_lipids",
        lipids_file="scar_lipids.csv",
        cache_dir=cachedir
    )
    options(list(sohungry=this_options))
    invisible()
}
