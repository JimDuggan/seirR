library(seirR)
library(ggplot2)
library(purrr)
library(dplyr)

# create the model
mod <- create_seir_p()
mod <- set_param(mod,"Distancing_Switch",1)
mod <- set_param(mod,"Switch_Time",300) # time to end continuous physcial distancing

NRUNS <- 30

lower <- 0.2
upper <- 0.8
percentages    <- runif(NRUNS,.1,.9)
f_asymptomatic <- runif(NRUNS,.15,.7)

res_full <- map_df(1:NRUNS, function(i){
  cat("iteration = ", i, "with percentage = ", percentages[i], " and f = ",f_asymptomatic[i],"\n")
  mod <- set_param(mod,"Percentage_Reduction_of_Physical_Disancing",percentages[i])
  mod <- set_param(mod,"Proportion_Asymptomatic_f",f_asymptomatic[i])
  out2 <- run(mod) %>% mutate(RunNumber=i) %>%
     select(RunNumber,everything())
})

ggplot(res_full,aes(x=SimDay,y=Reported_Incidence,colour=RunNumber,group=RunNumber))+geom_path()+
       scale_colour_gradientn(colours=rainbow(12))+guides(color=FALSE)

res_peaking <- res_full %>%
  group_by(RunNumber) %>%
  summarise(Peak_RI=max(Reported_Incidence),
            Peak_Time=which.max(Reported_Incidence))

ggplot(res_peaking %>% filter(Peak_RI>400),
       aes(x=Peak_Time,y=Peak_RI)) +
  geom_point() + geom_density_2d()

