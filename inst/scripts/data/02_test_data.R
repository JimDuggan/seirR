library(seirR)
library(ggplot2)
library(tidyr)
library(dplyr)

countries <- c("South Korea")

# czech mask date march 19th http://www.xinhuanet.com/english/2020-03/30/c_138929089.htm
# austria mask date

ds <- filter(data_env$covid_data,
             Country %in% countries)

ds_piv <- ds %>% pivot_longer(-c(Date,Country),names_to ="Measure",values_to = "Number") %>%
              filter(Measure %in% c("ReportedNewCases")) %>%
              filter(Date>"2020-01-25")


ggplot(ds_piv,aes(x=Date,y=Number,colour=Country))+
  geom_point()+geom_line()+geom_smooth()+
  geom_vline(xintercept =ymd("2020-03-19"),colour="blue",linetype="dashed")


