context("sohungry DOIs")

test_that("DOI function works", {
    ## DOI of data in a particular directory
    ## directory is nonexistent
    expect_true(is.na(so_doi(cache_directory = "this_is_not_a_valid_cache_directory")))
    ## fake one up
    writeLines(text = "10.something", con = file.path(tempdir(), so_opt("doi_file")))
    expect_identical(so_doi(cache_directory = tempdir()), "10.something")

    ## DOI of data last read
    skip_on_cran()
    xi <- so_isotopes(method = "get", format = "mv", cache_directory = "session")
    my_doi <- so_doi()
    expect_false(is.na(my_doi))
    expect_true(grepl("^10\\.", my_doi))
    my_doi2 <- so_doi(cache_directory = "session")
    expect_identical(my_doi, my_doi2)
})

