# https://github.com/jandraor/readsdr
library(readsdr) # Sys.getenv("GITHUB_PAT") Sys.unsetenv("GITHUB_PAT")
library(stringr)
library(dplyr)

MODEL_ID <- "seir_p"

get_ptype_lookup <- function(){
  pl <- tibble::tibble(ParameterName=character(),
                       ParameterType=character())

  pl <- pl %>%
        dplyr::add_row(ParameterName="AT",                              ParameterType="Model")            %>%
        dplyr::add_row(ParameterName="Average_HLOS",                    ParameterType="HealthSystem")     %>%
        dplyr::add_row(ParameterName="Average_Wait_for_Results",        ParameterType="HealthSystem")     %>%
        dplyr::add_row(ParameterName="Beta_Calibrated",                 ParameterType="Transmission")     %>%
        dplyr::add_row(ParameterName="Beta_Multiplier_h",               ParameterType="Transmission")     %>%
        dplyr::add_row(ParameterName="Beta_Multiplier_i",               ParameterType="Transmission")     %>%
        dplyr::add_row(ParameterName="Beta_Multiplier_j",               ParameterType="Transmission")     %>%
        dplyr::add_row(ParameterName="Beta_Multiplier_k",               ParameterType="Transmission")     %>%
        dplyr::add_row(ParameterName="End_Time_of_Physical_Distancing",  ParameterType="Distancing")       %>%
        dplyr::add_row(ParameterName="Fraction_In_Hospital_Severe",     ParameterType="HealthSystem")     %>%
        dplyr::add_row(ParameterName="Fraction_in_Risk_Group",          ParameterType="Pathway")          %>%
        dplyr::add_row(ParameterName="ICU_Available_Capacity",          ParameterType="HealthSystem")     %>%
        dplyr::add_row(ParameterName="ICU_Residency_Time",              ParameterType="HealthSystem")     %>%
        dplyr::add_row(ParameterName="Incubation_Period_C",             ParameterType="Biological")       %>%
        dplyr::add_row(ParameterName="Lag_Time",                        ParameterType="Model")            %>%
        dplyr::add_row(ParameterName="Latent_Period_L",                 ParameterType="Biological")       %>%
        dplyr::add_row(ParameterName="Number_Seeds",                    ParameterType="InitialCondition") %>%
        dplyr::add_row(ParameterName="PDAT",                            ParameterType="Distancing")       %>%
        dplyr::add_row(ParameterName="Percentage_Reduction_of_Physical_Disancing",
                                                                        ParameterType="Distancing")       %>%
        dplyr::add_row(ParameterName="Physical_Distancing_Policy_Flag", ParameterType="Distancing")       %>%
        dplyr::add_row(ParameterName="Proportion_Asymptomatic_f",       ParameterType="Pathway")          %>%
        dplyr::add_row(ParameterName="Proportion_Hospitalised",         ParameterType="Pathway")          %>%
        dplyr::add_row(ParameterName="Proportion_Quarantined_q",        ParameterType="Pathway")          %>%
        dplyr::add_row(ParameterName="Proportion_Tested_t",             ParameterType="Pathway")          %>%
        dplyr::add_row(ParameterName="RTime_Severe",                    ParameterType="Model")            %>%
        dplyr::add_row(ParameterName="Start_Time_of_Physical_Distancing",
                                                                        ParameterType="Distancing")       %>%
        dplyr::add_row(ParameterName="Total_Infectious_Period_D",       ParameterType="Biological")       %>%
        dplyr::add_row(ParameterName="Total_Population",                ParameterType="InitialCondition") %>%
        dplyr::add_row(ParameterName="Distancing_Start_Time",           ParameterType="Distancing")       %>%
        dplyr::add_row(ParameterName="Distancing_Switch",               ParameterType="Distancing")       %>%
        dplyr::add_row(ParameterName="Pulse_Duration",                  ParameterType="Pulse")            %>%
        dplyr::add_row(ParameterName="Pulse_End",                       ParameterType="Pulse")            %>%
        dplyr::add_row(ParameterName="Pulse_Off_Duration",              ParameterType="Pulse")            %>%
        dplyr::add_row(ParameterName="Pulse_Switch",                    ParameterType="Pulse")            %>%
        dplyr::add_row(ParameterName="Switch_Time",                     ParameterType="Pulse")

     pl
}

get_param_type <- function(tbl, p_name){
  ans <- dplyr::filter(tbl,ParameterName==p_name) %>% pull(ParameterType)
  if(length(ans) > 0)
    ans
  else
    "Model"
}


