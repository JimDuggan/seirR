Running a model
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

In order to run a model, the following steps should be taken.

  - First, load in the libraries, and include **ggplot2** for
    visualisation

<!-- end list -->

``` r
library(seirR)
```

    ## Welcome to package seirR v0.0.0.1

    ## Checking https://covid.ourworldindata.org/data/ecdc/full_data.csv  for data update...

    ## Loading https://covid.ourworldindata.org/data/ecdc/full_data.csv  to global environment data_env

``` r
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following object is masked from 'package:seirR':
    ## 
    ##     explain

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

  - Next, call the constructor to create an S3 model object

<!-- end list -->

``` r
mod <- create_seir_p()
```

The **mod** variable has the following S3 structure.

``` r
class(mod) 
```

    ## [1] "seir_p" "seir"   "list"

The **mod** variable has three list elements, as follows:

``` r
str(mod) 
```

    ## List of 4
    ##  $ params  :Classes 'tbl_df', 'tbl' and 'data.frame':    28 obs. of  9 variables:
    ##   ..$ ParameterName: chr [1:28] "init_seeds" "total_population" "init_susceptible" "start_day" ...
    ##   ..$ ParameterType: chr [1:28] "InitialCondition" "InitialCondition" "InitialCondition" "InitialCondition" ...
    ##   ..$ Description  : chr [1:28] "The initial number of people infected" "Total number of people in all compartments" "Initial number susceptible" "Start day of epidemic, see variable ValueS" ...
    ##   ..$ Value        : num [1:28] 1e+00 5e+06 5e+06 1e+00 3e+02 ...
    ##   ..$ UpperEstimate: num [1:28] 1e+00 5e+06 5e+06 0e+00 0e+00 ...
    ##   ..$ LowerEstimate: num [1:28] 1e+00 5e+06 5e+06 0e+00 0e+00 ...
    ##   ..$ Varying      : logi [1:28] FALSE FALSE FALSE FALSE FALSE FALSE ...
    ##   ..$ Source       : chr [1:28] "Use for data calibration process" "National Statistics" "Arbitrary value" "Depends on country" ...
    ##   ..$ ValueS       : chr [1:28] NA NA NA "2020-02-29" ...
    ##  $ pulse   : chr "TBD"
    ##  $ sim_date:Classes 'tbl_df', 'tbl' and 'data.frame':    300 obs. of  2 variables:
    ##   ..$ SimTime: int [1:300] 1 2 3 4 5 6 7 8 9 10 ...
    ##   ..$ Date   : Date[1:300], format: "2020-02-29" ...
    ##  $ POLYMOD :List of 3
    ##   ..$ matrix      : num [1:4, 1:4] 1.916 0.624 0.494 0.145 1.243 ...
    ##   .. ..- attr(*, "dimnames")=List of 2
    ##   .. .. ..$                  : NULL
    ##   .. .. ..$ contact.age.group: chr [1:4] "[0,5)" "[5,15)" "[15,65)" "65+"
    ##   ..$ demography  :Classes 'data.table' and 'data.frame':    4 obs. of  3 variables:
    ##   .. ..$ lower.age.limit: num [1:4] 0 5 15 65
    ##   .. ..$ population     : num [1:4] 351883 700216 3220526 727349
    ##   .. ..$ upper.age.limit: num [1:4] 5 15 65 80
    ##   .. ..- attr(*, ".internal.selfref")=<externalptr> 
    ##   .. ..- attr(*, "sorted")= chr "lower.age.limit"
    ##   ..$ participants:Classes 'data.table' and 'data.frame':    4 obs. of  3 variables:
    ##   .. ..$ age.group   : chr [1:4] "[0,5)" "[5,15)" "[15,65)" "65+"
    ##   .. ..$ participants: int [1:4] 95 204 656 56
    ##   .. ..$ proportion  : num [1:4] 0.094 0.2018 0.6489 0.0554
    ##   .. ..- attr(*, ".internal.selfref")=<externalptr> 
    ##  - attr(*, "class")= chr [1:3] "seir_p" "seir" "list"

The first is a tibble with the parameters for the simulation run.

``` r
mod$params
```

    ## # A tibble: 28 x 9
    ##    ParameterName ParameterType Description   Value UpperEstimate
    ##    <chr>         <chr>         <chr>         <dbl>         <dbl>
    ##  1 init_seeds    InitialCondi… The initia… 1.00e+0        1     
    ##  2 total_popula… InitialCondi… Total numb… 5.00e+6  4999974     
    ##  3 init_suscept… InitialCondi… Initial nu… 5.00e+6  4999973     
    ##  4 start_day     InitialCondi… Start day … 1.00e+0        0     
    ##  5 end_day       InitialCondi… End day of… 3.00e+2        0     
    ##  6 beta          Transmission  Transmissi… 1.12e+0        1.04  
    ##  7 beta_mult_h   Transmission  Multiplica… 2.10e-1        0.75  
    ##  8 beta_mult_i   Transmission  Multiplica… 8.00e-2        0.0101
    ##  9 beta_mult_j   Transmission  Multiplica… 1.20e-1        0.177 
    ## 10 beta_mult_k   Transmission  Multiplica… 1.00e+0        1     
    ## # … with 18 more rows, and 4 more variables: LowerEstimate <dbl>,
    ## #   Varying <lgl>, Source <chr>, ValueS <chr>

The second will contain information on pulse policies that can be
activated/deactivated.

``` r
mod$pulse
```

    ## [1] "TBD"

The third contains a mapping from the simulation time to the calendar
date

``` r
mod$sim_date
```

    ## # A tibble: 300 x 2
    ##    SimTime Date      
    ##      <int> <date>    
    ##  1       1 2020-02-29
    ##  2       2 2020-03-01
    ##  3       3 2020-03-02
    ##  4       4 2020-03-03
    ##  5       5 2020-03-04
    ##  6       6 2020-03-05
    ##  7       7 2020-03-06
    ##  8       8 2020-03-07
    ##  9       9 2020-03-08
    ## 10      10 2020-03-09
    ## # … with 290 more rows

The third contains a mapping fof contacts based on the polymod study

``` r
mod$POLYMOD
```

    ## $matrix
    ##       contact.age.group
    ##            [0,5)    [5,15)  [15,65)       65+
    ##   [1,] 1.9157895 1.2425307 4.516886 0.3003448
    ##   [2,] 0.6244151 7.9460784 6.048153 0.5063152
    ##   [3,] 0.4935266 1.3150068 9.169207 0.9526663
    ##   [4,] 0.1453033 0.4874277 4.218177 1.7142857
    ## 
    ## $demography
    ##    lower.age.limit population upper.age.limit
    ## 1:               0     351883               5
    ## 2:               5     700216              15
    ## 3:              15    3220526              65
    ## 4:              65     727349              80
    ## 
    ## $participants
    ##    age.group participants proportion
    ## 1:     [0,5)           95 0.09396637
    ## 2:    [5,15)          204 0.20178042
    ## 3:   [15,65)          656 0.64886251
    ## 4:       65+           56 0.05539070

  - A model can then be run based on the **mod** object by calling the
    function **run()** In this example, we run the model twice, and
    alter a parmeter using the **set\_params()** function

<!-- end list -->

``` r
out1 <- run(mod)
mod <- set_param(mod,"distancing_flag",1)
out2 <- run(mod)
```

The output from these models is a tibble, containing a good deal of
simulation information.

``` r
glimpse(out1)
```

    ## Observations: 300
    ## Variables: 60
    ## $ Date                                        <date> 2020-03-01, 2020-03…
    ## $ SimDay                                      <dbl> 1, 2, 3, 4, 5, 6, 7,…
    ## $ Country                                     <chr> "Ireland", "Ireland"…
    ## $ ReportedNewCases                            <dbl> 1, 0, NA, 1, 4, 7, 5…
    ## $ ReportedNewDeaths                           <dbl> 0, 0, NA, 0, 0, 0, 0…
    ## $ ReportedTotalCases                          <dbl> 1, 1, NA, 2, 6, 13, …
    ## $ ReportedTotalDeaths                         <dbl> 0, 0, NA, 0, 0, 0, 0…
    ## $ AsymptomaticInfected01                      <dbl> 0.00000000, 0.068471…
    ## $ AsymptomaticInfected02                      <dbl> 0.00000000, 0.016656…
    ## $ AwaitingResults01                           <dbl> 0.0000000, 0.1983170…
    ## $ AwaitingResults02                           <dbl> 0.00000000, 0.027947…
    ## $ CumulativeImmediateIsolation                <dbl> 0.00000000, 0.013172…
    ## $ CumulativeInfectiousAsymptomatic            <dbl> 0.00000000, 0.087814…
    ## $ CumulativeNotQuarantined                    <dbl> 0.00000000, 0.018441…
    ## $ CumulativeModelInfected                     <dbl> 0.000000, 1.090863, …
    ## $ CumulativeTestIncidence                     <dbl> 0.00000000, 0.033512…
    ## $ CumulativeTestsPositive                     <dbl> 0.0000000, 0.2318298…
    ## $ ExpectedICUExits                            <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ Exposed01                                   <dbl> 0.0000000, 0.8532268…
    ## $ Exposed02                                   <dbl> 0.0000000, 0.2052171…
    ## $ InHospital01                                <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ InHospital02                                <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ InHospital03                                <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ InHospitalSevere                            <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ InfectedPresymptomatic01                    <dbl> 1.0000000, 0.2928923…
    ## $ InfectedPresymptomatic02                    <dbl> 0.0000000, 0.3882697…
    ## $ NotQuarantineInfectious01                   <dbl> 0.00000000, 0.014378…
    ## $ NotQuarantineInfectious02                   <dbl> 0.000000000, 0.00349…
    ## $ PhysicalDistancingSmoothedValue             <dbl> 1.0000000, 1.0000000…
    ## $ RemovedAsymptomatic                         <dbl> 0.000000000, 0.00268…
    ## $ RemovedAwaitingResults                      <dbl> 0.000000e+00, 5.5650…
    ## $ RemovedHospital                             <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ RemovedNotQuarantine                        <dbl> 0.000000e+00, 5.6420…
    ## $ RemovedSevereCasesHospital                  <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ RemovedSevereCasesICU                       <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ RemovedSymptomaticImmediateIsolation        <dbl> 0.0000000000, 0.0004…
    ## $ SevereCasesHospital01                       <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ SevereCasesHospital02                       <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ SevereCasesICU01                            <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ SevereCasesICU02                            <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ Susceptible                                 <dbl> 4999973, 4999972, 49…
    ## $ SymptomaticImmediateIsolation01             <dbl> 0.00000000, 0.010270…
    ## $ SymptomaticImmediateIsolation02             <dbl> 0.000000000, 0.00249…
    ## $ EffectofPhysicalDistancingonBeta            <dbl> 1, 1, 1, 1, 1, 1, 1,…
    ## $ PhysicalDistancingFractionalReductionAmount <dbl> 1.0, 1.0, 1.0, 1.0, …
    ## $ CheckSumPopulation                          <dbl> 4999974, 4999974, 49…
    ## $ Beta                                        <dbl> 1.12, 1.12, 1.12, 1.…
    ## $ Beta_h                                      <dbl> 0.21, 0.21, 0.21, 0.…
    ## $ Beta_i                                      <dbl> 0.08, 0.08, 0.08, 0.…
    ## $ Beta_j                                      <dbl> 0.12, 0.12, 0.12, 0.…
    ## $ Beta_k                                      <dbl> 1, 1, 1, 1, 1, 1, 1,…
    ## $ Lambda                                      <dbl> 2.240012e-07, 2.0599…
    ## $ IR                                          <dbl> 1.120000, 1.029960, …
    ## $ TotalExposed                                <dbl> 0.000000, 1.058444, …
    ## $ TotalInfectious                             <dbl> 1.000000, 1.023200, …
    ## $ TotalRemoved                                <dbl> 0.000000e+00, 9.2188…
    ## $ TotalSevereinNonICUHospital                 <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ TotalSevereinICU                            <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ V53                                         <dbl> 0, 0, 0, 0, 0, 0, 0,…
    ## $ ReportedIncidence                           <dbl> 0.00000000, 0.099158…

Any of these variables can then be
printed.

``` r
ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=ReportedIncidence),colour="red")+
  geom_line(out2,mapping=aes(x=SimDay,y=ReportedIncidence),colour="blue")
```

![](README_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->