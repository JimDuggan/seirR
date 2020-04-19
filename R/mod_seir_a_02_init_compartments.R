#-------------------------------------------------------------------------------------
#' Creates the initial state vector for population ODE
#
#' @return A vector of compartments and their initial conditions
init_seir_a_compartments <- function(){
sim_state$CompartmentsINIT <-c( CumulativeCases = 0 ,
	  Exposed_01 = 0 ,
	  Exposed_02 = 0 ,
	  Infected_Reporting_in_Progress = 0 ,
	  Infectious_Asymptomatic_01 = 0 ,
	  Infectious_Asymptomatic_02 = 0 ,
	  Infectious_Presymptomatic_01 = 1 ,
	  Infectious_Presymptomatic_02 = 0 ,
	  Infectious_Symptomatic_01 = 0 ,
	  Infectious_Symptomatic_02 = 0 ,
	  Removed = 0 ,
	  Susceptible = 4999969 )
}

