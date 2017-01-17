context("sohungry")

test_that("filtering of diet data works", {
    xx <- data.frame(fraction_diet_by_weight=c(0,NA,0),fraction_diet_by_prey_items=c(1,1,0),fraction_occurrence=c(1,1,0))
    expect_equal(nrow(xx %>% filter_by_importance(0.1)),2)

    ## filter all-NA row
    xx <- data.frame(fraction_diet_by_weight=c(0,NA,NA),fraction_diet_by_prey_items=c(1,NA,0),fraction_occurrence=c(1,NA,0))
    expect_equal(nrow(xx %>% filter_by_importance(0.1)),1)
})
