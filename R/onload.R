.onLoad <- function(libname, pkgname) {
    ## populate the options slot
    this_options <- list(
        doi_file = "scar_diet_energetics_doi.txt",
        sources_table = "ecology.dbo.scar_references",
        sources_file = "scar_sources.csv",
        energetics_table = "ecology.dbo.scar_energetics",
        energetics_file = "scar_energetics.csv",
        isotopes_table = "ecology.dbo.scar_isotopes",
        ##isotopes_file = "scar_isotopes.csv", ## deprecated as of v0.9.0
        isotopes_mv_file = "scar_isotopes_mv.csv",
        diet_table = "ecology.dbo.scar_diet",
        diet_file = "scar_diet.csv",
        dna_diet_table = "ecology.dbo.scar_dna_diet",
        dna_diet_file = "scar_dna_diet.csv",
        lipids_table = "ecology.dbo.scar_lipids",
        lipids_file = "scar_lipids.csv",
        zenodo_id = 5072528, ## old was 3973742
        zip_file = "SCAR_Diet_Energetics.zip",
        issue_text = "If the problem persists, please lodge an issue at https://github.com/SCAR/sohungry/issues",
        session_cache_dir = file.path(tempdir(), "sohungry-cache"), ## cache directory to use for cache_directory = "session"
        persistent_cache_dir = rappdirs::user_cache_dir("sohungry", "SCAR") ## and for cache_directory = "persistent"
    )
    options(list(sohungry = this_options))
    invisible()
}
