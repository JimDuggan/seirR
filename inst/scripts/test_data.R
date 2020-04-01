library(seirR)
library(ggplot2)
library(tidyr)

countries <- c("Ireland")

ds <- filter(data_env$covid_data,
             Country %in% countries)

ds_piv <- ds %>% pivot_longer(-c(Date,Country),names_to ="Measure",values_to = "Number") %>%
              filter(Measure %in% c("ReportedNewCases","ReportedNewDeaths"))


ggplot(ds_piv,aes(x=Date,y=Number,colour=Measure))+
  geom_point()+geom_line()

ccf(ds$ReportedNewCases,ds$ReportedNewDeaths)
lag2.plot (ds$ReportedNewCases,ds$ReportedNewDeaths, 10)


