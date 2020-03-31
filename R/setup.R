library(dplyr)
library(tibble)
library(readr)
library(RCurl)
#-------------------------------------------------------------------------------------
#' Gets the latest world covid data
#'
#' \code{get_world_data} creates a tibble in the data_env
#' @param tb is input seir object
#' @return tibble of class seir
get_world_data <- function(){
  data_env <<- new.env()
  url_data <-"https://covid.ourworldindata.org/data/ecdc/full_data.csv"

  if(RCurl::url.exists(url_data)){
    packageStartupMessage(paste("Loading",url_data," to global environment data_env"))
    suppressMessages(data_env$covid_data <- readr::read_csv(url_data))
    data_env$covid_data <- dplyr::rename(data_env$covid_data,
                                         Date=date,
                                         Country=location,
                                         ReportedNewCases=new_cases,
                                         ReportedNewDeaths=new_deaths,
                                         ReportedTotalCases=total_cases,
                                         ReportedTotalDeaths=total_deaths)
  }
}
#-------------------------------------------------------------------------------------
#' Gets the transmission params for the initial params tibble
#'
#' \code{get_initial_conditions_01} returns resource params
#' @param tb is input seir object
#' @return tibble of class seir
get_initial_conditions_01<-function(tb){
  tb <- dplyr::add_row(tb,
                       ParameterName="init_seeds",
                       ParameterType="InitialCondition",
                       Description="The initial number of people infected",
                       Value=1,
                       UpperEstimate=1,
                       LowerEstimate=1,
                       Varying=F,
                       Source="Use for data calibration process");
  tb <- dplyr::add_row(tb,
                       ParameterName="total_population",
                       ParameterType="InitialCondition",
                       Description="Total number of people in all compartments",
                       Value=4800000,
                       UpperEstimate=4800000,
                       LowerEstimate=4800000,
                       Varying=F,
                       Source="National Statistics")
  tb <- dplyr::add_row(tb,
                       ParameterName="init_susceptible",
                       ParameterType="InitialCondition",
                       Description="Initial number susceptible",
                       Value=4800000-1,
                       UpperEstimate=4800000-1,
                       LowerEstimate=4800000-1,
                       Varying=F,
                       Source="Arbitrary value")
  tb <- dplyr::add_row(tb,
                       ParameterName="start_day",
                       ParameterType="InitialCondition",
                       Description="Start day of epidemic, see variable ValueS",
                       Value=1,
                       UpperEstimate=0,
                       LowerEstimate=0,
                       Varying=F,
                       Source="Depends on country",
                       ValueS="2020-02-29")
  tb <- dplyr::add_row(tb,
                       ParameterName="end_day",
                       ParameterType="InitialCondition",
                       Description="End day of epidemic, see variable ValueS",
                       Value=300,
                       UpperEstimate=0,
                       LowerEstimate=0,
                       Varying=F,
                       Source="Depends on country",
                       ValueS="")
  tb
}
#-------------------------------------------------------------------------------------
#' Gets the transmission params for the initial params tibble
#'
#' \code{get_transmission_params_02} returns resource params
#' @param tb is input seir object
#' @return tibble of class seir
get_transmission_params_02<-function(tb){
  tb <- dplyr::add_row(tb,
                       ParameterName="beta",
                       ParameterType="Transmission",
                       Description="Transmission parameter",
                       Value=1.12,
                       UpperEstimate=1.04138,
                       LowerEstimate=1.04138,
                       Varying=F,
                       Source="Calibration of Irish Data");
  tb <- dplyr::add_row(tb,
                       ParameterName="beta_mult_h",
                       ParameterType="Transmission",
                       Description="Multiplicative factor for reduction in infectiousness of asymptomatic infected",
                       Value=0.21,
                       UpperEstimate=0.75,
                       LowerEstimate=0.15,
                       Varying=T,
                       Source="Lierature reviews")
  tb <- dplyr::add_row(tb,
                       ParameterName="beta_mult_i",
                       ParameterType="Transmission",
                       Description="Multiplicative factor for reduction in infectiousness of those in isolation",
                       Value=0.08,
                       UpperEstimate=0.0101439,
                       LowerEstimate=0.0101439,
                       Varying=T,
                       Source="Calibration of Irish Data")
  tb <- dplyr::add_row(tb,
                       ParameterName="beta_mult_j",
                       ParameterType="Transmission",
                       Description="Multiplicative factor for reduction in infectiousness of those solated after test",
                       Value=0.12,
                       UpperEstimate=0.177054,
                       LowerEstimate=0.177054,
                       Varying=F,
                       Source="Arbitrary")
  tb <- dplyr::add_row(tb,
                       ParameterName="beta_mult_k",
                       ParameterType="Transmission",
                       Description="Multiplicative factor for those asymptomatic who may isolate",
                       Value=1.0,
                       UpperEstimate=1.0,
                       LowerEstimate=1.0,
                       Varying=T,
                       Source="Speculative at time of model design")
  tb

}

