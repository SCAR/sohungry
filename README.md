
<!-- README.md is generated from README.Rmd. Please edit that file -->
sohungry
========

[![Travis-CI Build Status](https://travis-ci.org/SCAR/sohungry.svg?branch=master)](https://travis-ci.org/SCAR/sohungry) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/SCAR/sohungry?branch=master&svg=true)](https://ci.appveyor.com/project/SCAR/sohungry)

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
```

Load the desired dataset using `so_isotopes()` or `so_diet()`. Note that these read the data from the server (or cache, depending on caching settings). For fastest performance should probably be called once per session and kept in memory:

``` r
x <- so_isotopes()
```

Filter the data:

``` r
x %>% filter(taxon_name=="Electrona carlsbergi") %>% select(delta_13c_mean,delta_15n_mean)
#> # A tibble: 2 × 2
#>   delta_13c_mean delta_15n_mean
#>            <dbl>          <dbl>
#> 1          -21.6            9.5
#> 2          -21.6            9.5
```
