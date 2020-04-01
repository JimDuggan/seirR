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

  sim_state$start_time                  <- get_param(p, "start_day")
  sim_state$end_time                    <- get_param(p, "end_day")

  # Age cohort model
  sim_state$P_number_age_cohorts       <- 4
  sim_state$P_stock_names              <- c("Susceptible","Exposed")
  sim_state$P_cohorts                  <- c("Age_00_04","Age_05_14","Age_15_64","Age_65_PLUS")
}
