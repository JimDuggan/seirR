library(dplyr)
library(deSolve)
library(lubridate)

#-------------------------------------------------------------------------------------
#' Creates the initial state vector for ODE
#'
#' @return A vector of compartments and their initial conditions
init_compartments <- function(){
  # Populate in Alphabetical Order

  sim_state$CompartmentsINIT <- c(AsymptomaticInfected01                 = 0,
                                   AsymptomaticInfected02                = 0,
                                   AwaitingResults01                     = 0,
                                   AwaitingResults02                     = 0,
                                   CumulativeImmediateIsolation          = 0,
                                   CumulativeInfectiousAsymptomatic      = 0,
                                   CumulativeNotQuarantined              = 0,
                                   CumulativeModelInfected               = 0,
                                   CumulativeTestIncidence               = 0,
                                   CumulativeTestsPositive               = 0,
                                   ExpectedICUExits                      = 0,
                                   Exposed01                             = 0,
                                   Exposed02                             = 0,
                                   InHospital01                          = 0,
                                   InHospital02                          = 0,
                                   InHospital03                          = 0,
                                   InHospitalSevere                      = 0,
                                   InfectedPresymptomatic01              = sim_state$P_init_seeds,
                                   InfectedPresymptomatic02              = 0,
                                   NotQuarantineInfectious01             = 0,
                                   NotQuarantineInfectious02             = 0,
                                   PhysicalDistancingSmoothedValue       = 1,
                                   RemovedAsymptomatic                   = 0,
                                   RemovedAwaitingResults                = 0,
                                   RemovedHospital                       = 0,
                                   RemovedNotQuarantine                  = 0,
                                   RemovedSevereCasesHospital            = 0,
                                   RemovedSevereCasesICU                 = 0,
                                   RemovedSymptomaticImmediateIsolation  = 0,
                                   SevereCasesHospital01                 = 0,
                                   SevereCasesHospital02                 = 0,
                                   SevereCasesICU01                      = 0,
                                   SevereCasesICU02                      = 0,
                                   Susceptible                           = sim_state$P_init_susceptible,
                                   SymptomaticImmediateIsolation01       = 0,
                                   SymptomaticImmediateIsolation02       = 0)
}

set_model_parameters <- function(p){
  # Set each param to a variable to simplify ODE function
  # Initial conditions
  sim_state$P_init_seeds               <- get_param(p, "init_seeds")
  sim_state$P_total_population         <- get_param(p, "total_population")
  sim_state$P_init_susceptible         <- get_param(p, "init_susceptible")

  # Transmission parameters
  sim_state$P_beta                     <- get_param(p, "beta")
  sim_state$P_beta_mult_h              <- get_param(p, "beta_mult_h")
  sim_state$P_beta_mult_i              <- get_param(p, "beta_mult_i")
  sim_state$P_beta_mult_j              <- get_param(p, "beta_mult_j")
  sim_state$P_beta_mult_k              <- get_param(p, "beta_mult_k")

  # Biological parameters
  sim_state$P_incubation_period        <- get_param(p, "incubation_period")
  sim_state$P_latent_period            <- get_param(p, "latent_period")
  sim_state$P_infectious_period        <- get_param(p, "infectious_period")


  # Pathway Flow Parameters
  sim_state$P_prop_asymptomatic        <- get_param(p, "prop_asymptomatic")
  sim_state$P_prop_tested              <- get_param(p, "prop_tested")
  sim_state$P_prop_quarantined         <- get_param(p, "prop_quarantined")
  sim_state$P_prop_hospital            <- get_param(p, "prop_hospital")
  sim_state$P_fraction_hosp_severe     <- get_param(p, "fraction_hosp_severe")
  sim_state$P_fraction_risk_group      <- get_param(p, "fraction_risk_group")

  # Physcial distancing parameters
  sim_state$P_distancing_flag          <- get_param(p, "distancing_flag")
  sim_state$P_pd_percentage_reduction  <- get_param(p, "pd_percentage_reduction")
  sim_state$P_pd_start_time            <- get_param(p, "pd_start_time")
  sim_state$P_pd_end_time              <- get_param(p, "pd_end_time")
  sim_state$P_pd_start_delay           <- get_param(p, "pd_start_delay")

  # Health system parameters
  sim_state$P_avr_HLOS                 <- get_param(p, "avr_HLOS")
  sim_state$P_avr_results_wait         <- get_param(p, "avr_results_wait")
  sim_state$P_icu_residency            <- get_param(p, "icu_residency")
  sim_state$P_icu_capacity             <- get_param(p, "icu_capacity")
}

#-------------------------------------------------------------------------------------
#' Prepares all variables and calls \code{deSolve::ode()}
#'
#' \code{run_seir_model()} runs the simulation, based on the parameter set
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param mod_object are the simulation parameters
#' @param start is thesimulation start time
#' @param finish is the simulation finish time
#' @param DT is the simulation time step (Euler)
#' @param return_all a flag used to decide how many observations to return
#' @param offset is the simulation offset time
#' @return A tibble of simulation results
run_seir_model <- function (mod_object, start, finish, DT, return_all=F, offset=0){
  # Create a new environment for all the simulation variable
  sim_state                <<- new.env()
  sim_state$TimeOfRun      <-Sys.time()
  sim_state$ActualStartDay <- lubridate::ymd(get_param(mod_object,"start_day",T))

  # Copy all the params to this new state
  set_model_parameters(mod_object)
  sim_state$params     <- mod_object
  sim_state$return_all <- return_all
  sim_state$offset     <- offset
  sim_state$start      <- start
  sim_state$finish     <- finish
  stocks               <- init_compartments()

  simtime              <- seq(start, finish, by=DT)
  sim_state$simtime    <- simtime

  results <-data.frame(deSolve::ode(y=stocks,
                       times=simtime,
                       func = seir_model,
                       parms=NULL,
                       method="euler"))

  results <- mutate(results,Date=sim_state$ActualStartDay+floor(time)) %>% select(Date,everything())
  irl_data <- filter(world_covid_data,Country=="Ireland")
  results <- suppressMessages(results %>%
                              dplyr::rename(SimDay=time) %>%
                              dplyr::left_join(irl_data) %>%
                              dplyr::select(Date,
                                            SimDay,
                                            Country,
                                            ReportedNewCases,
                                            ReportedNewDeaths,
                                            ReportedTotalCases,
                                            ReportedTotalDeaths,
                                            everything()))

  if(!return_all){
    lg <- c(T,rep(F,1/DT-1))
    results <- results[lg,]
  }
  sim_state$Results <- dplyr::as_tibble(results)
}

