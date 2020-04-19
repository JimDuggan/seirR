library(dplyr)
library(deSolve)
library(lubridate)
library(magrittr)

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
run_model_seir <- function (mod_object, DT=0.125,return_all=F){
  # Create a new environment for all the simulation variable
  mod_object_params               <- mod_object$params
  # convert it back to
  class(mod_object_params)        <- c(class(mod_object)[1],"seir","tbl_df","tbl","data.frame")
  sim_state                <<- new.env()
  sim_state$TimeOfRun      <-Sys.time()
  sim_state$ActualStartDay <- (lubridate::ymd(get_param(mod_object_params,"start_day",T)))-
                               data_env$model_offset

  # NEED to call specific set_model_params_*** for each separate model
  if(class(mod_object)[1]=="seir_p"){
    set_model_parameters_seir_p(mod_object_params)
  } else if(class(mod_object)[1]=="seir_a"){
    set_model_parameters_seir_a(mod_object_params)
  }else{
    stop(paste("Unrecognised S3 class ",class(mod_object)))
  }

  sim_state$params     <- mod_object_params
  sim_state$return_all <- return_all
  sim_state$mod_offset <- data_env$model_offset
  #simtime              <- seq(sim_state$start_time,
  #                            sim_state$end_time,
  #                            by=DT)
  simtime              <- seq(sim_state$start_day,
                              sim_state$end_day,
                              by=DT)
  sim_state$simtime    <- simtime


  if(class(mod_object)[1]=="seir_p"){
    stocks               <- init_seir_p_compartments()
    results <-data.frame(deSolve::ode(y=stocks,
                       times=simtime,
                       func = model_seir_p,
                       parms=NULL,
                       method="euler"))
  } else if(class(mod_object)[1]=="seir_a"){
    stocks               <- init_seir_a_compartments()
    results <-data.frame(deSolve::ode(y=stocks,
                                      times=simtime,
                                      func = model_seir_a,
                                      parms=NULL,
                                      method="euler"))
  }else{
    stop(paste("Unrecognised S3 class ",class(mod_object)))
  }

  results <- populate_results(mod_object_params,results,return_all,DT)

  class(results) <- c("res_seir", "tbl_df", "tbl",   "data.frame" )


  sim_state$RESULTS <- results


  results
}

