
<!-- README.md is generated from README.Rmd. Please edit that file -->
sohungry
========

Overview
--------

This R package provides access to the SCAR Southern Ocean Diet and Energetics Database: see <http://data.aad.gov.au/trophic/>.

Installing
----------

``` r
install.packages("devtools")
library(devtools)
install_github("SCAR/sohungry")
```

Usage
-----

``` r
library(sohungry)
library(dplyr)
#> Warning: package 'dplyr' was built under R version 3.3.1
x <- so_isotopes()
x %>% filter(taxon_name=="Electrona carlsbergi") %>% select(delta_13c_mean,delta_15n_mean)
#> # A tibble: 2 × 2
#>   delta_13c_mean delta_15n_mean
#>            <dbl>          <dbl>
#> 1          -21.6            9.5
#> 2          -21.6            9.5
```
