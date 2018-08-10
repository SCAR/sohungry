context("sohungry data retrieval")

test_that("data retrieval works", {
    skip_on_cran()
    expect_warning(xi <- so_isotopes(method="get"))
    expect_warning(xi <- so_isotopes(method="get", format="wide"))
    xi <- so_isotopes(method="get", format="mv")

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

