Sensitivity runs
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

The model can be run a number of times to support sensitivity analysis.
Here, the package **purrr** is used to generate a large output data set
(which is essentially a collation of all the individual runs, with a new
ID added to the table so that the primary key is {RunNumber, SimDay})

  - First, load in the
    libraries.

<!-- end list -->

``` r
library(seirR)
```

    ## Welcome to package seirR v0.0.0.1

    ## Checking https://covid.ourworldindata.org/data/ecdc/full_data.csv  for data update...

    ## Loading https://covid.ourworldindata.org/data/ecdc/full_data.csv  to global environment data_env

``` r
library(ggplot2)
library(purrr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

  - Create the model, and set the physical distancing option

<!-- end list -->

``` r
mod <- create_seir_p()
mod <- set_param(mod,"distancing_flag",1)
```

  - Set the sensitivity parameter ranges, and the number of runs.
    Packages such as FME can be used for this, as it supports a wider
    range of random number generations.
    <https://cran.r-project.org/web/packages/FME/index.html>

<!-- end list -->

``` r
NRUNS <- 10

lower <- 0.2
upper <- 0.8
percentages    <- runif(NRUNS,.1,.9)
f_asymptomatic <- runif(NRUNS,.15,.7)
```

  - Write a script to run the model a number of times, sampling from the
    random number streams

<!-- end list -->

``` r
res_full <- map_df(1:NRUNS, function(i){
  cat("iteration = ", i, "with percentage = ", percentages[i], " and f = ",f_asymptomatic[i],"\n")
  mod <- set_param(mod,"pd_percentage_reduction",percentages[i])
  mod <- set_param(mod,"prop_asymptomatic",f_asymptomatic[i])
  out2 <- run(mod) %>% mutate(RunNumber=i) %>%
     select(RunNumber,everything())
})
```

    ## iteration =  1 with percentage =  0.8111302  and f =  0.3321293 
    ## iteration =  2 with percentage =  0.4644677  and f =  0.4446931 
    ## iteration =  3 with percentage =  0.3347722  and f =  0.3529519 
    ## iteration =  4 with percentage =  0.4061768  and f =  0.2417666 
    ## iteration =  5 with percentage =  0.4969444  and f =  0.5376675 
    ## iteration =  6 with percentage =  0.8439628  and f =  0.5359147 
    ## iteration =  7 with percentage =  0.3664564  and f =  0.6817857 
    ## iteration =  8 with percentage =  0.4916832  and f =  0.3351411 
    ## iteration =  9 with percentage =  0.1317865  and f =  0.4474065 
    ## iteration =  10 with percentage =  0.8494628  and f =  0.3585277

  - Show all the results for one of the
variable

<!-- end list -->

``` r
ggplot(res_full,aes(x=Date,y=ReportedIncidence,colour=RunNumber,group=RunNumber))+geom_path()+
       scale_colour_gradientn(colours=rainbow(12))+guides(color=FALSE)
```

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->
