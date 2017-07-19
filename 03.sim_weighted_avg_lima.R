
## Packages

library(methods)
#library("EpiModelHPC")
library("Mardham")

## Parameters

fsimno <- 1018.1
load("fit_weighted_avg.rda")

nodemix.m <- c(st$stats.m[1] - st$stats.m[2] - st$stats.m[3],
               st$stats.m[2], st$stats.m[3])
nodemix.p <- c(st$stats.p[1] - st$stats.p[2] - st$stats.p[3],
               st$stats.p[2], st$stats.p[3])
nodemix.i <- c(st$stats.i[1] - st$stats.i[2] - st$stats.i[3],
               st$stats.i[2], st$stats.i[3])

param <- param.mard(nwstats = st, 
					acute.rr = 6.0, 
					vl.acute.rise.int = 45,
					vl.acute.fall.int = 45,
					
					last.neg.test.B.int = 365.25,
					mean.test.B.int = 365.25,
					last.neg.test.W.int = 365.25,
					mean.test.W.int = 365.25,
					test.window.int = 45,
					
					tt.traj.B.prob = c(0.15, 0, 0.1445, 0.7055),
					tt.traj.W.prob = c(0.15, 0, 0.1445, 0.7055),
					
					tx.init.B.prob = 0.0425,
					tx.init.W.prob = 0.0425,
					tx.halt.B.prob = 0.0071,
					tx.halt.W.prob = 0.0071,
					tx.reinit.B.prob = 0.0005,
					tx.reinit.W.prob = 0.0005,
					
					b.B.rate = 0.0443 / 365.25,
					b.W.rate = 0.0443 / 365.25,
					
					disc.outset.main.B.prob = 0.526,
					disc.outset.main.W.prob = 0.526,
					disc.outset.pers.B.prob = 0.342,
					disc.outset.pers.W.prob = 0.342,
					disc.inst.B.prob = 0.198,
					disc.inst.W.prob = 0.198,
					
					circ.B.prob = 0.06,
					circ.W.prob = 0.06,
					
					ccr5.B.prob = c(0.01, 0.035),
					ccr5.W.prob = c(0.01, 0.035),
					
					num.inst.ai.classes = 1,
					base.ai.main.BB.rate = 0.30,
					base.ai.main.BW.rate = 0.32175,
					base.ai.main.WW.rate = 0.3375,
					base.ai.pers.BB.rate = 0.09,
					base.ai.pers.BW.rate = 0.10725,
					base.ai.pers.WW.rate = 0.12,
					
					cond.main.BB.prob = 0.39,
					cond.main.BW.prob = 0.39,
					cond.main.WW.prob = 0.39,
					cond.pers.BB.prob = 0.493,
					cond.pers.BW.prob = 0.493,
					cond.pers.WW.prob = 0.493,
					cond.inst.BB.prob = 0.52,
					cond.inst.BW.prob = 0.52,
					cond.inst.WW.prob = 0.52,
					
					vv.iev.BB.prob = 0.15,
					vv.iev.BW.prob = 0.15,
					vv.iev.WW.prob = 0.15
)

# needed but then not used for anything
init <- init.mard(nwstats = st, 
					prev.B = 0.30, prev.W = 0.30,
					init.prev.age.slope.B = 0.05 / 12,
					init.prev.age.slope.W = 0.05 / 12
)

control <- control.mard(simno = fsimno, nsteps = 1040, 
                        start = 1,
                        #initialize.FUN = reinit.mard,
                        #nsims = 16, ncores = 16,
                        save.int = 100,
                        save.network = FALSE,
                        save.other = NULL, 
                        verbose = TRUE, verbose.int = 100
                        )

## Simulation
#mod1_wtavg<-netsim(est, param, init, control, 
 #          save.min = TRUE, save.max=F, compress = "xz")
mod1_wtavg<-netsim(est, param, init, control)
