library(seirR)
library(ggplot2)

ds <- filter(data_env$covid_data,
             Country %in% c("Ireland",
                            "South Korea"))


ggplot(ds,aes(x=Date,y=ReportedNewDeaths,colour=Country))+
  geom_point()+geom_smooth()


