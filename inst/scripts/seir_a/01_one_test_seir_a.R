library(seirR)
library(ggplot2)
library(readsdr)
library(tidyr)

mod <- create_seir_a(model_offset = 8)

# ZZBeta Multiplier h = 1
# ZZProportion Asymptomatic f = 0.2
# ZZSymptomatic Testing Fraction = 1
# ZZIncubation Period C = 5
# ZZLatent Period L = 3.4
# ZZTotal Infectious Period D = 5.8535
# ZZBeta Calibrated = 0.7366
# *ZZReporting Delay = 1

summary(mod)

mod <- set_param(mod,"Proportion_Asymptomatic_f",0.2)
mod <- set_param(mod,"Symptomatic_Testing_Fraction",1)
mod <- set_param(mod,"Incubation_Period_C",5)

out1 <- run(mod)

test <- out1 %>% filter(Date<="2020-03-17") %>% select(Date,ReportedTotalCases,CumulativeCases)
t1 <- test %>% pivot_longer(-Date,names_to = "Variable", values_to = "Value")
ggplot(t1,aes(x=Date,y=Value,colour=Variable))+geom_point()+geom_line()
