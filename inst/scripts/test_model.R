library(seirR)
library(ggplot2)

mod <- create_seir_p()

out1 <- run(mod)

mod <- set_param(mod,"distancing_flag",1)
mod <- set_param(mod,"pd_percentage_reduction",.3)
out2 <- run(mod)

mod <- set_param(mod,"pd_percentage_reduction",.5)
out3 <- run(mod)

mod <- set_param(mod,"pd_percentage_reduction",.6)
out4 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=TotalInfectious),colour="red")+
  geom_line(out2,mapping=aes(x=SimDay,y=TotalInfectious),colour="blue")+
  geom_line(out3,mapping=aes(x=SimDay,y=TotalInfectious),colour="green")+
  geom_line(out4,mapping=aes(x=SimDay,y=TotalInfectious),colour="black")



