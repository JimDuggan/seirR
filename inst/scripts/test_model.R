library(seirR)

mod <- create_seir()

out <- run(mod, start=0, finish = 30)

ds <- filter(world_covid_data,Country %in% c("Ireland","Italy","South Korea","Germany","United Kingdom",
                                             "United States"))


ggplot(ds,aes(x=Date,y=ReportedNewCases,colour=Country))+geom_point()+geom_smooth()
