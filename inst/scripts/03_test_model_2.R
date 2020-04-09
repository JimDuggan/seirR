library(seirR)
library(ggplot2)
library(readsdr)

cat("Step 1, creating model...\n")
mod <- create_seir_p()

cat("Step 2, Run model 1...\n")
out1 <- run(mod)

cat("Step 2, Run model 2...\n")
mod <- set_param(mod,"Distancing_Switch",1)
mod <- set_param(mod,"Percentage_Reduction_of_Physical_Disancing",.5)
out2 <- run(mod)

cat("Step 2, Run model 3...\n")
mod <- set_param(mod,"Pulse_Switch",1)
out3 <- run(mod)


ggplot()+geom_line(out1,mapping=aes(x=SimDay,y=Reported_Incidence),colour="red")+
  geom_line(out2,mapping=aes(x=SimDay,y=Reported_Incidence),colour="blue")+
  geom_line(out3,mapping=aes(x=SimDay,y=Reported_Incidence),colour="green")



