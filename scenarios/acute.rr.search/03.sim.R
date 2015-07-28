
library("EpiModelHPC")
library("mardham2")

rm(list = ls())
load("scenarios/rdiffhet/est/nwstats.rda")
load("scenarios/rdiffhet/est/fit.rda")

param <- param.mard(nwstats = st)
init <- init.mard(nwstats = st)
control <- control.mard(nsteps = 10, nsims = 1, prevfull = TRUE,
                        save.other = NULL, save.network = FALSE,
                        verbose = TRUE, verbose.int = 1)

sim <- netsim(est, param, init, control)
# save(sim, file = "scenarios/rdiffhet/est/sim.rda")
summary(sim$epi$incid.acte)
