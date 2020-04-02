library(seirR)
library(ggplot2)
library(dplyr)

mod <- create_seir_p()
mod <- set_param(mod,"end_day",140)

out1 <- run(mod)

weekly <- out1 %>% select(SimDay,Date,Week,ReportedIncidence) %>%
                   group_by(Week) %>%
                   summarise(WeeklyReportedIncidence=sum(ReportedIncidence),
                             WeekDate=max(Date)) %>%
                   arrange(Week)

ggplot(weekly,aes(x=WeekDate,y=WeeklyReportedIncidence))+geom_point()+geom_line()




