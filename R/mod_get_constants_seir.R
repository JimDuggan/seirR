#-------------------------------------------------------------------------------------
#' Creates the vector of constants that can be used to set params
#' @return A vector of constants and their initial conditions
get_constants_seir <- function(){
c( Beta_Calibrated = 0.7366 ,
	  Beta_Multiplier_h = 1 ,
	  Contact_Multiplier = 1 ,
	  Incubation_Period_C = 6.4 ,
	  Latent_Period_L = 3.4 ,
	  Number_Seeds = 1 ,
	  Proportion_Asymptomatic_f = 0.3828 ,
	  R0_Fixed_Flag = 0 ,
	  R0_Input = 4.30911 ,
	  Reporting_Delay = 1 ,
	  Symptomatic_Testing_Fraction = 0.735 ,
	  Total_Infectious_Period_D = 5.85 ,
	  Total_Population = 4999970 )
}

