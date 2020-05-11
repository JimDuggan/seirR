set_model_parameters_seir_a <- function(p){
	sim_state$Beta_Calibrated  <- get_param(p,'Beta_Calibrated') 
	sim_state$Beta_Multiplier_h  <- get_param(p,'Beta_Multiplier_h') 
	sim_state$Contact_Multiplier  <- get_param(p,'Contact_Multiplier') 
	sim_state$Incubation_Period_C  <- get_param(p,'Incubation_Period_C') 
	sim_state$Latent_Period_L  <- get_param(p,'Latent_Period_L') 
	sim_state$Number_Seeds  <- get_param(p,'Number_Seeds') 
	sim_state$Proportion_Asymptomatic_f  <- get_param(p,'Proportion_Asymptomatic_f') 
	sim_state$R0_Fixed_Flag  <- get_param(p,'R0_Fixed_Flag') 
	sim_state$R0_Input  <- get_param(p,'R0_Input') 
	sim_state$Reporting_Delay  <- get_param(p,'Reporting_Delay') 
	sim_state$Symptomatic_Testing_Fraction  <- get_param(p,'Symptomatic_Testing_Fraction') 
	sim_state$Total_Infectious_Period_D  <- get_param(p,'Total_Infectious_Period_D') 
	sim_state$Total_Population  <- get_param(p,'Total_Population') 
	sim_state$start_day  <- get_param(p,'start_day') 
	sim_state$end_day  <- get_param(p,'end_day') 
}

