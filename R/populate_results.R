library(dplyr)
library(deSolve)
library(lubridate)

populate_results <- function(results,return_all,DT){
  # assume start day is always day 1
  results <-  dplyr::mutate(results,Date=sim_state$ActualStartDay+(floor(time)-1))
  results <-  dplyr::mutate(results,Week=lubridate::week(Date))
  results <-  dplyr::select(results,Date,dplyr::everything())
  irl_data <- dplyr::filter(data_env$covid_data,Country=="Ireland")
  results <-  dplyr::rename(results,SimDay=time)
  results <-  suppressMessages(dplyr::left_join(results,irl_data))
  results <-  dplyr::select(results,
                            Date,
                            SimDay,
                            Country,
                            ReportedNewCases,
                            ReportedNewDeaths,
                            ReportedTotalCases,
                            ReportedTotalDeaths,
                            dplyr::everything())

  # Remove all the unnamed variables, required due to workaround in deSolve function
  results <- select(results, !matches("^V\\d+"))

  # Need to add all the constants to the results
  constants <- xmile_get_constants()
  for(i in seq_along(constants)){
    varname <- names(constants[i])
    results <- mutate(results,!!varname := constants[i])
  }

  if(!return_all){
    lg <- c(T,rep(F,1/DT-1))
    results <- results[lg,]
  }

  results
}
