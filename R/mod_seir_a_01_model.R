library(deSolve)
#-------------------------------------------------------------------------------------
#' The set of ODEs to solve for the model
#' 
#' model_seir_p Solves the population model for each timestep, is called by ode
#' @param time is the current simulation time
#' @param stocks is the vector of model compartments
#' @param auxs vector of auxiliaries (alway NULL) as these are passed via sim_state environment
#' @return list of new compartment values, and other relevant variables
model_seir_a <- function(time, stocks, auxs){
with(as.list(c(stocks, auxs)), {
    Asymptomatic_Infectious_Period <- sim_state$Incubation_Period_C - 
        sim_state$Latent_Period_L
    Beta <- sim_state$Contact_Multiplier * sim_state$Beta_Calibrated
    C01_Total_Presymptomatic_Infected <- Infectious_Presymptomatic_01 + 
        Infectious_Presymptomatic_02
    C02_Total_Asymptomatic_Infected <- Infectious_Asymptomatic_01 + 
        Infectious_Asymptomatic_02
    C06_Total_Symptomatic_Infected <- Infectious_Symptomatic_01 + 
        Infectious_Symptomatic_02
    E01 <- Exposed_01/(sim_state$Latent_Period_L/2)
    E02 <- Exposed_02/(sim_state$Latent_Period_L/2)
    IP01 <- Infectious_Presymptomatic_01/(Asymptomatic_Infectious_Period/2)
    Lambda <- ((Beta * C01_Total_Presymptomatic_Infected) + (Beta * 
        sim_state$Beta_Multiplier_h * C02_Total_Asymptomatic_Infected) + 
        (Beta * C06_Total_Symptomatic_Infected))/sim_state$Total_Population
    Net_Infectious_Period_for_Infection_Compartments <- sim_state$Total_Infectious_Period_D + 
        sim_state$Latent_Period_L - sim_state$Incubation_Period_C
    NQI1 <- Infectious_Symptomatic_01/(Net_Infectious_Period_for_Infection_Compartments/2)
    NQI2 <- Infectious_Symptomatic_02/(Net_Infectious_Period_for_Infection_Compartments/2)
    ReportedCases <- Infected_Reporting_in_Progress/sim_state$Reporting_Delay
    Total_Exiting_IP02 <- Infectious_Presymptomatic_02/(Asymptomatic_Infectious_Period/2)
    ASI1 <- Infectious_Asymptomatic_01/(Net_Infectious_Period_for_Infection_Compartments/2)
    ASI2 <- Infectious_Asymptomatic_02/(Net_Infectious_Period_for_Infection_Compartments/2)
    IP02a <- Total_Exiting_IP02 * sim_state$Proportion_Asymptomatic_f
    IP02b <- Total_Exiting_IP02 * (1 - sim_state$Proportion_Asymptomatic_f)
    IR <- Lambda * Susceptible
    Being_Tested <- sim_state$Symptomatic_Testing_Fraction * IP02b
    d_CumulativeCases_dt <- ReportedCases
    d_Exposed_01_dt <- IR - E01
    d_Exposed_02_dt <- E01 - E02
    d_Infected_Reporting_in_Progress_dt <- Being_Tested - ReportedCases
    d_Infectious_Asymptomatic_01_dt <- IP02a - ASI1
    d_Infectious_Asymptomatic_02_dt <- ASI1 - ASI2
    d_Infectious_Presymptomatic_01_dt <- E02 - IP01
    d_Infectious_Presymptomatic_02_dt <- IP01 - IP02a - IP02b
    d_Infectious_Symptomatic_01_dt <- IP02b - NQI1
    d_Infectious_Symptomatic_02_dt <- NQI1 - NQI2
    d_Removed_dt <- ASI2 + NQI2
    d_Susceptible_dt <- -IR
    return(list(c(d_CumulativeCases_dt, d_Exposed_01_dt, d_Exposed_02_dt, 
        d_Infected_Reporting_in_Progress_dt, d_Infectious_Asymptomatic_01_dt, 
        d_Infectious_Asymptomatic_02_dt, d_Infectious_Presymptomatic_01_dt, 
        d_Infectious_Presymptomatic_02_dt, d_Infectious_Symptomatic_01_dt, 
        d_Infectious_Symptomatic_02_dt, d_Removed_dt, d_Susceptible_dt), 
        Asymptomatic_Infectious_Period = Asymptomatic_Infectious_Period, 
        Beta = Beta, C01_Total_Presymptomatic_Infected = C01_Total_Presymptomatic_Infected, 
        C02_Total_Asymptomatic_Infected = C02_Total_Asymptomatic_Infected, 
        C06_Total_Symptomatic_Infected = C06_Total_Symptomatic_Infected, 
        E01 = E01, E02 = E02, IP01 = IP01, Lambda = Lambda, Net_Infectious_Period_for_Infection_Compartments = Net_Infectious_Period_for_Infection_Compartments, 
        NQI1 = NQI1, NQI2 = NQI2, ReportedCases = ReportedCases, 
        Total_Exiting_IP02 = Total_Exiting_IP02, ASI1 = ASI1, 
        ASI2 = ASI2, IP02a = IP02a, IP02b = IP02b, IR = IR, Being_Tested = Being_Tested, 
         sim_state$Beta_Multiplier_h, 
         sim_state$Incubation_Period_C, 
         sim_state$Number_Seeds, 
         sim_state$Proportion_Asymptomatic_f, 
         sim_state$Symptomatic_Testing_Fraction, 
         sim_state$Total_Infectious_Period_D, 
         sim_state$Total_Population))
})
}
