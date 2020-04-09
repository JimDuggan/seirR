library(seirR)
library(ggplot2)
library(dplyr)
library(readsdr)

mod <- create_seir_p()
mod <- set_param(mod,"end_day",140)

out1 <- run(mod)

weekly <- out1 %>% select(SimDay,Date,Week,Reported_Incidence) %>%
                   group_by(Week) %>%
                   summarise(WeeklyReportedIncidence=sum(Reported_Incidence),
                             WeekDate=max(Date)) %>%
                   arrange(Week)

ggplot(weekly,aes(x=WeekDate,y=WeeklyReportedIncidence))+geom_point()+geom_line()




