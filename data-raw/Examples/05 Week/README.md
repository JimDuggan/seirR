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
    ## 
    ## (1) Initial Conditions
    ## ======================
    ## init_seeds  =  1 
    ## total_population  =  4999974 
    ## init_susceptible  =  4999973 
    ## start_day  =  1 
    ## end_day  =  300 
    ## 
    ## (2) Transmission Parameters
    ## ===========================
    ## beta  =  1.12 
    ## beta_mult_h  =  0.21 
    ## beta_mult_i  =  0.08 
    ## beta_mult_j  =  0.12 
    ## beta_mult_k  =  1 
    ## 
    ## (3) Biological Parameters
    ## ===========================
    ## incubation_period  =  5.19 
    ## latent_period  =  3.55 
    ## infectious_period  =  4.13 
    ## 
    ## (4) Pathway Flow Parameters
    ## ===========================
    ## prop_asymptomatic  =  0.25 
    ## prop_tested  =  0.88 
    ## prop_quarantined  =  0.05 
    ## prop_hospital  =  0 
    ## fraction_hosp_severe  =  0 
    ## fraction_risk_group  =  0 
    ## 
    ## (5) Physcial Distancing Parameters
    ## ==================================
    ## distancing_flag  =  0 
    ## pd_percentage_reduction  =  0.6 
    ## pd_start_time  =  20 
    ## pd_end_time  =  300 
    ## pd_start_delay  =  1 
    ## 
    ## (6) Health System Parameters
    ## ==================================
    ## avr_HLOS  =  15 
    ## avr_results_wait  =  2 
    ## icu_residency  =  10 
    ## icu_capacity  =  250

Change a parameter and call **explain()** again (see parameter
**distancing\_flag** has changed)

``` r
mod <- set_param(mod,"distancing_flag",1)
explain(mod)
```

    ## 
    ## seirR model assumptions
    ## Package seirR Version =  0.1 
    ## Model Class Info =  seir_p seir list 
    ## 
    ## (1) Initial Conditions
    ## ======================
    ## init_seeds  =  1 
    ## total_population  =  4999974 
    ## init_susceptible  =  4999973 
    ## start_day  =  1 
    ## end_day  =  300 
    ## 
    ## (2) Transmission Parameters
    ## ===========================
    ## beta  =  1.12 
    ## beta_mult_h  =  0.21 
    ## beta_mult_i  =  0.08 
    ## beta_mult_j  =  0.12 
    ## beta_mult_k  =  1 
    ## 
    ## (3) Biological Parameters
    ## ===========================
    ## incubation_period  =  5.19 
    ## latent_period  =  3.55 
    ## infectious_period  =  4.13 
    ## 
    ## (4) Pathway Flow Parameters
    ## ===========================
    ## prop_asymptomatic  =  0.25 
    ## prop_tested  =  0.88 
    ## prop_quarantined  =  0.05 
    ## prop_hospital  =  0 
    ## fraction_hosp_severe  =  0 
    ## fraction_risk_group  =  0 
    ## 
    ## (5) Physcial Distancing Parameters
    ## ==================================
    ## distancing_flag  =  1 
    ## pd_percentage_reduction  =  0.6 
    ## pd_start_time  =  20 
    ## pd_end_time  =  300 
    ## pd_start_delay  =  1 
    ## 
    ## (6) Health System Parameters
    ## ==================================
    ## avr_HLOS  =  15 
    ## avr_results_wait  =  2 
    ## icu_residency  =  10 
    ## icu_capacity  =  250
