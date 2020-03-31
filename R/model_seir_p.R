library(deSolve)
#-------------------------------------------------------------------------------------
#' The set of ODEs to solve for the model
#'
#' \code{seir_model_p} Solves the population model for each timestep, is called by \code{ode}
#' @param time is the current simulation time
#' @param stocks is the vector of model compartments
#' @param auxs vector of auxiliaries (alway NULL) as these are passed via \code{sim_state} environment
#' @return list of new compartment values, and other relevant variables
model_seir_p <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{

    TotalSevereinNonICUHospital <- SevereCasesHospital01 + SevereCasesHospital02

    TotalSevereinICU <-  SevereCasesICU01 + SevereCasesICU02

    AdditionalICUPlacesRequired <- max (0, TotalSevereinNonICUHospital - TotalSevereinICU)

    AR1 <- AwaitingResults01 / sim_state$P_avr_results_wait

    NetInfectiousPeriodforInfectionCompartments <- sim_state$P_infectious_period +
                                                   sim_state$P_latent_period -
                                                   sim_state$P_incubation_period

    ASI1 <- AsymptomaticInfected01 / (NetInfectiousPeriodforInfectionCompartments / 2)
    ASI2 <- AsymptomaticInfected02 / ( NetInfectiousPeriodforInfectionCompartments/ 2)

    AsymptomaticInfectiousPeriod_CL <- sim_state$P_incubation_period - sim_state$P_latent_period

    AT <- 1

    if(sim_state$P_distancing_flag == 1 )
      EffectofPhysicalDistancingonBeta <- PhysicalDistancingSmoothedValue
    else
      EffectofPhysicalDistancingonBeta <- 1

     Beta <- sim_state$P_beta * EffectofPhysicalDistancingonBeta


     C01TotalInfectedPresymptomatic <- InfectedPresymptomatic01 + InfectedPresymptomatic02

     C02TotalAsymptomaticInfected <- AsymptomaticInfected01 + AsymptomaticInfected02

     C03TotalSymptomaticImmediateIsolationInfectious <- SymptomaticImmediateIsolation01 +
                                                        SymptomaticImmediateIsolation02

     C04TotalAwaitingResultsInfectious <- AwaitingResults01

     C05TotalIsolatedAfterTestInfected <- AwaitingResults02

     C06TotalNotQuarantiningInfected <- NotQuarantineInfectious01 + NotQuarantineInfectious02

     ICU02 <- SevereCasesICU02 / ( sim_state$P_icu_residency / 2)

     ErrorDelta <- ICU02 - ExpectedICUExits

     CEICUE <- ErrorDelta / AT

     ChecksumCumulativeFlows <- CumulativeImmediateIsolation +
                                CumulativeInfectiousAsymptomatic +
                                CumulativeNotQuarantined +
                                CumulativeTestsPositive


     TotalExposed <-  Exposed01 + Exposed02

     TotalInfectious <- C01TotalInfectedPresymptomatic +
                       C02TotalAsymptomaticInfected   +
                       C03TotalSymptomaticImmediateIsolationInfectious +
                       C04TotalAwaitingResultsInfectious +
                       C05TotalIsolatedAfterTestInfected +
                       C06TotalNotQuarantiningInfected

     TotalRemoved <- RemovedAsymptomatic +
                     RemovedAwaitingResults +
                     RemovedHospital +
                     RemovedNotQuarantine +
                     RemovedSevereCasesHospital +
                     RemovedSevereCasesICU +
                     RemovedSymptomaticImmediateIsolation

     TotalinHospitalNonSevere <- InHospital01 + InHospital02 + InHospital03

     TotalinHospital <- TotalinHospitalNonSevere +
                        TotalSevereinNonICUHospital+
                        TotalSevereinICU +
                        InHospitalSevere

     CheckSumPopulation <- Susceptible +
                          TotalExposed +
                          TotalInfectious +
                          TotalRemoved +
                          TotalinHospital

     if( time >= sim_state$P_pd_start_time &&
         time <= sim_state$P_pd_end_time)
         PhysicalDistancingFractionalReductionAmount <- 1 - sim_state$P_pd_percentage_reduction
     else
        PhysicalDistancingFractionalReductionAmount <- 1


     PDSVG <- PhysicalDistancingFractionalReductionAmount - PhysicalDistancingSmoothedValue

     CPDSV <- PDSVG / sim_state$P_pd_start_delay

     E01 <- Exposed01 / ( sim_state$P_latent_period / 2)

     E02 <- Exposed02 / (sim_state$P_latent_period / 2)

     TotalExitingAR02 <-  AwaitingResults02 / (max ( 1, NetInfectiousPeriodforInfectionCompartments
                                                         - sim_state$P_avr_results_wait) )

     EntHos <- sim_state$P_prop_hospital * TotalExitingAR02

     EntRem <- ( 1 - sim_state$P_prop_hospital ) * TotalExitingAR02


     TotalExitingHospital01 = InHospital01 / ( sim_state$P_avr_HLOS / 3)

     EXH01a <- sim_state$P_fraction_risk_group   *
               sim_state$P_fraction_hosp_severe  *
               TotalExitingHospital01

      EXH01b <- ( 1 - sim_state$P_fraction_hosp_severe ) * TotalExitingHospital01

      EXH02 <- InHospital02 / ( sim_state$P_avr_HLOS / 3)

      EXH03 <- InHospital03 / ( sim_state$P_avr_HLOS / 3)

      Lambda <- ((Beta * C01TotalInfectedPresymptomatic) +
                 (Beta * sim_state$P_beta_mult_h * sim_state$P_beta_mult_k * C02TotalAsymptomaticInfected) +
                 (Beta * sim_state$P_beta_mult_i * C03TotalSymptomaticImmediateIsolationInfectious) +
                 (Beta * C04TotalAwaitingResultsInfectious) +
                 (Beta * sim_state$P_beta_mult_j * C05TotalIsolatedAfterTestInfected) +
                 (Beta * C06TotalNotQuarantiningInfected) ) / sim_state$P_total_population

      IR <- Lambda * Susceptible

      ICI <- IR

      TotalExitingIP02 <- InfectedPresymptomatic02 / ( AsymptomaticInfectiousPeriod_CL / 2)

      IP02a <- TotalExitingIP02 * sim_state$P_prop_asymptomatic

      ICIA <- IP02a

      IP02b <- TotalExitingIP02 * ( 1 - sim_state$P_prop_asymptomatic ) * sim_state$P_prop_quarantined

      ICII <- IP02b

      IP02d = TotalExitingIP02 *
                (1 - sim_state$P_prop_asymptomatic ) *
                (1 - sim_state$P_prop_tested - sim_state$P_prop_quarantined )

      ICNQ <- IP02d

      ICTI <- AR1

      IP02c <- TotalExitingIP02 * ( 1 - sim_state$P_prop_asymptomatic ) * sim_state$P_prop_tested

      ICTP <- IP02c

      LagTime <- 1

      ICUDailyFreedUpSpace <- ExpectedICUExits / LagTime

      ICUAvailableSpace <- ICUDailyFreedUpSpace + sim_state$P_icu_capacity - TotalSevereinICU

      ICU01 <- SevereCasesICU01 / ( sim_state$P_icu_residency / 2)

      TotalExitingHospitalSevere <- InHospitalSevere

      IHS01 <- min ( ICUAvailableSpace , TotalExitingHospitalSevere )

      IHS02 <- TotalExitingHospitalSevere - min (ICUAvailableSpace , TotalExitingHospitalSevere)

      IP01 <- InfectedPresymptomatic01 / (AsymptomaticInfectiousPeriod_CL/ 2)

      IP02OutflowTotalExitingChecksum <- IP02a + IP02b + IP02c + IP02d

      NQI1 <- NotQuarantineInfectious01 / ( NetInfectiousPeriodforInfectionCompartments / 2)

      NQI2 <- NotQuarantineInfectious02 / ( NetInfectiousPeriodforInfectionCompartments / 2)

      PopulationAttackRate <- TotalRemoved / sim_state$P_total_population

      ReportedIncidence <- AR1

      SCH01 <- SevereCasesHospital01 / ( sim_state$P_avr_HLOS / 2)

      SCH02 <- SevereCasesHospital02 / ( sim_state$P_avr_HLOS  / 2)

      SII01 <- SymptomaticImmediateIsolation01 / ( NetInfectiousPeriodforInfectionCompartments / 2)

      SII02 <- SymptomaticImmediateIsolation02 / (NetInfectiousPeriodforInfectionCompartments/ 2)

      TotalHospitalised = InHospital01 + InHospital02 + InHospital03

      TotalSevereinHospital = TotalSevereinICU + TotalSevereinNonICUHospital

    # Calculate the derivatives

      AsymptomaticInfected01_dot                <- IP02a - ASI1
      AsymptomaticInfected02_dot                <- ASI1  - ASI2
      AwaitingResults01_dot                     <- IP02c - AR1
      AwaitingResults02_dot                     <- AR1 - EntHos - EntRem
      CumulativeImmediateIsolation              <- ICII
      CumulativeInfectiousAsymptomatic          <- ICIA
      CumulativeNotQuarantined                  <- ICNQ
      CumulativeModelInfected_dot               <- ICI
      CumulativeTestIncidence_dot               <- ICTI
      CumulativeTestsPositive_dot               <- ICTP
      ExpectedICUExits_dot                      <- CEICUE
      Exposed01_dot                             <- IR - E01
      Exposed02_dot                             <- E01 - E02
      InHospital01_dot                          <- EntHos - EXH01a - EXH01b
      InHospital02_dot                          <- EXH01b - EXH02
      InHospital03_dot                          <- EXH02 - EXH03
      InHospitalSevere_dot                      <- EXH01a - IHS01 - IHS02
      InfectedPresymptomatic01_dot              <- E02 - IP01
      InfectedPresymptomatic02_dot              <- IP01 - IP02a - IP02b - IP02c - IP02d
      NotQuarantineInfectious01_dot             <- IP02d - NQI1
      NotQuarantineInfectious02_dot             <- NQI1 - NQI2
      PhysicalDistancingSmoothedValue_dot       <- CPDSV
      RemovedAsymptomatic_dot                   <- ASI2
      RemovedAwaitingResult_dot                 <- EntRem
      RemovedHospital_dot                       <- EXH03
      RemovedNotQuarantine_dot                  <- NQI2
      RemovedSevereCasesHospital_dot            <- SCH02
      RemovedSevereCasesICU_dot                 <- ICU02
      RemovedSymptomaticImmediateIsolation_dot  <- SII02
      SevereCasesHospital01_dot                 <- IHS02 - SCH01
      SevereCasesHospital02_dot                 <- SCH01 - SCH02
      SevereCasesICU01_dot                      <- IHS01 - ICU01
      SevereCasesICU02_dot                      <- ICU01 - ICU02
      Susceptible_dot                           <- - IR
      SymptomaticImmediateIsolation01_dot       <- IP02b - SII01
      SymptomaticImmediateIsolation02_dot       <- SII01 - SII02


    deriv_updates <- c(AsymptomaticInfected01_dot,
                       AsymptomaticInfected02_dot,
                       AwaitingResults01_dot,
                       AwaitingResults02_dot,
                       CumulativeImmediateIsolation,
                       CumulativeInfectiousAsymptomatic,
                       CumulativeNotQuarantined,
                       CumulativeModelInfected_dot,
                       CumulativeTestIncidence_dot,
                       CumulativeTestsPositive_dot,
                       ExpectedICUExits_dot,
                       Exposed01_dot,
                       Exposed02_dot,
                       InHospital01_dot,
                       InHospital02_dot,
                       InHospital03_dot,
                       InHospitalSevere_dot,
                       InfectedPresymptomatic01_dot,
                       InfectedPresymptomatic02_dot,
                       NotQuarantineInfectious01_dot,
                       NotQuarantineInfectious02_dot,
                       PhysicalDistancingSmoothedValue_dot,
                       RemovedAsymptomatic_dot,
                       RemovedAwaitingResult_dot,
                       RemovedHospital_dot,
                       RemovedNotQuarantine_dot,
                       RemovedSevereCasesHospital_dot,
                       RemovedSevereCasesICU_dot,
                       RemovedSymptomaticImmediateIsolation_dot,
                       SevereCasesHospital01_dot,
                       SevereCasesHospital02_dot,
                       SevereCasesICU01_dot,
                       SevereCasesICU02_dot,
                       Susceptible_dot,
                       SymptomaticImmediateIsolation01_dot,
                       SymptomaticImmediateIsolation02_dot)

    ret_list <- list(deriv_updates,
                     EffectofPhysicalDistancingonBeta=EffectofPhysicalDistancingonBeta,
                     PhysicalDistancingFractionalReductionAmount=PhysicalDistancingFractionalReductionAmount,
                     CheckSumPopulation=CheckSumPopulation,
                     Beta=Beta,
                     Beta_h=sim_state$P_beta_mult_h,
                     Beta_i=sim_state$P_beta_mult_i,
                     Beta_j=sim_state$P_beta_mult_j,
                     Beta_k=sim_state$P_beta_mult_k,
                     Lambda=Lambda,
                     IR=IR,
                     TotalExposed=TotalExposed,
                     TotalInfectious=TotalInfectious,
                     TotalRemoved=TotalRemoved,
                     TotalSevereinNonICUHospital=TotalSevereinNonICUHospital,
                     TotalSevereinICU=TotalSevereinICU,
                     AdditionalICUPlacesRequired
                     )
  })
}
