library(readsdr)
library(deSolve)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

mdl <- readsdr::read_xmile("data-raw/models/seir_p/v0.1/vensim/Test/test_pulse_train.xmile")

START <- mdl$description$parameters$start
FINISH <- 30
STEP <- mdl$description$parameters$dt

simtime <- seq(START, FINISH, by = STEP)

o1 <- data.frame(ode(y = mdl$deSolve_components$stocks,
                     times = simtime,
                     func = mdl$deSolve_components$func,
                     parms = mdl$deSolve_components$consts,
                     method = "euler"))

tidy_df <- o1 %>% select(-Net_growth) %>%
  pivot_longer(-time, names_to = "variable")

ggplot(tidy_df, aes(x = time, y = value, group = variable)) +
  geom_line(colour = "steelblue") +
  scale_y_continuous(labels = comma) +
  facet_wrap(~variable, scales = "free", ncol = 1) +
  theme_bw()
