.onLoad <- function(libname,pkgname) {
    ## populate the options slot
    this_options <- list(
        energetics_table="ecology.dbo.scar_energetics",
        energetics_sources_table="ecology.dbo.scar_references",
        energetics_file="scar_energetics.csv",
        energetics_sources_file="scar_sources.csv",
        isotopes_table="ecology.dbo.scar_isotopes",
        isotopes_sources_table="ecology.dbo.scar_references",
        diet_table="ecology.dbo.scar_diet",
        diet_sources_table="ecology.dbo.scar_references",
        isotopes_file="scar_isotopes.csv",
        isotopes_sources_file="scar_sources.csv",
        diet_file="scar_diet.csv",
        diet_sources_file="scar_sources.csv",
        cache_dir=file.path(tempdir(),"sohungry"),
        worms_cache_dir=file.path(tempdir(),"worms")
    )
    options(list(sohungry=this_options))
    invisible()
}
