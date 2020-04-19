library(dplyr)
library(socialmixr)
library(stringr)

load_social_contacts <- function(){
  lower_lims <- stringr::str_split(age_data$AgeCohort, "-|\\+")
  lower_lims <- sapply(lower_lims,function(interval) interval[[1]])

  age_data$lower.age.limit <- as.numeric(lower_lims)

  suppressMessages(scenario_1 <- socialmixr::contact_matrix(socialmixr::polymod,
                                                            age.limits = c(0, 19, 65),
                                                            countries = "Great Britain",
                                                            survey.pop = age_data,
                                                            symmetric = TRUE))

 rownames(scenario_1$matrix) <- colnames(scenario_1$matrix)

 suppressMessages(scenario_2 <- socialmixr::contact_matrix(socialmixr::polymod,
                                                           age.limits = c(0, 19, 65),
                                                           countries = "Great Britain",
                                                           survey.pop = age_data,
                                                           symmetric = F))

 rownames(scenario_2$matrix) <- colnames(scenario_2$matrix)
 list(Symmetric=scenario_1,Non_Symmetric=scenario_2)
}







