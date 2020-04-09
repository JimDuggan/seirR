library(seirR)
library(ggplot2)
library(readsdr)

mod <- create_seir_p()

summary(mod)
out1 <- run(mod)

ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")

vars <- c("Reported_Incidence")

ca <- get_curve_analysis(out1,vars)

ggplot(ca,aes(x=SimDay,y=Value,colour=Behaviour))+geom_point()+facet_grid(Variable~.)

