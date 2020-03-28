library(dplyr)
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to package seirR.")
}

get_initial_conditions_01<-function(tb){
  tb <- add_row(tb,
                ParameterName="init_seeds",
                ParameterType="InitialCondition",
                Description="The initial number of people infected",
                Value=1,
                Source="Use for data calibration process");
  tb <- add_row(tb,
                ParameterName="total_population",
                ParameterType="InitialCondition",
                Description="Total number of people in all compartments",
                Value=4800000,
                Source="National Statistics")
  tb <- add_row(tb,
                ParameterName="init_susceptible",
                ParameterType="InitialCondition",
                Description="Initial number susceptible",
                Value=4800000-1,
                Source="Arbitrary value")
  tb
}

get_transmission_params_02<-function(tb){
  tb <- add_row(tb,
                ParameterName="beta",
                ParameterType="Transmission",
                Description="Transmission parameter",
                Value=1.04138,
                Source="Calibration of Irish Data");
  tb <- add_row(tb,
                ParameterName="beta_mult_h",
                ParameterType="Transmission",
                Description="Multiplicative factor for reduction in infectiousness of asymptomatic infected",
                Value=0.507091,
                Source="Calibration of Irish Data")
  tb <- add_row(tb,
                ParameterName="beta_mult_i",
                ParameterType="Transmission",
                Description="Multiplicative factor for reduction in infectiousness of those in isolation",
                Value=0.0101439,
                Source="Calibration of Irish Data")
  tb <- add_row(tb,
                ParameterName="beta_mult_j",
                ParameterType="Transmission",
                Description="Multiplicative factor for reduction in infectiousness of those solated after test",
                Value=0.177054,
                Source="Arbitrary")
  tb <- add_row(tb,
                ParameterName="beta_mult_k",
                ParameterType="Transmission",
                Description="Multiplicative factor for those asymptomatic who may isolate",
                Value=1.0,
                Source="Speculative at time of model design")
  tb

}

#-------------------------------------------------------------------------------------
#' Creates an object to facilitate running the simulation
#'
#' \code{create_seir} returns an seir object to the calling program.
#' This object contains a tibble with default parameter, any of which
#' can be modified before the model is rum
#' @return An S3 object of class seir
#' @export
#' @examples
#' \dontrun{
#' mod <- create_seir()
#' }
create_seir <- function (){
  tb <- tibble(ParameterName=character(),
               ParameterType=character(),
               Description=character(),
               Value=numeric(),
               Source=character())

  tb <- get_initial_conditions_01(tb)
  tb <- get_transmission_params_02(tb)

  structure(tb, class=c("seir","tbl_df","tbl","data.frame"))
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
#' @return A tibble of simulation results
#' @export
#' @examples
#'\dontrun{
#' m <- create_seir()
#' o <- run(m)
#' }
run <- function(o){
  UseMethod("run")
}

#' @export
run.seir <- function(o){
  head(o)
}
#-------------------------------------------------------------------------------------
#' Sets a parameter
#'
#' \code{run()} runs the simulation, based on the parameter set
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param o is the seir S3 object
#' @return A tibble of simulation results
#' @export
#' @examples
#'\dontrun{
#' m <- create_seir()
#' o <- run(m)
#' }
set_param <- function(o, p, v){
  UseMethod("set_param")
}

#' @export
set_param.seir <- function(o, p, v){
  o[o$ParameterName==p,"Value"] <- v
  o
}
