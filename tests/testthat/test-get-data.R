context("sohungry data retrieval")

test_that("data retrieval works", {
    expect_warning(xi <- so_isotopes(method="get"))
    expect_warning(xi <- so_isotopes(method="get", format="wide"))
    xd <- so_diet(method="get")

    skip("skipping isotopes/mv test temporarily")
    xi <- so_isotopes(method="get", format="mv")
})
