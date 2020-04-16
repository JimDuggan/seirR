library(dplyr)
library(tibble)
library(readr)
library(RCurl)

#-------------------------------------------------------------------------------------
#' Gets the latest world covid data
#'
#' \code{get_world_data} creates a tibble in the data_env
#' @return tibble of class seir
get_world_data <- function(){
  url_data <-"https://covid.ourworldindata.org/data/ecdc/full_data.csv"
  if(RCurl::url.exists(url_data)){
    packageStartupMessage(paste("Loading",url_data," to global environment data_env"))
    suppressMessages(data_env$covid_data <<- readr::read_csv(url_data))
    data_env$covid_data <<- dplyr::rename(data_env$covid_data,
                                         Date=date,
                                         Country=location,
                                         ReportedNewCases=new_cases,
                                         ReportedNewDeaths=new_deaths,
                                         ReportedTotalCases=total_cases,
                                         ReportedTotalDeaths=total_deaths)
    data_env$DATA <<- TRUE
  }
}
