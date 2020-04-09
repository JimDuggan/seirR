#-------------------------------------------------------------------------------------
#' Creates the vector of constants that can be used to set params
#' @return A vector of constants and their initial conditions
xmile_get_constants <- function(){
c( AT = 1 ,
	  Average_HLOS = 15 ,
	  Average_Wait_for_Results = 3.16 ,
	  Beta_Calibrated = 0.91 ,
	  Beta_Multiplier_h = 0.11 ,
	  Beta_Multiplier_i = 0.07 ,
	  Beta_Multiplier_j = 0.0612326 ,
	  Beta_Multiplier_k = 1 ,
	  Distancing_Start_Time = 20 ,
	  Distancing_Switch = 1 ,
	  Fraction_In_Hospital_Severe = 0 ,
	  Fraction_in_Risk_Group = 0 ,
	  ICU_Available_Capacity = 250 ,
	  ICU_Residency_Time = 10 ,
	  Incubation_Period_C = 5.79 ,
	  Lag_Time = 1 ,
	  Latent_Period_L = 3.58 ,
	  Number_Seeds = 1 ,
	  PDAT = 4 ,
	  Percentage_Reduction_of_Physical_Distancing = 0.6 ,
	  Proportion_Asymptomatic_f = 0.25 ,
	  Proportion_Hospitalised = 0 ,
	  Proportion_Quarantined_q = 0.21 ,
	  Proportion_Tested_t = 0.55 ,
	  Pulse_Duration = 21 ,
	  Pulse_End = 300 ,
	  Pulse_Off_Duration = 10 ,
	  Pulse_Switch = 0 ,
	  RTime_Severe = 1 ,
	  Switch_Time = 200 ,
	  Total_Infectious_Period_D = 5.46 ,
	  Total_Population = 4999970 )
}

