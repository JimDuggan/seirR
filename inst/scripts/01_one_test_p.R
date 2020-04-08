library(seirR)
library(ggplot2)

mod <- create_seir_p()

summary(mod)
out1 <- run(mod)

vars <- c("Reported_Incidence","Total_Infectious")

ca <- get_curve_analysis(out1,vars)

ggplot(ca,aes(x=SimDay,y=Value,colour=Behaviour))+geom_point()+facet_grid(Variable~.)


ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")

