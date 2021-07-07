context("sohungry data retrieval")

test_that("data retrieval works", {
    skip_on_cran()
    xi <- so_isotopes(method="get")
    expect_error(xi <- so_isotopes(method="get", format="wide"), regexp = "no longer supported")
    xi2 <- so_isotopes(method="get", format="mv")
    expect_identical(xi, xi2)

    xd <- so_diet(method="get")
})


test_that("session caching works", {
    skip_on_cran()
    cdir <- so_opt("session_cache_dir")
    cfile <- file.path(cdir, so_opt("zip_file"))
    if (file.exists(cfile)) file.remove(cfile)
    expect_message(xl <- so_lipids(cache_directory = "session", verbose = TRUE), "downloading data file")
    expect_true(file.exists(cfile))
    finfo <- file.info(cfile)

    ## re-read using cache
    expect_message(xl <- so_lipids(cache_directory = "session", verbose = TRUE), "using cached")
    expect_identical(finfo$mtime, file.info(cfile)$mtime)

    ## refresh cache
    xl <- so_lipids(cache_directory = "session", refresh_cache = TRUE)

    ## mtime should have changed
    expect_gt(as.numeric(file.info(cfile)$mtime), as.numeric(finfo$mtime))
})

test_that("persistent caching works", {
    skip_on_cran()
    cdir <- so_opt("persistent_cache_dir")
    cfile <- file.path(cdir, so_opt("zip_file"))
    if (file.exists(cfile)) file.remove(cfile)
    xd <- so_diet(cache_directory = "persistent")
    expect_true(file.exists(cfile))
    finfo <- file.info(cfile)

    ## re-read using cache
    xd <- so_diet(cache_directory = "persistent")
    expect_identical(finfo$mtime, file.info(cfile)$mtime)

    ## refresh cache
    xd <- so_diet(cache_directory = "persistent", refresh_cache = TRUE)

    ## mtime should have changed
    expect_gt(as.numeric(file.info(cfile)$mtime), as.numeric(finfo$mtime))
})

test_that("persistent caching to custom directory works", {
    skip_on_cran()
    cdir <- tempdir()
    cfile <- file.path(cdir, so_opt("zip_file"))
    if (file.exists(cfile)) file.remove(cfile)
    xd <- so_diet(cache_directory = cdir)
    expect_true(file.exists(cfile))
    finfo <- file.info(cfile)

    ## re-read using cache
    xd <- so_diet(cache_directory = cdir)
    expect_identical(finfo$mtime, file.info(cfile)$mtime)

    ## refresh cache
    xd <- so_diet(cache_directory = cdir, refresh_cache = TRUE)

    ## mtime should have changed
    expect_gt(as.numeric(file.info(cfile)$mtime), as.numeric(finfo$mtime))
})

test_that("column format detection isn't throwing warnings", {

    trap_warns <- function(...) {
        withCallingHandlers(eval(...),
                            warning = function(w){
                                if(grepl("will become the default", w$message)){
                                    NULL ## ignore this
                                } else {
                                    stop(w$message)
                                }
                            })
    }

    ## setting verbose = TRUE will cause read_csv to give messages, plus parsing failures will throw warnings
    ## use trap_warns to promote warnings to errors, but ignoring the "will become the default" warning
    expect_silent(suppressMessages(suppressWarnings(temp <- trap_warns(so_isotopes(cache_directory = "session", verbose = TRUE)))))
    expect_silent(suppressMessages(suppressWarnings(temp <- trap_warns(so_isotopes(cache_directory = "session", verbose = TRUE, format = "mv")))))
    expect_silent(suppressMessages(suppressWarnings(temp <- trap_warns(so_lipids(cache_directory = "session", verbose = TRUE)))))
    expect_silent(suppressMessages(suppressWarnings(temp <- trap_warns(so_energetics(cache_directory = "session", verbose = TRUE)))))
    expect_silent(suppressMessages(suppressWarnings(temp <- trap_warns(so_diet(cache_directory = "session", verbose = TRUE)))))
    expect_silent(suppressMessages(suppressWarnings(temp <- trap_warns(so_dna_diet(cache_directory = "session", verbose = TRUE)))))
})
