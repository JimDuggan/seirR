library(seirR)
library(ggplot2)
library(tidyr)
library(dplyr)

countries <- c("South Korea")

ds <- filter(data_env$covid_data,
             Country %in% countries)

ds_piv <- ds %>% pivot_longer(-c(Date,Country),names_to ="Measure",values_to = "Number") %>%
              filter(Measure %in% c("ReportedNewCases","ReportedNewDeaths"))


ggplot(ds_piv,aes(x=Date,y=Number,colour=Measure))+
  geom_point()+geom_line()


