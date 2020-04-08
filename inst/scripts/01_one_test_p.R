library(seirR)
library(ggplot2)

mod <- create_seir_p()

summary(mod)
out1 <- run(mod,return_all = T)


ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")

