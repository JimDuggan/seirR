library(seirR)
library(ggplot2)
library(purrr)

# create the model
mod <- create_seir_p()
mod <- set_param(mod,"distancing_flag",1)

NRUNS <- 5

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

ggplot(res_full,aes(x=Date,y=Reported_Incidence,colour=RunNumber,group=RunNumber))+geom_path()+
       scale_colour_gradientn(colours=rainbow(12))+guides(color=FALSE)


