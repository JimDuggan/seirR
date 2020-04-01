library(dplyr)
library(deSolve)
library(lubridate)
library(magrittr)

populate_results <- function(results,return_all,DT){
  results <-  dplyr::mutate(results,Date=sim_state$ActualStartDay+floor(time))
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
  if(!return_all){
    lg <- c(T,rep(F,1/DT-1))
    results <- results[lg,]
  }

  results
}
#-------------------------------------------------------------------------------------
#' Prepares all variables and calls \code{deSolve::ode()}
#'
#' \code{run_seir_model()} runs the simulation, based on the parameter set
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param mod_object are the simulation parameters
#' @param DT is the simulation time step (Euler)
#' @param return_all a flag used to decide how many observations to return
#' @return A tibble of simulation results
run_seir_model <- function (mod_object, DT=0.125,return_all=F){
  # Create a new environment for all the simulation variable
  mod_object_params               <- mod_object$params
  # convert it back to
  class(mod_object_params)        <- c(class(mod_object)[1],"seir","tbl_df","tbl","data.frame")
  sim_state                <<- new.env()
  sim_state$TimeOfRun      <-Sys.time()
  sim_state$ActualStartDay <- (lubridate::ymd(get_param(mod_object_params,"start_day",T)))-
                               data_env$model_offset
  # Copy all the params to this new state
  set_model_parameters(mod_object_params)
  sim_state$params     <- mod_object_params
  sim_state$return_all <- return_all
  sim_state$offset     <- offset
  simtime              <- seq(sim_state$start_time,
                              sim_state$end_time,
                              by=DT)
  sim_state$simtime    <- simtime


  if(class(mod_object)[1]=="seir_p"){
    stocks               <- init_compartments_p()
    results <-data.frame(deSolve::ode(y=stocks,
                       times=simtime,
                       func = model_seir_p,
                       parms=NULL,
                       method="euler"))
  }else if(class(mod_object)[1]=="seir_a"){
    stocks               <- init_compartments_a()
    results <-data.frame(deSolve::ode(y=stocks,
                                      times=simtime,
                                      func = model_seir_a,
                                      parms=NULL,
                                      method="euler"))

  }
  else{
    stop(paste("Unrecognised S3 class ",class(mod_object)))
  }

  results <- populate_results(results,return_all,DT)
  dplyr::as_tibble(results)
}

