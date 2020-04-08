#-------------------------------------------------------------------------------------
#' Creates the vector of constants that can be used to set params
#' @return A vector of constants and their initial conditions
xmile_get_constants <- function(){
c( AT = 1 ,
	  Average_HLOS = 15 ,
	  Average_Wait_for_Results = 2 ,
	  Beta_Calibrated = 1.12 ,
	  Beta_Multiplier_h = 0.21 ,
	  Beta_Multiplier_i = 0.08 ,
	  Beta_Multiplier_j = 0.12 ,
	  Beta_Multiplier_k = 1 ,
	  End_Time_of_Physical_Distancing = 300 ,
	  Fraction_In_Hospital_Severe = 0 ,
	  Fraction_in_Risk_Group = 0 ,
	  ICU_Available_Capacity = 250 ,
	  ICU_Residency_Time = 10 ,
	  Incubation_Period_C = 5.19 ,
	  Lag_Time = 1 ,
	  Latent_Period_L = 3.55 ,
	  Number_Seeds = 1 ,
	  PDAT = 1 ,
	  Percentage_Reduction_of_Physical_Disancing = 0.6 ,
	  Physical_Distancing_Policy_Flag = 1 ,
	  Proportion_Asymptomatic_f = 0.25 ,
	  Proportion_Hospitalised = 0 ,
	  Proportion_Quarantined_q = 0.05 ,
	  Proportion_Tested_t = 0.88 ,
	  RTime_Severe = 1 ,
	  Start_Time_of_Physical_Distancing = 20 ,
	  Total_Infectious_Period_D = 4.13 ,
	  Total_Population = 4999970 )
}

