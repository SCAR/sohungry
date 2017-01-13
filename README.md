
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
x %>% filter(taxon_name=="Electrona carlsbergi")
#> # A tibble: 2 × 64
#>   record_id source_id             original_record_id          location
#>       <int>     <int>                          <chr>             <chr>
#> 1      1663         8 Raymond et al. RECORD_ID: 1503 Kerguelen Islands
#> 2       483        12  Raymond et al. RECORD_ID: 316 East of Kerguelen
#> # ... with 60 more variables: west <dbl>, east <dbl>, south <dbl>,
#> #   north <dbl>, depth_min <int>, depth_max <int>, altitude_min <chr>,
#> #   altitude_max <chr>, observation_date_start <dttm>,
#> #   observation_date_end <dttm>, taxon_name <chr>,
#> #   taxon_name_original <chr>, taxon_aphia_id <int>,
#> #   taxon_life_stage <chr>, taxon_breeding_stage <chr>, taxon_sex <chr>,
#> #   taxon_sample_count <int>, taxon_sample_id <int>, taxon_size_min <chr>,
#> #   taxon_size_max <chr>, taxon_size_mean <int>, taxon_size_sd <chr>,
#> #   taxon_size_units <chr>, taxon_size_notes <chr>, taxon_mass_min <chr>,
#> #   taxon_mass_max <chr>, taxon_mass_mean <chr>, taxon_mass_sd <chr>,
#> #   taxon_mass_units <chr>, taxon_mass_notes <chr>, delta_13c_mean <dbl>,
#> #   delta_13c_variability_value <dbl>, delta_13c_variability_type <chr>,
#> #   delta_15n_mean <dbl>, delta_15n_variability_value <dbl>,
#> #   delta_15n_variability_type <chr>, c_n_ratio_mean <dbl>,
#> #   c_n_ratio_variability_value <chr>, c_n_ratio_variability_type <chr>,
#> #   c_n_ratio_type <chr>, isotopes_pretreatment <chr>,
#> #   isotopes_are_adjusted <chr>, isotopes_adjustment_notes <chr>,
#> #   isotopes_carbonates_treatment <chr>, isotopes_lipids_treatment <chr>,
#> #   isotopes_body_part_used <chr>, quality_flag <chr>,
#> #   is_secondary_data <chr>, notes <chr>, last_modified <dttm>,
#> #   taxon_group <chr>, worms_rank <chr>, worms_kingdom <chr>,
#> #   worms_phylum <chr>, worms_class <chr>, worms_order <chr>,
#> #   worms_family <chr>, worms_genus <chr>, source_details <chr>,
#> #   source_doi <chr>
```
