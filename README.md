
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

Load the desired dataset using `so_isotopes()` or `so_diet()`. Note that these read the data from the server (or cache, depending on caching settings). For fastest performance should probably be called once per session and kept in memory. Load the stable isotope data:

``` r
xi <- so_isotopes()
```

Filter to taxon of interest:

``` r
xi %>% filter(taxon_name=="Electrona carlsbergi") %>% select(delta_13c_mean,delta_15n_mean)
#> # A tibble: 2 × 2
#>   delta_13c_mean delta_15n_mean
#>            <dbl>          <dbl>
#> 1          -21.6            9.5
#> 2          -21.6            9.5
```

Load the diet data (stomach content analyses and similar):

``` r
x <- so_diet()
```

A summary of what *Electrona carlsbergi* eats:

``` r
x %>% filter_by_predator_name("Electrona carlsbergi") %>% diet_summary(summary_type="prey")
#> # A tibble: 12 × 7
#>                                          prey fraction_diet_by_weight
#>                                         <chr>                   <dbl>
#> 1  <i>Euphausia superba</i> (Antarctic krill)                     NaN
#> 2                  Chaetognatha (arrow worms)               0.0970000
#> 3                         Copepoda (copepods)                     NaN
#> 4                     Crustacea (crustaceans)               0.1100000
#> 5                   Euphausiids (other krill)               0.3222377
#> 6                                        Fish               0.1230000
#> 7                             Heterorhabdidae                     NaN
#> 8             Hyperiidea (hyperiid amphipods)               0.4098361
#> 9         Malacostraca (class of crustaceans)               0.0134959
#> 10         Maxillopoda (class of crustaceans)               0.0420000
#> 11                                      Salps                     NaN
#> 12                        Uncategorized group               0.3840000
#> # ... with 5 more variables: N_fraction_diet_by_weight <int>,
#> #   fraction_occurrence <dbl>, N_fraction_occurrence <int>,
#> #   fraction_diet_by_prey_items <dbl>, N_fraction_diet_by_prey_items <int>
```

And what eats *Electrona carlsbergi*:

``` r
x %>% filter_by_prey_name("Electrona carlsbergi") %>% diet_summary(summary_type="predators")
#> # A tibble: 14 × 7
#>                                                            predator
#>                                                               <chr>
#> 1                     <i>Aptenodytes patagonicus</i> (king penguin)
#> 2  <i>Arctocephalus</i> spp. (Antarctic and subantarctic fur seals)
#> 3                 <i>Champsocephalus gunnari</i> (mackerel icefish)
#> 4                              <i>Dissostichus</i> spp. (toothfish)
#> 5                   <i>Eudyptes chrysocome</i> (rockhopper penguin)
#> 6                   <i>Eudyptes chrysolophus</i> (Macaroni penguin)
#> 7                         <i>Eudyptes schlegeli</i> (royal penguin)
#> 8                 <i>Mirounga leonina</i> (southern elephant seals)
#> 9                          <i>Pygoscelis papua</i> (gentoo penguin)
#> 10                                        Diomedeidae (albatrosses)
#> 11                                   Onychoteuthidae (hooked squid)
#> 12                                          Otariidae (eared seals)
#> 13                                   Phalacrocoracidae (cormorants)
#> 14                           Procellariidae (procellariid seabirds)
#> # ... with 6 more variables: fraction_diet_by_weight <dbl>,
#> #   N_fraction_diet_by_weight <int>, fraction_occurrence <dbl>,
#> #   N_fraction_occurrence <int>, fraction_diet_by_prey_items <dbl>,
#> #   N_fraction_diet_by_prey_items <int>
```
