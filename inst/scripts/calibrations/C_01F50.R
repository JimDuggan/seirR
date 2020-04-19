library(seirR)
library(ggplot2)
library(readsdr)
library(dplyr)
#   L  = 3.56
#   Cv = 5.55
#   Dv = 5.34
#    h = 0.11
#    i = 0.0058
#    j = 0.069
#    f = 0.5
#    tv = 0.99
#    q  = 0.0028
#    T  = 3.21
#    Beta = 0.97
#    R0   = 3.67

mod <- create_seir_p(model_offset = 10)

# Modify Biological Parameters
mod <- set_param(mod,"Latent_Period_L",3.56)
mod <- set_param(mod,"Incubation_Period_C",5.55)
mod <- set_param(mod,"Total_Infectious_Period_D",5.34)

# Modify Transmission Parameters
mod <- set_param(mod,"Beta_Calibrated",0.97)
mod <- set_param(mod,"Beta_Multiplier_h",0.11)
mod <- set_param(mod,"Beta_Multiplier_i",0.0058)
mod <- set_param(mod,"Beta_Multiplier_j",0.0619)
mod <- set_param(mod,"R0_Fixed_Flag",1)
mod <- set_param(mod,"R0_Input",3.67)

# Modify Pathway Parameters
mod <- set_param(mod,"Distancing_Switch",0)
mod <- set_param(mod,"Proportion_Asymptomatic_f",0.5)
mod <- set_param(mod,"Proportion_Tested_t",0.99)
mod <- set_param(mod,"Proportion_Quarantined_q",0.0028)

# Modify Health System Parameters
mod <- set_param(mod,"Average_Wait_for_Results",3.67)

summary(mod)
out1 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")

test <- out1 %>% filter(Reported_Incidence==max(Reported_Incidence)) %>%
  select(SimDay,Date,Reported_Incidence,R0_Input) %>% mutate(DaysSinceFeb29=Date-(ymd("2020-02-29")))


print(test)
