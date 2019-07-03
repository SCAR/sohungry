context("sohungry isotope corrections")

test_that("isotope correction function works", {
    ## test data
    myx <- data.frame(d13c = -26.8160009, d15n = 4.484562653, cn_ratio = 3.70135747, cn_ratio_type = "mass", stringsAsFactors = FALSE)
    ## d13C correction methods
    adj_mth <- c("Kiljunen 2006", "Kiljunen 2006 atomic", "Post 2007", "Weldrick 2019", "Smyntek 2007 atomic", "Smyntek 2007", "Logan 2008", "Syvaranta 2010")
    ## expected values
    adj_d13c <- c(-25.78428738, -24.94742082, -26.47165701, -24.3860009, -25.33045078, -26.13285909, -26.3763846, -24.628941)
    for (mi in seq_along(adj_mth)) {
        xadj <- so_isotope_adjust(d13c = myx$d13c, d15n = myx$d15n, cn_ratio = myx$cn_ratio, cn_ratio_type = myx$cn_ratio_type, method = adj_mth[mi])
        expect_equal(xadj$d13c, adj_d13c[mi])
    }
})
