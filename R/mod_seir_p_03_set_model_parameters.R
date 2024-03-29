set_model_parameters_seir_p <- function(p){
	sim_state$AT  <- get_param(p,'AT') 
	sim_state$Average_HLOS  <- get_param(p,'Average_HLOS') 
	sim_state$Average_Wait_for_Results  <- get_param(p,'Average_Wait_for_Results') 
	sim_state$Beta_Calibrated  <- get_param(p,'Beta_Calibrated') 
	sim_state$Beta_Multiplier_h  <- get_param(p,'Beta_Multiplier_h') 
	sim_state$Beta_Multiplier_i  <- get_param(p,'Beta_Multiplier_i') 
	sim_state$Beta_Multiplier_j  <- get_param(p,'Beta_Multiplier_j') 
	sim_state$Beta_Multiplier_k  <- get_param(p,'Beta_Multiplier_k') 
	sim_state$Distancing_Start_Time  <- get_param(p,'Distancing_Start_Time') 
	sim_state$Distancing_Switch  <- get_param(p,'Distancing_Switch') 
	sim_state$Fraction_In_Hospital_Severe  <- get_param(p,'Fraction_In_Hospital_Severe') 
	sim_state$Fraction_in_Risk_Group  <- get_param(p,'Fraction_in_Risk_Group') 
	sim_state$ICU_Available_Capacity  <- get_param(p,'ICU_Available_Capacity') 
	sim_state$ICU_Residency_Time  <- get_param(p,'ICU_Residency_Time') 
	sim_state$Incubation_Period_C  <- get_param(p,'Incubation_Period_C') 
	sim_state$Lag_Time  <- get_param(p,'Lag_Time') 
	sim_state$Latent_Period_L  <- get_param(p,'Latent_Period_L') 
	sim_state$Number_Seeds  <- get_param(p,'Number_Seeds') 
	sim_state$PDAT  <- get_param(p,'PDAT') 
	sim_state$Percentage_Reduction_of_Physical_Distancing  <- get_param(p,'Percentage_Reduction_of_Physical_Distancing') 
	sim_state$Proportion_Asymptomatic_f  <- get_param(p,'Proportion_Asymptomatic_f') 
	sim_state$Proportion_Hospitalised  <- get_param(p,'Proportion_Hospitalised') 
	sim_state$Proportion_Quarantined_q  <- get_param(p,'Proportion_Quarantined_q') 
	sim_state$Proportion_Tested_t  <- get_param(p,'Proportion_Tested_t') 
	sim_state$Pulse_Duration  <- get_param(p,'Pulse_Duration') 
	sim_state$Pulse_End  <- get_param(p,'Pulse_End') 
	sim_state$Pulse_Off_Duration  <- get_param(p,'Pulse_Off_Duration') 
	sim_state$Pulse_Switch  <- get_param(p,'Pulse_Switch') 
	sim_state$R0_Fixed_Flag  <- get_param(p,'R0_Fixed_Flag') 
	sim_state$R0_Input  <- get_param(p,'R0_Input') 
	sim_state$RTime_Severe  <- get_param(p,'RTime_Severe') 
	sim_state$Switch_Time  <- get_param(p,'Switch_Time') 
	sim_state$Total_Infectious_Period_D  <- get_param(p,'Total_Infectious_Period_D') 
	sim_state$Total_Population  <- get_param(p,'Total_Population') 
	sim_state$start_day  <- get_param(p,'start_day') 
	sim_state$end_day  <- get_param(p,'end_day') 
}

