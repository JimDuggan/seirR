#-------------------------------------------------------------------------------------
#' Creates the initial state vector for population ODE
#
#' @return A vector of compartments and their initial conditions
init_compartments_p_xmile <- function(){
sim_state$CompartmentsINIT <-c( Asymptomatic_Infected_01 = 0 ,
	  Asymptomatic_Infected_02 = 0 ,
	  Awaiting_Results_01 = 0 ,
	  Awaiting_Results_02 = 0 ,
	  Cumulative_Immediate_Isolation = 0 ,
	  Cumulative_Infectious_Asymptomatic = 0 ,
	  Cumulative_Model_Infected = 0 ,
	  Cumulative_Not_Quarantined = 0 ,
	  Cumulative_Test_Incidence = 0 ,
	  Cumulative_Tests_Positive = 0 ,
	  Expected_ICU_Exits = 0 ,
	  Exposed_01 = 0 ,
	  Exposed_02 = 0 ,
	  In_Hospital_01 = 0 ,
	  In_Hospital_02 = 0 ,
	  In_Hospital_03 = 0 ,
	  In_Hospital_Severe = 0 ,
	  Infected_Presymptomatic_01 = 1 ,
	  Infected_Presymptomatic_02 = 0 ,
	  Not_Quarantine_Infectious_01 = 0 ,
	  Not_Quarantine_Infectious_02 = 0 ,
	  Physical_Distancing_Smoothed_Value = 1 ,
	  Removed_Asymptomatic = 0 ,
	  Removed_Awaiting_Results = 0 ,
	  Removed_Hospital = 0 ,
	  Removed_Not_Quarantine = 0 ,
	  Removed_Severe_Cases_Hospital = 0 ,
	  Removed_Severe_Cases_ICU = 0 ,
	  Removed_Symptomatic_Immediate_Isolation = 0 ,
	  Severe_Cases_Hospital_01 = 0 ,
	  Severe_Cases_Hospital_02 = 0 ,
	  Severe_Cases_ICU_01 = 0 ,
	  Severe_Cases_ICU_02 = 0 ,
	  Susceptible = 4999969 ,
	  Symptomatic_Immediate_Isolation_01 = 0 ,
	  Symptomatic_Immediate_Isolation_02 = 0 )
}

