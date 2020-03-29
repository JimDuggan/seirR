library(seirR)

mod <- create_seir()

out <- run(mod, start=0, finish = 20)
