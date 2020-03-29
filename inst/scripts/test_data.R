library(seirR)
library(ggplot2)

ds <- filter(world_covid_data,
             Country %in% c("Ireland",
                            "Italy",
                            "South Korea",
                            "Germany",
                            "United Kingdom"))


ggplot(ds,aes(x=Date,y=ReportedNewCases,colour=Country))+
  geom_point()+geom_smooth()


