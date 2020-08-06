
<!-- README.md is generated from README.Rmd. Please edit that file -->
sohungry
========

[![Travis-CI Build Status](https://travis-ci.org/SCAR/sohungry.svg?branch=master)](https://travis-ci.org/SCAR/sohungry) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/SCAR/sohungry?branch=master&svg=true)](https://ci.appveyor.com/project/SCAR/sohungry) [![codecov](https://codecov.io/gh/SCAR/sohungry/branch/master/graph/badge.svg)](https://codecov.io/gh/SCAR/sohungry) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/sohungry)](http://cran.r-project.org/web/packages/sohungry) ![downloads](http://cranlogs.r-pkg.org/badges/grand-total/sohungry)


Overview
--------

This R package provides access to the SCAR Southern Ocean Diet and Energetics Database, and some tools for working with these data. For more information about the database see <http://data.aad.gov.au/trophic/>.

### Installing

``` r
install.packages("devtools")
library(devtools)
install_github("SCAR/sohungry")
```

Usage
-----

Basic usage: load the desired dataset using `so_isotopes()`, `so_energetics()`, `so_lipids()`, `so_dna_diet()`, or `so_diet()`.

Examples
--------

See the [package vignette](https://scar.github.io/sohungry/articles/sohungry.html).
