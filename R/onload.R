.onLoad <- function(libname,pkgname) {
    ## populate the options slot
    this_options <- list(
        sources_table="ecology.dbo.scar_references",
        sources_file="scar_sources.csv",
        energetics_table="ecology.dbo.scar_energetics",
        energetics_file="scar_energetics.csv",
        isotopes_table="ecology.dbo.scar_isotopes",
        isotopes_file="scar_isotopes.csv",
        isotopes_mv_file="scar_isotopes_mv.csv",
        diet_table="ecology.dbo.scar_diet",
        diet_file="scar_diet.csv",
        dna_diet_table="ecology.dbo.scar_dna_diet",
        dna_diet_file="scar_dna_diet.csv",
        lipids_table="ecology.dbo.scar_lipids",
        lipids_file="scar_lipids.csv",
        issue_text="If the problem persists, please lodge an issue at https://github.com/SCAR/sohungry/issues",
        session_cache_dir=tempfile(pattern="sohungry_")
    )
    options(list(sohungry=this_options))
    invisible()
}