create_parameter_tibble <- function(file){
  p_types <- "InitialCondition|Transmission|Biological|PathwayFlow|Distancing|HealthSystem|Model"
  p_lookup <- get_ptype_lookup()
  source(file)
  header <- paste0("library(dplyr)\n",
                "#-------------------------------------------------------------------------------------\n",
                "#' Populates the parameters tibble for seir_p \n",
                "#' NOTE: Edit this file to clarify parameter types \n",
                "xmile_setup_parameters <- function(){\n")

  lines<- paste0("\tp_tb <- tibble::tibble(ParameterName=character(),\n",
                          "\t\tParameterType=character(),\n",
                          "\t\tDescription=character(),\n",
                          "\t\tValue=numeric(),\n",
                          "\t\tUpperEstimate=numeric(),\n",
                          "\t\tLowerEstimate=numeric(),\n",
                          "\t\tVarying=logical(),\n",
                          "\t\tSource=character(),\n",
                          "\t\tValueS=character())\n\n")

  auxs <- xmile_get_constants()


  for (i in seq_along(auxs)){
    n_line <- paste0("\tp_tb <- dplyr::add_row(p_tb,\n",
                           "\t\tParameterName=",shQuote(names(auxs[i])),",\n",
                           "\t\tParameterType=",shQuote(get_param_type(p_lookup,names(auxs[i]))),",\n",
                           "\t\tDescription=",shQuote("TBD"),",\n",
                           "\t\tValue=",auxs[i],",\n",
                           "\t\tUpperEstimate=",auxs[i],",\n",
                           "\t\tLowerEstimate=",auxs[i],",\n",
                           "\t\tVarying=F,\n",
                           "\t\tSource=",shQuote("TBD"),")\n\n")
    lines <- paste0(lines,n_line)
  }

  # Need to hard code start and finish days

  n_line <- paste0("\tp_tb <- dplyr::add_row(p_tb,\n",
                       "\t\tParameterName=",shQuote("start_day"),",\n",
                       "\t\tParameterType=",shQuote("InitialCondition"),",\n",
                       "\t\tDescription=",shQuote("Start day of epidemic, see variable ValueS"),",\n",
                       "\t\tValue=1,\n",
                       "\t\tUpperEstimate=0,\n",
                       "\t\tLowerEstimate=0,\n",
                       "\t\tVarying=F,\n",
                       "\t\tSource=",shQuote("TBD"),",\n",
                       "\t\tValueS=",shQuote("2020-02-29"),")\n\n")

  lines <- paste0(lines,n_line)

  n_line <- paste0("\tp_tb <- dplyr::add_row(p_tb,\n",
                   "\t\tParameterName=",shQuote("end_day"),",\n",
                   "\t\tParameterType=",shQuote("InitialCondition"),",\n",
                   "\t\tDescription=",shQuote("End day of epidemic, see variable ValueS"),",\n",
                   "\t\tValue=300,\n",
                   "\t\tUpperEstimate=0,\n",
                   "\t\tLowerEstimate=0,\n",
                   "\t\tVarying=F,\n",
                   "\t\tSource=",shQuote("TBD"),",\n",
                   "\t\tValueS=",shQuote("TBD"),")\n\n")

  lines <- paste0(lines,n_line)

  paste0(header,lines,"\n\tp_tb\n}")
}
#------------------------------------------------
get_code <- function (c){
  # Need to update this.
  code_body<-deparse(body(c))
  #code_body<-paste0(code_body,"\n",collapse = "")
  part1 <- str_replace_all(code_body,"ZZ","sim_state$")

  # Now split this into two parts, before the return and after the return
  # Goal is to remove any sim$state tags from LHS of non-integral returns from
  # deSolve function. For some reason, some vars are lost, NEEDS UPDATE
  split_loc <- which(str_detect(part1,"return"))
  first <- paste0(part1[1:(split_loc)-1],collapse = "\n")
  #second <- part1[split_loc:length(part1)]
  second <- paste0(part1[split_loc:length(part1)],collapse = "\n")
  second<-str_replace_all(second,"sim_state\\$.+ =","")
  ans <-paste0(first,"\n",second,collapse="")

}
#------------------------------------------------
conv2vec <- function (v,LHS="Output<-",ASGN="sim_state$CompartmentsINIT <-")
{
  sapply(1:length(v),function(i){
    if(i == 1)
      pref <- paste0(LHS,ASGN, "c(")
    else
     pref <- ""

    if(i == length(v))
      post <- ")\n}\n"
    else
      post <- ","

    if(i>1) pref <- paste("\t",pref)

    paste(pref,names(v[i]),"=",v[i],post)
  })

}

