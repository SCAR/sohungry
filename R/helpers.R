## internal helper functions

so_opts <- function() getOption("sohungry")
so_opt <- function(optname) so_opts()[[optname]]
so_set_opt <- function(...) {
    opts <- so_opts()
    newopts <- list(...)
    for (nm in names(newopts)) opts[[nm]] <- newopts[[nm]]
    options(list(sohungry = opts))
}