#-------------------------------------------------------------------------------------
#' Gets the biological params for the initial params tibble
#'
#' \code{get_biological_params_03} returns resource params
#' @param tb is input seir object
#' @return tibble of class seir
get_biological_params_03<-function(tb){
  tb <- dplyr::add_row(tb,
                       ParameterName="incubation_period",
                       ParameterType="Biological",
                       Description="Time from infection until clinical symptoms",
                       Value=5.19,
                       UpperEstimate=5.3,
                       LowerEstimate=5.3,
                       Varying=F,
                       Source="Sourced via systematic review")
  tb <- dplyr::add_row(tb,
                       ParameterName="latent_period",
                       ParameterType="Biological",
                       Description="Time from infection until being infectious (L)",
                       Value=3.55,
                       UpperEstimate=3.55,
                       LowerEstimate=3.55,
                       Varying=F,
                       Source="Sourced via systematic review")
  tb <- dplyr::add_row(tb,
                       ParameterName="infectious_period",
                       ParameterType="Biological",
                       Description="Total Duration of Infectiousness",
                       Value=4.13,
                       UpperEstimate=5.64,
                       LowerEstimate=5.64,
                       Varying=F,
                       Source="Sourced via systematic review")
  tb
}

#-------------------------------------------------------------------------------------
#' Gets the flow params for the initial params tibble
#'
#' \code{get_flow_params_04} returns resource params
#' @param tb is input seir object
#' @return tibble of class seir
get_flow_params_04<-function(tb){
  tb <- dplyr::add_row(tb,
                       ParameterName="prop_asymptomatic",
                       ParameterType="PathwayFlow",
                       Description="Proportion of population who do not have symptoms (undocumented)",
                       Value=0.25,
                       UpperEstimate=0.75,
                       LowerEstimate=0.15,
                       Varying=T,
                       Source="Based on wide range from systematic review")
  tb <- dplyr::add_row(tb,
                       ParameterName="prop_tested",
                       ParameterType="PathwayFlow",
                       Description="Proportion of symptomatic who have positive test",
                       Value=0.88,
                       UpperEstimate=0.88,
                       LowerEstimate=0.88,
                       Varying=F,
                       Source="TBD")
  tb <- dplyr::add_row(tb,
                       ParameterName="prop_quarantined",
                       ParameterType="PathwayFlow",
                       Description="Proportion of symptomatic self-isolate",
                       Value=0.05,
                       UpperEstimate=0.08,
                       LowerEstimate=0.08,
                       Varying=F,
                       Source="TBD")
  tb <- dplyr::add_row(tb,
                       ParameterName="prop_hospital",
                       ParameterType="PathwayFlow",
                       Description="Proportion of positive tests who are hospitalised",
                       Value=0,
                       UpperEstimate=0,
                       LowerEstimate=0,
                       Varying=F,
                       Source="TBD")
  tb <- dplyr::add_row(tb,
                       ParameterName="fraction_hosp_severe",
                       ParameterType="PathwayFlow",
                       Description="Fraction is hospital who are severly ill",
                       Value=0,
                       UpperEstimate=0,
                       LowerEstimate=0,
                       Varying=F,
                       Source="TBD")
  tb <- dplyr::add_row(tb,
                       ParameterName="fraction_risk_group",
                       ParameterType="PathwayFlow",
                       Description="Fraction from risk group",
                       Value=0,
                       UpperEstimate=0,
                       LowerEstimate=0,
                       Varying=F,
                       Source="TBD")
  tb
}

