Exploring Parameters
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

Parameters can be explored in the model. There are a number of
categories, see below for their descriptions, and default values. These
can be set and retrieved using the functions
**set\_params(mod,param,value)** and **get\_params(mod,param)**

  - First, load in the libraries

<!-- end list -->

``` r
library(seirR)
library(dplyr)
```

  - Next, call the constructor to create an S3 model object

<!-- end list -->

``` r
mod <- create_seir_p()
```

  - **(1) Initial
conditions**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="InitialCondition") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 4 x 3
    ##   ParameterName      Value Description                                     
    ##   <chr>              <dbl> <chr>                                           
    ## 1 Number_Seeds           1 Initial number of infectious people in the popu…
    ## 2 Total_Population 4999970 Total population (people)                       
    ## 3 start_day              1 Start day of epidemic, see variable ValueS      
    ## 4 end_day              300 End day of epidemic, see variable ValueS

  - **(2)
Transmission**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="Transmission") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 7 x 3
    ##   ParameterName     Value Description                                      
    ##   <chr>             <dbl> <chr>                                            
    ## 1 Beta_Calibrated  0.91   Estomated effective contact rate (1/day)         
    ## 2 Beta_Multiplier… 0.11   Effective contact rate multiplier for asymptomat…
    ## 3 Beta_Multiplier… 0.07   Effective contact rate multiplier for those in i…
    ## 4 Beta_Multiplier… 0.0612 Effective contact rate multiplier for those awai…
    ## 5 Beta_Multiplier… 1      Additional self-quarantine multiplier for asympt…
    ## 6 R0_Fixed_Flag    1      Flag (0|1) that will fix R0 for the simulation   
    ## 7 R0_Input         3.67   If R0_Fixed_Flag is set to 1, this value of R0 w…

  - **(3)
Biological**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="Biological") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 3 x 3
    ##   ParameterName           Value Description                                
    ##   <chr>                   <dbl> <chr>                                      
    ## 1 Incubation_Period_C      5.79 Average incubation period, includes infect…
    ## 2 Latent_Period_L          3.58 Average latent time (not infectious)       
    ## 3 Total_Infectious_Perio…  5.46 Total infectious period for disease (days)

  - **(4)
Pathway**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="Pathway") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 5 x 3
    ##   ParameterName         Value Description                                  
    ##   <chr>                 <dbl> <chr>                                        
    ## 1 Fraction_in_Risk_Gro…  0    Fraction of those hospitalised who are at ri…
    ## 2 Proportion_Asymptoma…  0.25 Proportion of the population who are asympto…
    ## 3 Proportion_Hospitali…  0    Proportion of the population who are hospita…
    ## 4 Proportion_Quarantin…  0.21 Proportion of the population who are quarant…
    ## 5 Proportion_Tested_t    0.55 Proportion of the population who are tested

  - **(5)
Distancing**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="Distancing") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 4 x 3
    ##   ParameterName                 Value Description                          
    ##   <chr>                         <dbl> <chr>                                
    ## 1 Distancing_Start_Time          20   When physical distancing is started  
    ## 2 Distancing_Switch               0   A flag that switches on the physcial…
    ## 3 PDAT                            4   Time lag before distancing measures …
    ## 4 Percentage_Reduction_of_Phys…   0.6 Percentage reduction in transmission…

  - **(6) Health
System**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="HealthSystem") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 5 x 3
    ##   ParameterName           Value Description                                
    ##   <chr>                   <dbl> <chr>                                      
    ## 1 Average_HLOS            15    Average length of stay in hospital (days)  
    ## 2 Average_Wait_for_Resu…   3.16 Average wait for test results (days)       
    ## 3 Fraction_In_Hospital_…   0    Fraction of those entering hospital who be…
    ## 4 ICU_Available_Capacity 250    Available ICU capacity (people)            
    ## 5 ICU_Residency_Time      10    Average residencu time in ICU (day)

  - **(7) Health
System**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="Pulse") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 5 x 3
    ##   ParameterName     Value Description                                      
    ##   <chr>             <dbl> <chr>                                            
    ## 1 Pulse_Duration       21 The duration of the pulse intervention (relaxati…
    ## 2 Pulse_End           300 End of pulse policy                              
    ## 3 Pulse_Off_Durati…    10 Duration of time in between pulses               
    ## 4 Pulse_Switch          0 Activate/deactive the pulse policy               
    ## 5 Switch_Time         200 The time to switch to the pulse policy

  - **(8)
Model**

<!-- end list -->

``` r
mod$params %>% filter(ParameterType=="Model") %>% select(ParameterName,Value,Description)
```

    ## # A tibble: 3 x 3
    ##   ParameterName Value Description                                     
    ##   <chr>         <dbl> <chr>                                           
    ## 1 AT                1 Adjustment time for ICU exits                   
    ## 2 Lag_Time          1 Amount of time to make ICU space available (day)
    ## 3 RTime_Severe      1 Time before developing severe symptoms
