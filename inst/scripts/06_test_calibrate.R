library(seirR)
library(ggplot2)
library(readsdr)
#   L  = 3.58
#   Cv = 5.79
#   Dv = 5.46
#    h = 0.11
#    i = 0.07
#    j = 0.0613263
#    f = 0.25
#    tv = 0.55
#    q  = 0.21
#    T  = 3.16
#    Beta = 0.91
#    R0   = 3.85
#    Lambda = 0.26
#    Offset = 11 (rounded)


mod <- create_seir_p(model_offset = 11)

# Modify Biological Parameters
mod <- set_param(mod,"Latent_Period_L",3.58)
mod <- set_param(mod,"Incubation_Period_C",5.79)
mod <- set_param(mod,"Total_Infectious_Period_D",5.46)

# Modify Transmission Parameters
mod <- set_param(mod,"Beta_Calibrated",0.91)
mod <- set_param(mod,"Beta_Multiplier_h",0.11)
mod <- set_param(mod,"Beta_Multiplier_i",0.07)
mod <- set_param(mod,"Beta_Multiplier_j",0.0613263)

# Modify Pathway Parameters
mod <- set_param(mod,"Proportion_Asymptomatic_f",0.25)
mod <- set_param(mod,"Proportion_Tested_t",0.55)
mod <- set_param(mod,"Proportion_Quarantined_q",0.21)

# Modify Health System Parameters
mod <- set_param(mod,"Average_Wait_for_Results",3.16)

# Modify Pulse Switch time (i.e. also he time that distancing ends)
mod <- set_param(mod,"Switch_Time",200)
mod <- set_param(mod,"Distancing_Switch",1)

summary(mod)
out1 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")
