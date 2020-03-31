library(deSolve)
#-------------------------------------------------------------------------------------
#' The set of ODEs to solve for the model
#'
#' \code{seir_model_a} Solves the ahe cohort model for each timestep, is called by \code{ode}
#' @param time is the current simulation time
#' @param stocks is the vector of model compartments
#' @param auxs vector of auxiliaries (alway NULL) as these are passed via \code{sim_state} environment
#' @return list of new compartment values, and other relevant variables
model_seir_a <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
       states<-matrix(stocks,
                      nrow=sim_state$P_number_age_cohorts)

       colnames(states) <- sim_state$P_stock_names
       rownames(states) <- sim_state$P_cohorts


       browser()
  })
}
