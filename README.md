---
output:
  html_document: default
  pdf_document: default
---
### seirR 
This package contains a SEIR model to model the spread of an infectious disease. The model is a population-level model. The package is best used in conjunction with R's [tidyverse](https://www.tidyverse.org) tools such as **dplyr** and **ggplot2**.

### Current Version 0.2
This package is currently undergoing testing and has not yet been released. See version history below for a record of changes and version.



### Installation
To install, obtain the authorisation key from the repo owner, and type the following command:

```R
install_github("JimDuggan/seirR",auth="THE_KEY_GOES_HERE")
```

### Model Overview
![](https://github.com/JimDuggan/seirR/blob/master/data-raw/Images/ModelStructure.png)

### Examples
The following are three examples of how to use the model (and data)

- [Running a model](
https://github.com/JimDuggan/seirR/tree/master/data-raw/Examples/01%20Run%20Model)
- [Exploring the data set](
https://github.com/JimDuggan/seirR/tree/master/data-raw/Examples/02%20Explore%20Data)
- [Running a sensitivity analysis](
https://github.com/JimDuggan/seirR/tree/master/data-raw/Examples/03%20Sensitivity)
- [Explain Feature](
https://github.com/JimDuggan/seirR/tree/master/data-raw/Examples/04%20Explain%20Feature)

### Version History
#### Version 0.1
* Release date: April 2nd 2020
* First beta version. Contains a population level SEIR model based on agreed structure. 

#### Version 0.2
* Release date: April 9th 2020
* Added week column to output data frame so that weekly aggergations can be made
* Renamed **explain()** function to **summary()** as **explain()** is already in dplyr
* Changed model workflow so that xmile files can be configured (using package **readsdr**). Model interface is the same, but the workflow for including a new model is speeded up considerable. Main action needed is the all constants in the xmile file must be preceeded by a prefix "ZZ". This allows for the separation of all params into the **sim_state** environment.
* Added a new function **get_curve_analysis()** to detect bheaviour mode changes for any time series
* Reimplemented the simulation results as a "res_seri_p" and res_seir" class (also inherits from tibble)
* Added pulsing logic so that interventions can be switched on and off, to see the impact on infections. This new paramter set can be viewed by typing **summary(mod)**
* Adding functions to process Vensim sesnitivity analysis output

