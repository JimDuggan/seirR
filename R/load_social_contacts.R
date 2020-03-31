library(dplyr)
library(socialmixr)
library(stringr)

load_social_contacts <- function(){
  lower_lims <- stringr::str_split(age_data$AgeCohort, "-|\\+") %>%
  sapply(function(interval) interval[[1]])

  age_data$lower.age.limit <- as.numeric(lower_lims)

  suppressMessages(scenario_1 <- socialmixr::contact_matrix(socialmixr::polymod,
                                                            age.limits = c(0, 5, 15, 65),
                                                            countries = "Great Britain",
                                                            survey.pop = age_data,
                                                            symmetric = TRUE))

  data_env$IRL_POLYMOD <- scenario_1
}







