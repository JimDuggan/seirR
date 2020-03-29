library(deSolve)
#-------------------------------------------------------------------------------------
#' The set of ODEs to solve for the model
#'
#' \code{seir_model} Solves the model for each timestep, is called by \code{ode}
#' @param time is the current simulation time
#' @param stocks is the vector of model compartments
#' @param auxs vector of auxiliaries (alway NULL) as these are passed via \code{sim_state} environment
#' @return list of new compartment values, and other relevant variables
seir_model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{


    # Calculate the derivatives
    AsymptomaticInfected01_dot                <- 10
    AsymptomaticInfected02_dot                <- 0
    AwaitingResults01_dot                     <- 0
    AwaitingResults02_dot                     <- 0
    CumulativeImmediateIsolation              <- 0
    CumulativeInfectiousAsymptomatic          <- 0
    CumulativeNotQuarantined                  <- 0
    CumulativeModelInfected_dot               <- 0
    CumulativeTestIncidence_dot               <- 0
    CumulativeTestsPositive_dot               <- 0
    ExpectedICUExits_dot                      <- 0
    Exposed01_dot                             <- 0
    Exposed02_dot                             <- 0
    InHospital01_dot                          <- 0
    InHospital02_dot                          <- 0
    InHospital03_dot                          <- 0
    InHospitalSevere_dot                      <- 0
    InfectedPresymptomatic01_dot              <- 0
    InfectedPresymptomatic02_dot              <- 0
    NotQuarantineInfectious01_dot             <- 0
    NotQuarantineInfectious02_dot             <- 0
    PhysicalDistancingSmoothedValue_dot       <- 0
    RemovedAsymptomatic_dot                   <- 0
    RemovedAwaitingResult_dot                 <- 0
    RemovedHospital_dot                       <- 0
    RemovedNotQuarantine_dot                  <- 0
    RemovedSevereCasesHospital_dot            <- 0
    RemovedSevereCasesICU_dot                 <- 0
    RemovedSymptomaticImmediateIsolation_dot  <- 0
    SevereCasesHospital01_dot                 <- 0
    SevereCasesHospital02_dot                 <- 0
    SevereCasesICU01_dot                      <- 0
    SevereCasesICU02_dot                      <- 0
    Susceptible_dot                           <- 0
    SymptomaticImmediateIsolation01_dot       <- 0
    SymptomaticImmediateIsolation02_dot       <- 0


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

    ret_list <- list(deriv_updates)
  })
}
