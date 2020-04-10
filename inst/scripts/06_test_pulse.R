library(seirR)
library(ggplot2)
library(readsdr)
library(tidyr)

mod <- create_seir_p()

mod <- set_param(mod,"Distancing_Switch",1)
mod <- set_param(mod,"Pulse_Switch",1)
mod <- set_param(mod,"Switch_Time",60) # time to end continuous physcial distancing
mod <- set_param(mod,"Percentage_Reduction_of_Physical_Distancing",.6)

out1 <- run(mod)

tb <- out1 %>% select(SimDay,Reported_Incidence,Physical_Distancing_Smoothed_Value,Pulse_Policy) %>%
               pivot_longer(-SimDay,names_to="Variable", values_to = "Value")
ggplot(tb,aes(x=SimDay,y=Value,colour=Variable))+
  facet_grid(Variable~.,scales = "free_y")+
  geom_point()+geom_line()+guides(colour=NULL)



ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")
ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Physical_Distancing_Smoothed_Value),colour="red")



