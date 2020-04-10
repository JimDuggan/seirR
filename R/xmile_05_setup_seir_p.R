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
		Models=character(),
		ValueS=character())

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='AT',
		ParameterType='Model',
		Description='Adjustment time for ICU exits',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Average_HLOS',
		ParameterType='HealthSystem',
		Description='Average length of stay in hospital (days)',
		Value=15,
		UpperEstimate=15,
		LowerEstimate=15,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Average_Wait_for_Results',
		ParameterType='HealthSystem',
		Description='Average wait for test results (days)',
		Value=3.16,
		UpperEstimate=3.16,
		LowerEstimate=3.16,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Calibrated',
		ParameterType='Transmission',
		Description='Estomated effective contact rate (1/day)',
		Value=0.91,
		UpperEstimate=0.91,
		LowerEstimate=0.91,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_h',
		ParameterType='Transmission',
		Description='Effective contact rate multiplier for asymptomatic (dmnl)',
		Value=0.11,
		UpperEstimate=0.11,
		LowerEstimate=0.11,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_i',
		ParameterType='Transmission',
		Description='Effective contact rate multiplier for those in isolation (dmnl)',
		Value=0.07,
		UpperEstimate=0.07,
		LowerEstimate=0.07,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_j',
		ParameterType='Transmission',
		Description='Effective contact rate multiplier for those awaiting results (dmnl)',
		Value=0.0612326,
		UpperEstimate=0.0612326,
		LowerEstimate=0.0612326,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_k',
		ParameterType='Transmission',
		Description='Additional self-quarantine multiplier for asymptomatic (dmnl)',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Distancing_Start_Time',
		ParameterType='Distancing',
		Description='When physical distancing is started',
		Value=20,
		UpperEstimate=20,
		LowerEstimate=20,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Distancing_Switch',
		ParameterType='Distancing',
		Description='A flag that switches on the physcial distancing policy',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Fraction_In_Hospital_Severe',
		ParameterType='HealthSystem',
		Description='Fraction of those entering hospital who become severely ill (dimn)',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Fraction_in_Risk_Group',
		ParameterType='Pathway',
		Description='Fraction of those hospitalised who are at risk of severe illness',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='ICU_Available_Capacity',
		ParameterType='HealthSystem',
		Description='Available ICU capacity (people)',
		Value=250,
		UpperEstimate=250,
		LowerEstimate=250,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='ICU_Residency_Time',
		ParameterType='HealthSystem',
		Description='Average residencu time in ICU (day)',
		Value=10,
		UpperEstimate=10,
		LowerEstimate=10,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Incubation_Period_C',
		ParameterType='Biological',
		Description='Average incubation period, includes infectious element',
		Value=5.79,
		UpperEstimate=5.79,
		LowerEstimate=5.79,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Lag_Time',
		ParameterType='Model',
		Description='Amount of time to make ICU space available (day)',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Latent_Period_L',
		ParameterType='Biological',
		Description='Average latent time (not infectious)',
		Value=3.58,
		UpperEstimate=3.58,
		LowerEstimate=3.58,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Number_Seeds',
		ParameterType='InitialCondition',
		Description='Initial number of infectious people in the population',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='PDAT',
		ParameterType='Distancing',
		Description='Time lag before distancing measures have an impact (day)',
		Value=4,
		UpperEstimate=4,
		LowerEstimate=4,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Percentage_Reduction_of_Physical_Distancing',
		ParameterType='Distancing',
		Description='Percentage reduction in transmission via physical distancing',
		Value=0.6,
		UpperEstimate=0.6,
		LowerEstimate=0.6,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Asymptomatic_f',
		ParameterType='Pathway',
		Description='Proportion of the population who are asymptomatic',
		Value=0.25,
		UpperEstimate=0.25,
		LowerEstimate=0.25,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Hospitalised',
		ParameterType='Pathway',
		Description='Proportion of the population who are hospitalised',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Quarantined_q',
		ParameterType='Pathway',
		Description='Proportion of the population who are quarantined',
		Value=0.21,
		UpperEstimate=0.21,
		LowerEstimate=0.21,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Proportion_Tested_t',
		ParameterType='Pathway',
		Description='Proportion of the population who are tested',
		Value=0.55,
		UpperEstimate=0.55,
		LowerEstimate=0.55,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_Duration',
		ParameterType='Pulse',
		Description='The duration of the pulse intervention (relaxation of distancing)',
		Value=21,
		UpperEstimate=21,
		LowerEstimate=21,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_End',
		ParameterType='Pulse',
		Description='End of pulse policy',
		Value=300,
		UpperEstimate=300,
		LowerEstimate=300,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_Off_Duration',
		ParameterType='Pulse',
		Description='Duration of time in between pulses',
		Value=10,
		UpperEstimate=10,
		LowerEstimate=10,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Pulse_Switch',
		ParameterType='Pulse',
		Description='Activate/deactive the pulse policy',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='R0_Fixed_Flag',
		ParameterType='Transmission',
		Description='Flag (0|1) that will fix R0 for the simulation',
		Value=0,
		UpperEstimate=0,
		LowerEstimate=0,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='R0_Input',
		ParameterType='Transmission',
		Description='If R0_Fixed_Flag is set to 1, this value of R0 will be used.',
		Value=2.8,
		UpperEstimate=2.8,
		LowerEstimate=2.8,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='RTime_Severe',
		ParameterType='Model',
		Description='Time before developing severe symptoms',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Switch_Time',
		ParameterType='Pulse',
		Description='The time to switch to the pulse policy',
		Value=200,
		UpperEstimate=200,
		LowerEstimate=200,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Total_Infectious_Period_D',
		ParameterType='Biological',
		Description='Total infectious period for disease (days)',
		Value=5.46,
		UpperEstimate=5.46,
		LowerEstimate=5.46,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Total_Population',
		ParameterType='InitialCondition',
		Description='Total population (people)',
		Value=4999970,
		UpperEstimate=4999970,
		LowerEstimate=4999970,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='start_day',
		ParameterType='InitialCondition',
		Description='Start day of epidemic, see variable ValueS',
		Value=1,
		UpperEstimate=0,
		LowerEstimate=0,
		Models='seir_p|seir_a',
		ValueS='2020-02-29')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='end_day',
		ParameterType='InitialCondition',
		Description='End day of epidemic, see variable ValueS',
		Value=300,
		UpperEstimate=0,
		LowerEstimate=0,
		Models='seir_p|seir_a',
		ValueS='TBD')


	p_tb
}
