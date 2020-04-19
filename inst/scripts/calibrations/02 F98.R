library(seirR)
library(ggplot2)
library(readsdr)
library(dplyr)
#   L  = 3.77
#   Cv = 5.83
#   Dv = 8.91
#    h = 0.09
#    i = 0.08
#    j = 0.069
#    f = 0.98
#    tv = 0.94
#    q  = 0.02
#    T  = 5.88
#    Beta = 1.33
#    R0   = 3.67


mod <- create_seir_p1(model_offset = 10)

# Modify Biological Parameters
mod <- set_param(mod,"Latent_Period_L",3.77)
mod <- set_param(mod,"Incubation_Period_C",5.83)
mod <- set_param(mod,"Total_Infectious_Period_D",8.91)

# Modify Transmission Parameters
mod <- set_param(mod,"Beta_Calibrated",1.33)
mod <- set_param(mod,"Beta_Multiplier_h",0.09)
mod <- set_param(mod,"Beta_Multiplier_i",0.08)
mod <- set_param(mod,"Beta_Multiplier_j",0.069)
mod <- set_param(mod,"R0_Fixed_Flag",1)
mod <- set_param(mod,"R0_Input",3.67)

# Modify Pathway Parameters
mod <- set_param(mod,"Distancing_Switch",0)
mod <- set_param(mod,"Proportion_Asymptomatic_f",0.98)
mod <- set_param(mod,"Proportion_Tested_t",0.94)
mod <- set_param(mod,"Proportion_Quarantined_q",0.02)

# Modify Health System Parameters
mod <- set_param(mod,"Average_Wait_for_Results",5.88)

summary(mod)
out1 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")

test <- out1 %>% filter(Reported_Incidence==max(Reported_Incidence)) %>%
  select(SimDay,Date,Reported_Incidence,R0_Input) %>% mutate(DaysSinceFeb29=Date-(ymd("2020-02-29")))


print(test)
