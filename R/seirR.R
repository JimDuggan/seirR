#' \code{seirR} package
#'
#' Package to run an SEIR model
#'
#'
#' @docType package
#' @name seirR
NULL

library(dplyr)
library(tibble)

.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to package seirR v0.0.0.9000")
  data_env <<- new.env()
  get_world_data()
  load_social_contacts()
}

#-------------------------------------------------------------------------------------
#' Creates an object to facilitate running the simulation
#'
#' \code{create_seir_p} returns an seir object to the calling program.
#' This object contains a tibble with default parameter, any of which
#' can be modified before the model is rum
#' @return An S3 object of class seir
#' @examples
#' \dontrun{
#' mod <- create_seir()
#' }
create_seir_common <- function (){
  tb <- tibble::tibble(ParameterName=character(),
                       ParameterType=character(),
                       Description=character(),
                       Value=numeric(),
                       UpperEstimate=numeric(),
                       LowerEstimate=numeric(),
                       Varying=logical(),
                       Source=character(),
                       ValueS=character())

  tb <- get_initial_conditions_01(tb)
  tb <- get_transmission_params_02(tb)
  tb <- get_biological_params_03(tb)
  tb <- get_flow_params_04(tb)
  tb <- get_distancing_params_05(tb)
  tb <- get_health_system_params_06(tb)

  tb
}

#-------------------------------------------------------------------------------------
#' Creates an object to facilitate running the simulation
#'
#' \code{create_seir_p} returns a population seir object to the calling program.
#' This object contains a tibble with default parameter, any of which
#' can be modified before the model is rum
#' @return An S3 object of class seir
#' @export
#' @examples
#' \dontrun{
#' mod <- create_seir()
#' }
create_seir_p <- function (){
  tb <- create_seir_common()
  structure(tb, class=c("seir_p","seir", "tbl_df","tbl","data.frame"))
}

#-------------------------------------------------------------------------------------
#' Creates an object to facilitate running the simulation
#'
#' \code{create_seir_a} returns an age cohort seir object to the calling program.
#' This object contains a tibble with default parameter, any of which
#' can be modified before the model is rum
#' @return An S3 object of class seir
#' @export
#' @examples
#' \dontrun{
#' mod <- create_seir()
#' }
create_seir_a <- function (){
  tb <- create_seir_common()
  structure(tb, class=c("seir_a","seir", "tbl_df","tbl","data.frame"))
}


#-------------------------------------------------------------------------------------
#' Runs a model
#'
#' \code{run()} runs the simulation, based on the parameter set
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param o is the seir S3 object
#' @param start is thesimulation start time
#' @param finish is the simulation finish time
#' @param DT is the simulation time step (Euler)
#' @param return_all a flag used to decide how many observations to return
#' @param offset is the simulation offset time
#' @return A tibble of simulation results
#' @export
#' @examples
#'\dontrun{
#' m <- create_seir()
#' o <- run(m)
#' }
run <- function(o,start=0, finish=300, DT=0.125,return_all = F, mod_offset=0){
  UseMethod("run")
}

#' @export
run.seir <- function(o,start=0, finish=300, DT=0.125,return_all = F, mod_offset=0){
  run_seir_model(o,start, finish,DT,return_all,mod_offset)
  # for the result, return the timestamp as a unique identifer.
  # Sys.time()
}

#-------------------------------------------------------------------------------------
#' Sets a parameter value
#'
#' \code{set_param()} runs the simulation, based on the parameter set
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param o is the seir S3 object
#' @param p is the parameter name
#' @param v is the new value for the parameter
#' @param isString to indicate if its a string param.
#' @return A tibble of simulation results
#' @export
#' @examples
#'\dontrun{
#' m <- create_seir()
#' o <- run(m)
#' }
set_param <- function(o, p, v, isString=F){
  UseMethod("set_param")
}

#' @export
set_param.seir <- function(o, p, v, isString=F){
  if(!isString){
     o[o$ParameterName==p,"Value"] <- v
  }else{
    o[o$ParameterName==p,"ValueS"] <- v
  }
  o
}

#-------------------------------------------------------------------------------------
#' Gets a parameter value
#'
#' \code{get_param()} runs the simulation, based on the parameter set
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param o is the seir S3 object
#' @param p is the parameter name
#' @param isString used one parameter that is a string (start date)
#' @return The parameter value
#' @export
get_param <- function(o, p, isString=F){
  UseMethod("get_param")
}

#' @export
get_param.seir <- function(o, p, isString=F){
  if(!isString){
     dplyr::pull(o[o$ParameterName==p,"Value"])
  }else{
    dplyr::pull(o[o$ParameterName==p,"ValueS"])
  }
}

