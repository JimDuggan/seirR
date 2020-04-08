library(dplyr)
#-------------------------------------------------------------------------------------
#' Populates the parameters tibble for seir_p 
#' NOTE: Edit this file to clarify parameter types 
xmile_setup_parameters <- function(){
	p_tb <- tibble::tibble(ParameterName=character(),
		ParameterType=character(),
		Description=character(),
		Value=numeric(),
		UpperEstimate=numeric(),
		LowerEstimate=numeric(),
		Varying=logical(),
		Source=character(),
		ValueS=character())

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='AT',
		ParameterType='Model',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Average_HLOS',
		ParameterType='HealthSystem',
		Description='TBD',
		Value=15,
		UpperEstimate=15,
		LowerEstimate=15,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Average_Wait_for_Results',
		ParameterType='HealthSystem',
		Description='TBD',
		Value=2,
		UpperEstimate=2,
		LowerEstimate=2,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Calibrated',
		ParameterType='Transmission',
		Description='TBD',
		Value=1.12,
		UpperEstimate=1.12,
		LowerEstimate=1.12,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_h',
		ParameterType='Transmission',
		Description='TBD',
		Value=0.21,
		UpperEstimate=0.21,
		LowerEstimate=0.21,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_i',
		ParameterType='Transmission',
		Description='TBD',
		Value=0.08,
		UpperEstimate=0.08,
		LowerEstimate=0.08,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_j',
		ParameterType='Transmission',
		Description='TBD',
		Value=0.12,
		UpperEstimate=0.12,
		LowerEstimate=0.12,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_k',
		ParameterType='Transmission',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Distancing_Start_Time',
		ParameterType='Distancing',
		Description='TBD',
		Value=20,
		UpperEstimate=20,
		LowerEstimate=20,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Distancing_Switch',
		ParameterType='Distancing',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Fraction_In_Hospital_Severe',
		ParameterType='HealthSystem',
		Description='TBD',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Fraction_in_Risk_Group',
		ParameterType='Pathway',
		Description='TBD',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='ICU_Available_Capacity',
		ParameterType='HealthSystem',
		Description='TBD',
		Value=250,
		UpperEstimate=250,
		LowerEstimate=250,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='ICU_Residency_Time',
		ParameterType='HealthSystem',
		Description='TBD',
		Value=10,
		UpperEstimate=10,
		LowerEstimate=10,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Incubation_Period_C',
		ParameterType='Biological',
		Description='TBD',
		Value=5.19,
		UpperEstimate=5.19,
		LowerEstimate=5.19,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Lag_Time',
		ParameterType='Model',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Latent_Period_L',
		ParameterType='Biological',
		Description='TBD',
		Value=3.55,
		UpperEstimate=3.55,
		LowerEstimate=3.55,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Number_Seeds',
		ParameterType='InitialCondition',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='PDAT',
		ParameterType='Distancing',
		Description='TBD',
		Value=4,
		UpperEstimate=4,
		LowerEstimate=4,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Percentage_Reduction_of_Physical_Disancing',
		ParameterType='Distancing',
		Description='TBD',
		Value=0.6,
		UpperEstimate=0.6,
		LowerEstimate=0.6,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Asymptomatic_f',
		ParameterType='Pathway',
		Description='TBD',
		Value=0.25,
		UpperEstimate=0.25,
		LowerEstimate=0.25,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Hospitalised',
		ParameterType='Pathway',
		Description='TBD',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Quarantined_q',
		ParameterType='Pathway',
		Description='TBD',
		Value=0.05,
		UpperEstimate=0.05,
		LowerEstimate=0.05,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Tested_t',
		ParameterType='Pathway',
		Description='TBD',
		Value=0.88,
		UpperEstimate=0.88,
		LowerEstimate=0.88,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_Duration',
		ParameterType='Pulse',
		Description='TBD',
		Value=21,
		UpperEstimate=21,
		LowerEstimate=21,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_End',
		ParameterType='Pulse',
		Description='TBD',
		Value=300,
		UpperEstimate=300,
		LowerEstimate=300,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_Off_Duration',
		ParameterType='Pulse',
		Description='TBD',
		Value=10,
		UpperEstimate=10,
		LowerEstimate=10,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_Switch',
		ParameterType='Pulse',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='RTime_Severe',
		ParameterType='Model',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Switch_Time',
		ParameterType='Pulse',
		Description='TBD',
		Value=60,
		UpperEstimate=60,
		LowerEstimate=60,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Total_Infectious_Period_D',
		ParameterType='Biological',
		Description='TBD',
		Value=4.13,
		UpperEstimate=4.13,
		LowerEstimate=4.13,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Total_Population',
		ParameterType='InitialCondition',
		Description='TBD',
		Value=4999970,
		UpperEstimate=4999970,
		LowerEstimate=4999970,
		Varying=F,
		Source='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='start_day',
		ParameterType='InitialCondition',
		Description='Start day of epidemic, see variable ValueS',
		Value=1,
		UpperEstimate=0,
		LowerEstimate=0,
		Varying=F,
		Source='TBD',
		ValueS='2020-02-29')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='end_day',
		ParameterType='InitialCondition',
		Description='End day of epidemic, see variable ValueS',
		Value=300,
		UpperEstimate=0,
		LowerEstimate=0,
		Varying=F,
		Source='TBD',
		ValueS='TBD')


	p_tb
}
