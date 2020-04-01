library(seirR)
library(ggplot2)

mod <- create_seir_p(model_offset = 10)

out1 <- run(mod)

mod <- set_param(mod,"distancing_flag",1)
mod <- set_param(mod,"pd_percentage_reduction",.3)
out2 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=Date,y=TotalInfectious),colour="red")+
  geom_line(out2,mapping=aes(x=Date,y=TotalInfectious),colour="blue")



