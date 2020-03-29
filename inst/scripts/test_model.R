library(seirR)
library(ggplot2)

mod <- create_seir()

out1 <- run(mod,return_all = F)

mod <- set_param(mod,"distancing_flag",1)
mod <- set_param(mod,"pd_percentage_reduction",.3)
out2 <- run(mod,return_all = F)

ggplot()+geom_line(out1,mapping=aes(x=Date,y=TotalInfectious),colour="red")+
  geom_line(out2,mapping=aes(x=Date,y=TotalInfectious),colour="blue")
