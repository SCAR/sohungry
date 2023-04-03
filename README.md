
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sohungry

[![R-CMD-check](https://github.com/SCAR/sohungry/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/SCAR/sohungry/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/SCAR/sohungry/branch/master/graph/badge.svg)](https://codecov.io/gh/SCAR/sohungry)
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/sohungry)](http://cran.r-project.org/web/packages/sohungry)

## Overview

This R package provides access to the SCAR Southern Ocean Diet and
Energetics Database, and some tools for working with these data. For
more information about the database see
<https://scar.org/resources/southern-ocean-diet-energetics/>.

### Installing

``` r
options(repos = c(scar = "https://scar.r-universe.dev", CRAN = "https://cloud.r-project.org"))
install.packages("sohungry")

## or install from github
## install.packages("remotes") ## if needed
remotes::install_github("SCAR/sohungry")
```

## Usage

Basic usage: load the desired dataset using `so_isotopes()`,
`so_energetics()`, `so_lipids()`, `so_dna_diet()`, or `so_diet()`.

## Examples

See the [package
vignette](https://scar.github.io/sohungry/articles/sohungry.html).