#-------------------------------------------------------------------------------------
#' Gets the physical distancing params for the initial params tibble
#'
#' \code{get_distancing_params_05} returns resource params
#' @param tb is input seir object
#' @return tibble of class seir
get_distancing_params_05 <- function(tb){
  tb <- dplyr::add_row(tb,
                       ParameterName="distancing_flag",
                       ParameterType="Distancing",
                       Description="Flag to activate physical distancing",
                       Value=0,
                       UpperEstimate=1,
                       LowerEstimate=0,
                       Varying=T,
                       Source="Model variable to activate policy")
  tb <- dplyr::add_row(tb,
                       ParameterName="pd_percentage_reduction",
                       ParameterType="Distancing",
                       Description="Percentage reduction in physical distancing",
                       Value=.60,
                       UpperEstimate=.7,
                       LowerEstimate=0,
                       Varying=T,
                       Source="Impact of physical distancing on transmission parameter")
  tb <- dplyr::add_row(tb,
                       ParameterName="pd_start_time",
                       ParameterType="Distancing",
                       Description="Start time for physical distancing (day)",
                       Value=20,
                       UpperEstimate=100,
                       LowerEstimate=20,
                       Varying=T,
                       Source="Time when intervention starts")
  tb <- dplyr::add_row(tb,
                       ParameterName="pd_end_time",
                       ParameterType="Distancing",
                       Description="End time for physical distancing (day)",
                       Value=300,
                       UpperEstimate=300,
                       LowerEstimate=100,
                       Varying=T,
                       Source="Time when intervention ends")
  tb <- dplyr::add_row(tb,
                       ParameterName="pd_start_delay",
                       ParameterType="Distancing",
                       Description="Time lag for reductions to take hold",
                       Value=1,
                       UpperEstimate=20,
                       LowerEstimate=3,
                       Varying=T,
                       Source="Time lag for intervention to have an impact")
  tb

}

#-------------------------------------------------------------------------------------
#' Gets the health system params for the initial params tibble
#'
#' \code{get_health_system_params_06} returns resource params
#' @param tb is input seir object
#' @return tibble of class seir
get_health_system_params_06<-function(tb){
  tb <- dplyr::add_row(tb,
                       ParameterName="avr_HLOS",
                       ParameterType="HealthSystem",
                       Description="Average Hospital length of stay",
                       Value=15,
                       UpperEstimate=15,
                       LowerEstimate=7,
                       Varying=T,
                       Source="TBD")
  tb <- dplyr::add_row(tb,
                       ParameterName="avr_results_wait",
                       ParameterType="HealthSystem",
                       Description="Average wait for positive result",
                       Value=2,
                       UpperEstimate=3,
                       LowerEstimate=1,
                       Varying=T,
                       Source="TBD")
  tb <- dplyr::add_row(tb,
                       ParameterName="icu_residency",
                       ParameterType="HealthSystem",
                       Description="Average time in ICU",
                       Value=10,
                       UpperEstimate=10,
                       LowerEstimate=10,
                       Varying=F,
                       Source="TBD")
  tb <- dplyr::add_row(tb,
                       ParameterName="icu_capacity",
                       ParameterType="HealthSystem",
                       Description="ICU Spaces",
                       Value=250,
                       UpperEstimate=250,
                       LowerEstimate=250,
                       Varying=F,
                       Source="TBD")
  tb

}
