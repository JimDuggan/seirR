library(dplyr)
#-------------------------------------------------------------------------------------
#' Populates the parameters tibble for seir_p 
#' NOTE: Edit this file to clarify parameter types 
setup_seir_a_parameters <- function(){
	p_tb <- tibble::tibble(ParameterName=character(),
		ParameterType=character(),
		Description=character(),
		Value=numeric(),
		UpperEstimate=numeric(),
		LowerEstimate=numeric(),
		Models=character(),
		ValueS=character())

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Calibrated',
		ParameterType='Transmission',
		Description='Estimated effective contact rate (1/day)',
		Value=0.7366,
		UpperEstimate=0.7366,
		LowerEstimate=0.7366,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Beta_Multiplier_h',
		ParameterType='Transmission',
		Description='Effective contact rate multiplier for asymptomatic (dmnl)',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Contact_Multiplier',
		ParameterType='Model',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Incubation_Period_C',
		ParameterType='Biological',
		Description='Average incubation period, includes infectious element',
		Value=6.4,
		UpperEstimate=6.4,
		LowerEstimate=6.4,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Latent_Period_L',
		ParameterType='Biological',
		Description='Average latent time (not infectious)',
		Value=3.4,
		UpperEstimate=3.4,
		LowerEstimate=3.4,
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
		ParameterName='Proportion_Asymptomatic_f',
		ParameterType='Pathway',
		Description='Proportion of the population who are asymptomatic',
		Value=0.3828,
		UpperEstimate=0.3828,
		LowerEstimate=0.3828,
		Models='seir_p')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Reporting_Delay',
		ParameterType='Model',
		Description='TBD',
		Value=1,
		UpperEstimate=1,
		LowerEstimate=1,
		Models='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Symptomatic_Testing_Fraction',
		ParameterType='Model',
		Description='TBD',
		Value=0.735,
		UpperEstimate=0.735,
		LowerEstimate=0.735,
		Models='TBD')

	p_tb <- dplyr::add_row(p_tb,
		ParameterName='Total_Infectious_Period_D',
		ParameterType='Biological',
		Description='Total infectious period for disease (days)',
		Value=5.85,
		UpperEstimate=5.85,
		LowerEstimate=5.85,
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
