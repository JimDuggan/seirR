#-------------------------------------------------------------------------------------
#' Creates the initial state vector for population ODE
#'
#' @return A vector of compartments and their initial conditions
init_compartments_a <- function(){
  # Populate in Alphabetical Order

  sim_state$CompartmentsINIT <- c(Susceptible_Age_00_04=0,
                                  Susceptible_Age_05_14=0,
                                  Susceptible_Age_15_65=0,
                                  Susceptible_Age_65_PLUS=0,
                                  Exposed_Age_00_04=0,
                                  Exposed_Age_05_14=0,
                                  Exposed_Age_15_65=0,
                                  Exposed_Age_65_PLUS=0)
}
