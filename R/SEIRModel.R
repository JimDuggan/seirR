library(deSolve)

seir_model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    Checksum = Susceptible + Exposed_01 + Exposed_02 +
      Infected_01 + Infected_02 + Infected_03 +
      Removed

    FractionReduction <- gSD_FR_REDUCTION [floor(time)]
    BetaModified  <-  gBeta - (gBeta*gFlagDistancing*FractionReduction);

    FOI <-  (BetaModified * Infected_01  +
               BetaModified * Infected_02  +
               BetaModified * gSelfIsolationEffectiveness * Infected_03)/gTotalPopulation;

    TotalOutflowInfected_01 <- Infected_01 * 2 * gGAMMA;

    FlowToInfected_02 <- (1 - gFractionIsolating * gFlagSelfIsolation ) * TotalOutflowInfected_01;
    FlowToInfected_03 <- gFlagSelfIsolation * gFractionIsolating * TotalOutflowInfected_01;


    # Susceptible compartment equations
    dS_dt   <-  -FOI * Susceptible;

    # Exposed compartments equations
    dE1_dt <-  FOI * Susceptible - Exposed_01*2*gSIGMA;
    dE2_dt <-  Exposed_01*2*gSIGMA -  Exposed_02*2*gSIGMA;

    # Infectious compartments equations
    dI1_dt    = Exposed_02*2*gSIGMA - TotalOutflowInfected_01;
    dI2_dt    = FlowToInfected_02  - Infected_02 * 2 * gGAMMA;
    dI3_dt    = FlowToInfected_03 - Infected_03 * 2 * gGAMMA;

    # Recovered compartment equation
    dR_dt   = Infected_02 * 2 * gGAMMA + Infected_03 * 2 * gGAMMA;

    # Total Infected Compartment equations
    dTI_dt  = Exposed_02*2*gSIGMA;

    ret_list <- list(c(dS_dt,
                       dE1_dt,
                       dE2_dt,
                       dI1_dt,
                       dI2_dt,
                       dI3_dt,
                       dR_dt,
                       dTI_dt),
                     TotalPopulation=gTotalPopulation,
                     TotalInfected=Infected_01+Infected_02+Infected_03,
                     R0=gR0,
                     Sigma=gSIGMA,
                     Gamma=gGAMMA,
                     Beta=gBeta,
                     FractionReduction=FractionReduction,
                     BetaModified=BetaModified,
                     FOI=FOI,
                     DistancingFlag=gFlagDistancing,
                     IsolatingFlag=gFlagSelfIsolation,
                     IsolationEffectiveness=gSelfIsolationEffectiveness,
                     FractionIsolating=gFractionIsolating,
                     CheckSum=Checksum)

    return (ret_list)
  })
}
