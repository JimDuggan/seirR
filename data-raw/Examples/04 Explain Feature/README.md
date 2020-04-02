Model Assumptions
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

At any point, the current model assumptions can be displayed by calling
the function **explain()**.

In this example, the model is loaded and checked, and then a parameter
is changed, and the model assumptions checked
    again.

``` r
library(seirR)
```

    ## Welcome to package seirR v0.0.0.1

    ## Checking https://covid.ourworldindata.org/data/ecdc/full_data.csv  for data update...

    ## Loading https://covid.ourworldindata.org/data/ecdc/full_data.csv  to global environment data_env

``` r
mod <- create_seir_p()
explain(mod)
```

    ## 
    ## seirR model assumptions
    ## Package seirR Version =  0.1 
    ## Model Class Info =  seir_p seir list

    ## NULL

Change a parameter and call **explain()** again.

``` r
mod <- set_param(mod,"distancing_flag",1)
```
