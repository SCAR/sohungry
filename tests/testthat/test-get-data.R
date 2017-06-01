context("sohungry")

test_that("data retrieval works", {
    xi <- so_isotopes(method="get")
    xd <- so_diet(method="get")
})
