library(seirR)
library(ggplot2)

mod <- create_seir_p()

out1 <- run(mod)

mod <- set_param(mod,"distancing_flag",1)
out2 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=ReportedIncidence),colour="red")+
  geom_line(out2,mapping=aes(x=SimDay,y=ReportedIncidence),colour="blue")




