library(deSolve)
#-------------------------------------------------------------------------------------
#' The set of ODEs to solve for the model
#' 
#' model_seir_p Solves the population model for each timestep, is called by ode
#' @param time is the current simulation time
#' @param stocks is the vector of model compartments
#' @param auxs vector of auxiliaries (alway NULL) as these are passed via sim_state environment
#' @return list of new compartment values, and other relevant variables
model_seir_p <- function(time, stocks, auxs){
with(as.list(c(stocks, auxs)), {
    AR1 <- Awaiting_Results_01/sim_state$Average_Wait_for_Results
    Asymptomatic_Infectious_Period <- sim_state$Incubation_Period_C - 
        sim_state$Latent_Period_L
    Beta_Pulse_Reduction_Factor <- 1 - ifelse(time >= sim_state$Switch_Time, 
        0.2, 0)
    C01_Total_Infected_Presymptomatic <- Infected_Presymptomatic_01 + 
        Infected_Presymptomatic_02
    C02_Total_Asymptomatic_Infected <- Asymptomatic_Infected_01 + 
        Asymptomatic_Infected_02
    C03_Total_Symptomatic_Immediate_Isolation_Infectious <- Symptomatic_Immediate_Isolation_01 + 
        Symptomatic_Immediate_Isolation_02
    C04_Total_Awaiting_Results_Infectious <- Awaiting_Results_01
    C05_Total_Isolated_After_Test_Infected <- Awaiting_Results_02
    C06_Total_Not_Quarantining_Infected <- Not_Quarantine_Infectious_01 + 
        Not_Quarantine_Infectious_02
    Checksum_Cumulative_Flows <- Cumulative_Immediate_Isolation + 
        Cumulative_Infectious_Asymptomatic + Cumulative_Not_Quarantined + 
        Cumulative_Tests_Positive
    E01 <- Exposed_01/(sim_state$Latent_Period_L/2)
    E02 <- Exposed_02/(sim_state$Latent_Period_L/2)
    EXH02 <- In_Hospital_02/(sim_state$Average_HLOS/3)
    EXH03 <- In_Hospital_03/(sim_state$Average_HLOS/3)
    ICTI <- AR1
    ICU_Daily_Freed_Up_Space <- Expected_ICU_Exits/sim_state$Lag_Time
    ICU01 <- Severe_Cases_ICU_01/(sim_state$ICU_Residency_Time/2)
    ICU02 <- Severe_Cases_ICU_02/(sim_state$ICU_Residency_Time/2)
    IP01 <- Infected_Presymptomatic_01/(Asymptomatic_Infectious_Period/2)
    Net_Infectious_Period_for_Infection_Compartments <- sim_state$Total_Infectious_Period_D + 
        sim_state$Latent_Period_L - sim_state$Incubation_Period_C
    NQI1 <- Not_Quarantine_Infectious_01/(Net_Infectious_Period_for_Infection_Compartments/2)
    NQI2 <- Not_Quarantine_Infectious_02/(Net_Infectious_Period_for_Infection_Compartments/2)
    Numerator_Term_1 <- (sim_state$Incubation_Period_C - sim_state$Latent_Period_L) * 
        (-sim_state$Proportion_Asymptomatic_f * sim_state$Beta_Multiplier_h + 
            (sim_state$Proportion_Asymptomatic_f - 1) * (sim_state$Beta_Multiplier_i - 
                1) * sim_state$Proportion_Quarantined_q + sim_state$Proportion_Asymptomatic_f)
    Numerator_Term_2 <- (sim_state$Proportion_Asymptomatic_f - 1) * (sim_state$Beta_Multiplier_j - 
        1) * sim_state$Proportion_Tested_t * (sim_state$Incubation_Period_C - 
        sim_state$Latent_Period_L + sim_state$Average_Wait_for_Results)
    Numerator_Term_3 <- sim_state$Total_Infectious_Period_D * (sim_state$Proportion_Asymptomatic_f * 
        (sim_state$Beta_Multiplier_h - sim_state$Beta_Multiplier_i * sim_state$Proportion_Quarantined_q - 
            sim_state$Beta_Multiplier_j * sim_state$Proportion_Tested_t + sim_state$Proportion_Quarantined_q + 
            sim_state$Proportion_Tested_t - 1) + (sim_state$Beta_Multiplier_i - 
        1) * sim_state$Proportion_Quarantined_q + (sim_state$Beta_Multiplier_j - 
        1) * sim_state$Proportion_Tested_t + 1)
    Pulse_Repeat <- sim_state$Pulse_Duration + sim_state$Pulse_Off_Duration
    Reported_Incidence <- AR1
    SCH01 <- Severe_Cases_Hospital_01/(sim_state$Average_HLOS/2)
    SCH02 <- Severe_Cases_Hospital_02/(sim_state$Average_HLOS/2)
    SII01 <- Symptomatic_Immediate_Isolation_01/(Net_Infectious_Period_for_Infection_Compartments/2)
    SII02 <- Symptomatic_Immediate_Isolation_02/(Net_Infectious_Period_for_Infection_Compartments/2)
    Test <- 0 + ifelse(time >= 20, 1, 0)
    Total_Exiting_AR02 <- Awaiting_Results_02/(max(1, Net_Infectious_Period_for_Infection_Compartments - 
        sim_state$Average_Wait_for_Results))
    Total_Exiting_Hospital_01 <- In_Hospital_01/(sim_state$Average_HLOS/3)
    Total_Exiting_Hospital_Severe <- In_Hospital_Severe/sim_state$RTime_Severe
    Total_Exiting_IP02 <- Infected_Presymptomatic_02/(Asymptomatic_Infectious_Period/2)
    Total_Exposed <- Exposed_01 + Exposed_02
    Total_Hospitalised <- In_Hospital_01 + In_Hospital_02 + In_Hospital_03
    Total_in_Hospital_Non_Severe <- In_Hospital_01 + In_Hospital_02 + 
        In_Hospital_03
    Total_Infectious <- C01_Total_Infected_Presymptomatic + C02_Total_Asymptomatic_Infected + 
        C03_Total_Symptomatic_Immediate_Isolation_Infectious + 
        C04_Total_Awaiting_Results_Infectious + C05_Total_Isolated_After_Test_Infected + 
        C06_Total_Not_Quarantining_Infected
    Total_Removed <- Removed_Asymptomatic + Removed_Awaiting_Results + 
        Removed_Hospital + Removed_Not_Quarantine + Removed_Severe_Cases_Hospital + 
        Removed_Severe_Cases_ICU + Removed_Symptomatic_Immediate_Isolation
    Total_Severe_in_ICU <- Severe_Cases_ICU_01 + Severe_Cases_ICU_02
    Total_Severe_in_NonICU_Hospital <- Severe_Cases_Hospital_01 + 
        Severe_Cases_Hospital_02
    sim_state$Distancing_Flag <- (0 + ifelse(time >= sim_state$Distancing_Start_Time, 
        1, 0) - ifelse(time >= sim_state$Switch_Time, 1, 0)) * sim_state$Distancing_Switch
    sim_state$Pulse_Start_Time <- sim_state$Switch_Time + sim_state$Pulse_Off_Duration
    sim_state$Pulse_Strategy_Flag <- (0 + ifelse(time >= sim_state$Switch_Time + 
        sim_state$Pulse_Off_Duration, 1, 0)) * sim_state$Pulse_Switch
    Actual_Pulse_Flag <- sd_pulse_train(time, sim_state$Pulse_Start_Time, 
        sim_state$Pulse_Duration, Pulse_Repeat, sim_state$Pulse_End)
    Additional_ICU_Places_Required <- max(0, Total_Severe_in_NonICU_Hospital - 
        Total_Severe_in_ICU)
    ASI1 <- Asymptomatic_Infected_01/(Net_Infectious_Period_for_Infection_Compartments/2)
    ASI2 <- Asymptomatic_Infected_02/(Net_Infectious_Period_for_Infection_Compartments/2)
    Beta_From_Input_R0 <- sim_state$R0_Input/(Numerator_Term_1 + Numerator_Term_2 + 
        Numerator_Term_3)
    Beta_Intermediate <- ifelse(sim_state$R0_Fixed_Flag == 1, Beta_From_Input_R0, 
        sim_state$Beta_Calibrated)
    EntHos <- sim_state$Proportion_Hospitalised * Total_Exiting_AR02
    EntRem <- (1 - sim_state$Proportion_Hospitalised) * Total_Exiting_AR02
    Error_Delta <- ICU02 - Expected_ICU_Exits
    EXH01a <- sim_state$Fraction_in_Risk_Group * sim_state$Fraction_In_Hospital_Severe * 
        Total_Exiting_Hospital_01
    EXH01b <- (1 - sim_state$Fraction_In_Hospital_Severe) * Total_Exiting_Hospital_01
    ICU_Available_Space <- ICU_Daily_Freed_Up_Space + sim_state$ICU_Available_Capacity - 
        Total_Severe_in_ICU
    IHS01 <- min(ICU_Available_Space, Total_Exiting_Hospital_Severe)
    IHS02 <- Total_Exiting_Hospital_Severe - min(ICU_Available_Space, 
        Total_Exiting_Hospital_Severe)
    IP02a <- Total_Exiting_IP02 * sim_state$Proportion_Asymptomatic_f
    IP02b <- Total_Exiting_IP02 * (1 - sim_state$Proportion_Asymptomatic_f) * 
        sim_state$Proportion_Quarantined_q
    IP02c <- Total_Exiting_IP02 * (1 - sim_state$Proportion_Asymptomatic_f) * 
        sim_state$Proportion_Tested_t
    IP02d <- Total_Exiting_IP02 * (1 - sim_state$Proportion_Asymptomatic_f) * 
        (1 - sim_state$Proportion_Tested_t - sim_state$Proportion_Quarantined_q)
    Population_Attack_Rate <- Total_Removed/sim_state$Total_Population
    Pulse_Policy <- sim_state$Pulse_Strategy_Flag * Actual_Pulse_Flag
    Total_in_Hospital <- Total_in_Hospital_Non_Severe + Total_Severe_in_NonICU_Hospital + 
        Total_Severe_in_ICU + In_Hospital_Severe
    Total_Severe_in_Hospital <- Total_Severe_in_ICU + Total_Severe_in_NonICU_Hospital
    Beta <- Beta_Intermediate * Physical_Distancing_Smoothed_Value * 
        Beta_Pulse_Reduction_Factor
    CEICUE <- Error_Delta/sim_state$AT
    CheckSum_Population <- Susceptible + Total_Exposed + Total_Infectious + 
        Total_Removed + Total_in_Hospital
    ICIA <- IP02a
    ICII <- IP02b
    ICNQ <- IP02d
    ICTP <- IP02c
    IP02_Outflow_Total_Exiting_Checksum <- IP02a + IP02b + IP02c + 
        IP02d
    Lambda <- ((Beta * C01_Total_Infected_Presymptomatic) + (Beta * 
        sim_state$Beta_Multiplier_h * sim_state$Beta_Multiplier_k * C02_Total_Asymptomatic_Infected) + 
        (Beta * sim_state$Beta_Multiplier_i * C03_Total_Symptomatic_Immediate_Isolation_Infectious) + 
        (Beta * C04_Total_Awaiting_Results_Infectious) + (Beta * 
        sim_state$Beta_Multiplier_j * C05_Total_Isolated_After_Test_Infected) + 
        (Beta * C06_Total_Not_Quarantining_Infected))/sim_state$Total_Population
    Physical_Distancing_Fractional_Reduction_Amount <- ifelse(Pulse_Policy == 
        1 | sim_state$Distancing_Flag == 1, 1 - sim_state$Percentage_Reduction_of_Physical_Distancing, 
        1)
    R0 <- (Numerator_Term_1 + Numerator_Term_2 + Numerator_Term_3) * 
        Beta
    IR <- Lambda * Susceptible
    PDSVG <- Physical_Distancing_Fractional_Reduction_Amount - 
        Physical_Distancing_Smoothed_Value
    CPDSV <- PDSVG/sim_state$PDAT
    ICI <- IR
    d_Asymptomatic_Infected_01_dt <- IP02a - ASI1
    d_Asymptomatic_Infected_02_dt <- ASI1 - ASI2
    d_Awaiting_Results_01_dt <- IP02c - AR1
    d_Awaiting_Results_02_dt <- AR1 - EntHos - EntRem
    d_Cumulative_Immediate_Isolation_dt <- ICII
    d_Cumulative_Infectious_Asymptomatic_dt <- ICIA
    d_Cumulative_Model_Infected_dt <- ICI
    d_Cumulative_Not_Quarantined_dt <- ICNQ
    d_Cumulative_Test_Incidence_dt <- ICTI
    d_Cumulative_Tests_Positive_dt <- ICTP
    d_Expected_ICU_Exits_dt <- CEICUE
    d_Exposed_01_dt <- IR - E01
    d_Exposed_02_dt <- E01 - E02
    d_In_Hospital_01_dt <- EntHos - EXH01a - EXH01b
    d_In_Hospital_02_dt <- EXH01b - EXH02
    d_In_Hospital_03_dt <- EXH02 - EXH03
    d_In_Hospital_Severe_dt <- EXH01a - IHS01 - IHS02
    d_Infected_Presymptomatic_01_dt <- E02 - IP01
    d_Infected_Presymptomatic_02_dt <- IP01 - IP02a - IP02b - 
        IP02c - IP02d
    d_Not_Quarantine_Infectious_01_dt <- IP02d - NQI1
    d_Not_Quarantine_Infectious_02_dt <- NQI1 - NQI2
    d_Physical_Distancing_Smoothed_Value_dt <- CPDSV
    d_Removed_Asymptomatic_dt <- ASI2
    d_Removed_Awaiting_Results_dt <- EntRem
    d_Removed_Hospital_dt <- EXH03
    d_Removed_Not_Quarantine_dt <- NQI2
    d_Removed_Severe_Cases_Hospital_dt <- SCH02
    d_Removed_Severe_Cases_ICU_dt <- ICU02
    d_Removed_Symptomatic_Immediate_Isolation_dt <- SII02
    d_Severe_Cases_Hospital_01_dt <- IHS02 - SCH01
    d_Severe_Cases_Hospital_02_dt <- SCH01 - SCH02
    d_Severe_Cases_ICU_01_dt <- IHS01 - ICU01
    d_Severe_Cases_ICU_02_dt <- ICU01 - ICU02
    d_Susceptible_dt <- -IR
    d_Symptomatic_Immediate_Isolation_01_dt <- IP02b - SII01
    d_Symptomatic_Immediate_Isolation_02_dt <- SII01 - SII02
    return(list(c(d_Asymptomatic_Infected_01_dt, d_Asymptomatic_Infected_02_dt, 
        d_Awaiting_Results_01_dt, d_Awaiting_Results_02_dt, d_Cumulative_Immediate_Isolation_dt, 
        d_Cumulative_Infectious_Asymptomatic_dt, d_Cumulative_Model_Infected_dt, 
        d_Cumulative_Not_Quarantined_dt, d_Cumulative_Test_Incidence_dt, 
        d_Cumulative_Tests_Positive_dt, d_Expected_ICU_Exits_dt, 
        d_Exposed_01_dt, d_Exposed_02_dt, d_In_Hospital_01_dt, 
        d_In_Hospital_02_dt, d_In_Hospital_03_dt, d_In_Hospital_Severe_dt, 
        d_Infected_Presymptomatic_01_dt, d_Infected_Presymptomatic_02_dt, 
        d_Not_Quarantine_Infectious_01_dt, d_Not_Quarantine_Infectious_02_dt, 
        d_Physical_Distancing_Smoothed_Value_dt, d_Removed_Asymptomatic_dt, 
        d_Removed_Awaiting_Results_dt, d_Removed_Hospital_dt, 
        d_Removed_Not_Quarantine_dt, d_Removed_Severe_Cases_Hospital_dt, 
        d_Removed_Severe_Cases_ICU_dt, d_Removed_Symptomatic_Immediate_Isolation_dt, 
        d_Severe_Cases_Hospital_01_dt, d_Severe_Cases_Hospital_02_dt, 
        d_Severe_Cases_ICU_01_dt, d_Severe_Cases_ICU_02_dt, d_Susceptible_dt, 
        d_Symptomatic_Immediate_Isolation_01_dt, d_Symptomatic_Immediate_Isolation_02_dt), 
        AR1 = AR1, Asymptomatic_Infectious_Period = Asymptomatic_Infectious_Period, 
        Beta_Pulse_Reduction_Factor = Beta_Pulse_Reduction_Factor, 
        C01_Total_Infected_Presymptomatic = C01_Total_Infected_Presymptomatic, 
        C02_Total_Asymptomatic_Infected = C02_Total_Asymptomatic_Infected, 
        C03_Total_Symptomatic_Immediate_Isolation_Infectious = C03_Total_Symptomatic_Immediate_Isolation_Infectious, 
        C04_Total_Awaiting_Results_Infectious = C04_Total_Awaiting_Results_Infectious, 
        C05_Total_Isolated_After_Test_Infected = C05_Total_Isolated_After_Test_Infected, 
        C06_Total_Not_Quarantining_Infected = C06_Total_Not_Quarantining_Infected, 
        Checksum_Cumulative_Flows = Checksum_Cumulative_Flows, 
        E01 = E01, E02 = E02, EXH02 = EXH02, EXH03 = EXH03, ICTI = ICTI, 
        ICU_Daily_Freed_Up_Space = ICU_Daily_Freed_Up_Space, 
        ICU01 = ICU01, ICU02 = ICU02, IP01 = IP01, Net_Infectious_Period_for_Infection_Compartments = Net_Infectious_Period_for_Infection_Compartments, 
        NQI1 = NQI1, NQI2 = NQI2, Numerator_Term_1 = Numerator_Term_1, 
        Numerator_Term_2 = Numerator_Term_2, Numerator_Term_3 = Numerator_Term_3, 
        Pulse_Repeat = Pulse_Repeat, Reported_Incidence = Reported_Incidence, 
        SCH01 = SCH01, SCH02 = SCH02, SII01 = SII01, SII02 = SII02, 
        Test = Test, Total_Exiting_AR02 = Total_Exiting_AR02, 
        Total_Exiting_Hospital_01 = Total_Exiting_Hospital_01, 
        Total_Exiting_Hospital_Severe = Total_Exiting_Hospital_Severe, 
        Total_Exiting_IP02 = Total_Exiting_IP02, Total_Exposed = Total_Exposed, 
        Total_Hospitalised = Total_Hospitalised, Total_in_Hospital_Non_Severe = Total_in_Hospital_Non_Severe, 
        Total_Infectious = Total_Infectious, Total_Removed = Total_Removed, 
        Total_Severe_in_ICU = Total_Severe_in_ICU, Total_Severe_in_NonICU_Hospital = Total_Severe_in_NonICU_Hospital, 
         sim_state$Pulse_Start_Time, 
         Actual_Pulse_Flag, 
        Additional_ICU_Places_Required = Additional_ICU_Places_Required, 
        ASI1 = ASI1, ASI2 = ASI2, Beta_From_Input_R0 = Beta_From_Input_R0, 
        Beta_Intermediate = Beta_Intermediate, EntHos = EntHos, 
        EntRem = EntRem, Error_Delta = Error_Delta, EXH01a = EXH01a, 
        EXH01b = EXH01b, ICU_Available_Space = ICU_Available_Space, 
        IHS01 = IHS01, IHS02 = IHS02, IP02a = IP02a, IP02b = IP02b, 
        IP02c = IP02c, IP02d = IP02d, Population_Attack_Rate = Population_Attack_Rate, 
        Pulse_Policy = Pulse_Policy, Total_in_Hospital = Total_in_Hospital, 
        Total_Severe_in_Hospital = Total_Severe_in_Hospital, 
        Beta = Beta, CEICUE = CEICUE, CheckSum_Population = CheckSum_Population, 
        ICIA = ICIA, ICII = ICII, ICNQ = ICNQ, ICTP = ICTP, IP02_Outflow_Total_Exiting_Checksum = IP02_Outflow_Total_Exiting_Checksum, 
        Lambda = Lambda, Physical_Distancing_Fractional_Reduction_Amount = Physical_Distancing_Fractional_Reduction_Amount, 
        R0 = R0, IR = IR, PDSVG = PDSVG, CPDSV = CPDSV, ICI = ICI, 
         sim_state$Average_Wait_for_Results, 
         sim_state$Beta_Multiplier_h, 
         sim_state$Beta_Multiplier_j, 
         sim_state$Distancing_Start_Time, 
         sim_state$Fraction_In_Hospital_Severe, 
         sim_state$Fraction_in_Risk_Group, 
         sim_state$ICU_Available_Capacity, 
         sim_state$Incubation_Period_C, 
         sim_state$Latent_Period_L, 
         sim_state$Percentage_Reduction_of_Physical_Distancing, 
         sim_state$Proportion_Asymptomatic_f, 
         sim_state$Proportion_Hospitalised, 
         sim_state$Proportion_Quarantined_q, 
         sim_state$Pulse_Duration, 
         sim_state$Pulse_Off_Duration, 
         sim_state$R0_Fixed_Flag, 
         sim_state$RTime_Severe, 
         sim_state$Total_Infectious_Period_D, 
         sim_state$Total_Population))
})
}
