#-------------------------------------------------------------------------------------
#' Creates the initial state vector for population ODE
#'
#' @return A vector of compartments and their initial conditions
init_compartments_p <- function(){
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
