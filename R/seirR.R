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
library(lubridate)

.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to package seirR v0.2")
  get_world_data()
}

create_simtime_tibble <- function(mod, mod_offset=0){
  mod_object_params         <- mod$params
  class(mod_object_params)  <- c(class(mod)[1],"seir","tbl_df","tbl","data.frame")
  actual_start_date         <- (lubridate::ymd(get_param(mod_object_params,"start_day",T))) - mod_offset
  start_day                 <- get_param(mod_object_params,"start_day")
  end_day                   <- get_param(mod_object_params,"end_day")
  data_env$model_offset     <- mod_offset
  col_simtime               <- start_day:end_day
  col_date                  <- actual_start_date + (col_simtime - 1)
  simtime_map               <- dplyr::tibble (SimTime=col_simtime,
                                       Date=col_date)
  simtime_map
}

#-------------------------------------------------------------------------------------
#' Creates an object to facilitate running the simulation
#'
#' \code{create_seir_p} returns a population seir object to the calling program.
#' This object contains a tibble with default parameter, any of which
#' can be modified before the model is run
#' @param model_offset the offset for the model (subtracted from start time)
#' @return An S3 object of class seir
#' @export
#' @examples
#' \dontrun{
#' mod <- create_seir_p()
#' }
create_seir_p <- function (model_offset = 0){
  #tb      <- create_seir_common()
  tb      <- xmile_setup_parameters()
  polymod <- load_social_contacts()
  lst <- list(params=tb,       # The main parameters
              #pulse="TBD",     # Pulse information for social distancing
              sim_date="TBD",   # Lookup table to translate from sim time to dates
              POLYMOD=polymod)
  mod <- structure(lst, class=c("seir_p","seir", "list"))
  # Add the sim_date tibble
  mod$sim_date <-create_simtime_tibble(mod, model_offset)
  mod$package_version  <- packageVersion("seirR")
  mod$type  <- "SEIR Population Model"
  mod
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
  polymod <- load_social_contacts()
  lst <- list(params=tb,       # The main parameters
              #pulse="TBD",     # Pulse information for social distancing
              sim_date="TBD",   # Lookup table to translate from sim time to dates
              POLYMOD=polymod)
  mod <- structure(lst, class=c("seir_a","seir", "list"))
  mod$sim_date <-create_simtime_tibble(mod, model_offset)
  mod
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
#' @param DT is the simulation time step (Euler)
#' @param return_all a flag used to decide how many observations to return
#' @return A tibble of simulation results
#' @export
#' @examples
#'\dontrun{
#' m <- create_seir()
#' o <- run(m)
#' }
run <- function(o,DT=0.125,return_all = F){
  UseMethod("run")
}

#' @export
run.seir <- function(o,DT=0.125,return_all = F){
  #run_seir_model(o,DT,return_all)
  if(class(o)[1]=="seir_p"){
      run_model_seir_p(o,DT,return_all)
  }
  else{
    cat("Unrecognised model object ",class(o)[1],"\n")
  }
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
#' @param checkStr check the match
#' @return A tibble of simulation results
#' @export
#' @examples
#'\dontrun{
#' m <- create_seir()
#' o <- run(m)
#' }
set_param <- function(o, p, v, isString=F, checkStr=F){
  UseMethod("set_param")
}

#' @export
set_param.seir <- function(o, p, v, isString=F,checkStr=F){
  class_o <- class(o)
  o_params <- o[["params"]]

  if(checkStr){
    v1 <- paste0("Input param:",p,":\n")
    v2 <- paste0("Lookup param:",o_params[o_params$ParameterName==p,"Value"],":\n")
    cat(v1)
    cat(v2)
  }

  if(!isString){
     o_params[o_params$ParameterName==p,"Value"] <- v
  }else{
    o_params[o_params$ParameterName==p,"ValueS"] <- v
  }
  o[["params"]] <- o_params
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
  o_params <- o
  if(!isString){
     dplyr::pull(o_params[o$ParameterName==p,"Value"])
  }else{
    dplyr::pull(o[o_params$ParameterName==p,"ValueS"])
  }
}

#-------------------------------------------------------------------------------------
#' Gets a parameter value
#'
#' \code{params()} returns the parameters
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param o is the seir S3 object
#' @return The parameter value
#' @export
params <- function(o){
  UseMethod("params")
}
#' @export
params.seir <- function(o){
  print(o[["params"]])
}

#-------------------------------------------------------------------------------------
#' Explains the current model assumptions
#'
#' \code{summary()} summarises the model
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param object is the seir S3 object
#' @param ... are additional params
#' @export
summary.seir <- function(object,...){
  o <- object
  cat("\n")
  cat("seirR model assumptions\n")
  cat("Package seirR Version = ", as.character(packageVersion("seirR")),"\n")
  cat("Model Class Info = ", as.character(class(o)),"\n")
  cat("\n")

  counter <- 1

  target <- data.frame(dplyr::filter(o$params,ParameterType=="InitialCondition"))
  if(nrow(target)>0){
    cat(paste0("(",counter,")"),"Initial Conditions\n")
    cat("======================\n")
    invisible(sapply(1:nrow(target),function(row){
       cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
           colourise(target[row,"Description"],"red"),"\n");
       if(target[row,"ParameterName"] == "start_day"){
         cat(target[row,"ParameterName"]," = ",target[row,"ValueS"],"\n");
     }
     }))
    counter<-counter+1
  }


  target <- data.frame(dplyr::filter(o$params,ParameterType=="Transmission"))
  if(nrow(target)>0){
    cat("\n")
    cat(paste0("(",counter,")"),"Transmission Parameters\n")
    cat("===========================\n")
    invisible(sapply(1:nrow(target),function(row){
      cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
          colourise(target[row,"Description"],"red"),"\n");
      }))
    counter<-counter+1
  }

  target <- data.frame(dplyr::filter(o$params,ParameterType=="Biological"))
  if(nrow(target)>0){
    cat("\n")
    cat(paste0("(",counter,")"),"Biological Parameters\n")
    cat("=========================\n")
    invisible(sapply(1:nrow(target),function(row){
      cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
          colourise(target[row,"Description"],"red"),"\n");
    }))
    counter<-counter+1
  }

  target <- data.frame(dplyr::filter(o$params,ParameterType=="Pathway"))
  if(nrow(target)>0){
    cat("\n")
    cat(paste0("(",counter,")"),"Pathway Flow Parameters\n")
    cat("===========================\n")
    invisible(sapply(1:nrow(target),function(row){
      cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
          colourise(target[row,"Description"],"red"),"\n");
    }))
    counter<-counter+1
  }


  target <- data.frame(dplyr::filter(o$params,ParameterType=="Distancing"))
  if(nrow(target)>0){
    cat("\n")
    cat(paste0("(",counter,")"),"Physical Distancing Parameters\n")
    cat("==================================\n")
    invisible(sapply(1:nrow(target),function(row){
      cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
          colourise(target[row,"Description"],"red"),"\n");
    }))
    counter<-counter+1
  }

  target <- data.frame(dplyr::filter(o$params,ParameterType=="HealthSystem"))
  if(nrow(target)>0){
    cat("\n")
    cat(paste0("(",counter,")"),"Health System Parameters\n")
    cat("============================\n")
    invisible(sapply(1:nrow(target),function(row){
      cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
          colourise(target[row,"Description"],"red"),"\n");
    }))
    counter<-counter+1
  }


  target <- data.frame(dplyr::filter(o$params,ParameterType=="Pulse"))
  if(nrow(target)>0){
    cat("\n")
    cat(paste0("(",counter,")"),"Pulse Policy Parameters\n")
    cat("===========================\n")
    invisible(sapply(1:nrow(target),function(row){
      cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
          colourise(target[row,"Description"],"red"),"\n");
    }))
    counter<-counter+1
  }


  target <- data.frame(dplyr::filter(o$params,ParameterType=="Model"))
  if(nrow(target)>0){
    cat("\n")
    cat(paste0("(",counter,")"),"Additional Model Parameters\n")
    cat("===============================\n")
    invisible(sapply(1:nrow(target),function(row){
      cat(target[row,"ParameterName"]," = ",target[row,"Value"],"\t\t => ",
          colourise(target[row,"Description"],"red"),"\n");
    }))
    counter<-counter+1
  }


}


