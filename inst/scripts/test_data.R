library(seirR)
library(ggplot2)
library(tidyr)


ds <- filter(data_env$covid_data,
             Country %in% c("Ireland",
                            "South Korea"))

ds_piv <- ds %>% pivot_longer(-c(Date,Country),names_to ="Measure",values_to = "Number") %>%
                 filter(Measure %in% c("ReportedNewDeaths"))


ggplot(ds_piv,aes(x=Date,y=Number,colour=Measure))+
  facet_grid(Country~Measure)+
  geom_point()+geom_line()


