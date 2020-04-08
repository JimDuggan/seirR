library(seirR)
library(ggplot2)

mod <- create_seir_p(model_offset = 10)

out1 <- run(mod)

mod <- set_param(mod,"Physical_Distancing_Policy_Flag",0)
out2 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=Date,y=Reported_Incidence),colour="red")+
  geom_line(out2,mapping=aes(x=Date,y=Reported_Incidence),colour="blue")



