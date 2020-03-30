library(seirR)
library(ggplot2)

mod <- create_seir()

out1 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=Date,y=TotalInfectious),colour="red")