#------------------------------------------------
conv2params <- function (v)
{
  header <- "set_model_parameters_xmile <- function(p){\n"
  body <-sapply(1:length(v),function(i){
    p_LHS <- paste0("\t",names(v[i]))
    p_RHS <- paste0("get_param(p,",shQuote(names(v[i])),")")
    p_RHS <- str_replace_all(p_RHS,"ZZ","")
    full<-paste(p_LHS," <-", p_RHS,"\n")
    str_replace_all(full,"ZZ","sim_state$")
  })
  tail<-"}\n"
  paste(c(header, body, tail),collapse = "")
}

#mdl <- readsdr::read_xmile("inst/models/seir_p/v0.1/vensim/SEIR_IRL_Population_V0.1.xmile")
mdl <- readsdr::read_xmile("data-raw/models/seir_p/v0.1/vensim/SEIR_IRL_Population_V0.1.xmile")
#mdl <- readsdr::read_xmile("data-raw/models/seir_p/v0.2/vensim/xmile/SEIR_IRL_Population_V0.2.xmile")
#mdl <- readsdr::read_xmile("data-raw/models/seir_p/v0.2/vensim/test/test_pulse_train.xmile")


##########################################################################################
#  OUTPUT FILE 1/5: XMILE_MODEL_SEIR_P.R
#                   Contains the differential equations
##########################################################################################
LHS_M <- paste0("library(deSolve)\n",
                "#-------------------------------------------------------------------------------------\n",
                "#' The set of ODEs to solve for the model\n",
                "#' \n",
                "#' model_seir_p Solves the population model for each timestep, is called by ode\n",
                "#' @param time is the current simulation time\n",
                "#' @param stocks is the vector of model compartments\n",
                "#' @param auxs vector of auxiliaries (alway NULL) as these are passed via sim_state environment\n",
                "#' @return list of new compartment values, and other relevant variables\n",
                "model_xmile_seir_p <- function(time, stocks, auxs){\n")
file_name <- paste0("R/xmile_01_model_",MODEL_ID,".R")
fileConn<-file(file_name)
code_body<-get_code(mdl$deSolve_components$func)
code <- paste0(LHS_M,code_body,"\n}")
writeLines(code,fileConn)
close(fileConn)

##########################################################################################
#  OUTPUT FILE 2/5: XMILE_INIT_COMPARTMENTS_SEIR_P.R
#                   Contains all the integrals and their initial values
#                   Needed before ode is called
##########################################################################################
LHS <- paste0("#-------------------------------------------------------------------------------------\n",
              "#' Creates the initial state vector for population ODE\n",
              "#\n",
              "#' @return A vector of compartments and their initial conditions\n",
              "init_compartments_p_xmile <- function(){\n")
file_name <- paste0("R/xmile_02_init_compartments_",MODEL_ID,".R")
fileConn<-file(file_name)
writeLines(as.character(conv2vec(mdl$deSolve_components$stocks,LHS)),fileConn)
close(fileConn)

##########################################################################################
#  OUTPUT FILE 3/5: XMILE_SET_MODEL_PARAMETERS.R
#                   Write a file that loads the model params into the S3 params table
#                   This file needs a small amount of editing
##########################################################################################
# Output the constants
file_name <- paste0("R/xmile_03_set_model_parameters_",MODEL_ID,".R")
fileConn<-file(file_name)
auxs <- c(mdl$deSolve_components$consts,ZZstart_day=1,ZZend_day=300)
writeLines(conv2params(auxs),fileConn)
close(fileConn)

##########################################################################################
#  OUTPUT FILE 4/5: XMILE_GET_CONSTANTS.R
#                   Write a file allows all the parameters to be returned as a vector
#                   Used during the translation process.
##########################################################################################
LHS <- paste0("#-------------------------------------------------------------------------------------\n",
              "#' Creates the vector of constants that can be used to set params\n",
              "#' @return A vector of constants and their initial conditions\n",
              "xmile_get_constants <- function(){\n")
file_name <- paste0("R/xmile_04_get_constants_",MODEL_ID,".R")
fileConn<-file(file_name)
auxs <- c(mdl$deSolve_components$consts)
code_block <- as.character(conv2vec(auxs,LHS,ASGN = ""))
code_block <- str_replace_all(code_block,"ZZ","")
writeLines(code_block,fileConn)
close(fileConn)


##########################################################################################
#  OUTPUT FILE 5/5: XMILE_SETUP.R
#                   Creates the tibble for params
##########################################################################################
target <- paste0("R/xmile_04_get_constants_",MODEL_ID,".R")
content <- create_parameter_tibble(target)
file_name <- paste0("R/xmile_05_setup_",MODEL_ID,".R")
fileConn<-file(file_name)
writeLines(content,fileConn)
close(fileConn)


