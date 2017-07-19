## Race equal scenario setup file

rm(list = ls())
suppressPackageStartupMessages(library(Mardham))

#The values included in this file refer to the Lima MSM popualtion. 
#These values are a weighted average of the sex worker/non-sex worker sample values from the Sentinel Surveillance
# Time unit for simulation, relative to 1 day
time.unit <- 7

# Population size by race
num.B <- 5000
num.W <- 5000

# mean/pers degree distributions matrices.
deg.mp.B <- matrix(c(0.4194575, 0.0636525, 0.01689, 0.451065, 0.0379, 0.011035),byrow=2, nrow=2)
deg.mp.W <- matrix(c(0.4194575, 0.0636525, 0.01689, 0.451065, 0.0379, 0.011035), byrow=2, nrow=2)

# Revised Inst rates
mdeg.inst.B <- matrix(c(0.019748, 0.017216, 0.01541945, 0.0114702, 0.0108577, 0.0099834), byrow = TRUE, nrow = 2)
mdeg.inst.W <- matrix(c(0.019748, 0.017216, 0.01541945, 0.0114702, 0.0108577, 0.0099834), byrow = TRUE, nrow = 2)

# Quintile distribution of overall AI rates
qnts.B <- c(0, 0.00130595, 0.0054709, 0.0103906, 0.0321376)
qnts.W <- c(0, 0.00130595, 0.0054709, 0.0103906, 0.0321376)

# Proportion in same-race partnerships (main, casl, inst)
  #This reflects the equal mixing between groups
prop.hom.mpi.B <- c(0.5, 0.5, 0.5)
prop.hom.mpi.W <- c(0.5, 0.5, 0.5)

# Mean age diffs (main, casl, inst)
sqrt.adiff.BB <- c(1.3, 1.6, 1.3)
sqrt.adiff.BW <- c(1.3, 1.6, 1.3)
sqrt.adiff.WW <- c(1.3, 1.6, 1.3)

# Mean durations of BB, BW, and WW partnerships
#durs.main <- sum(c(348, 372, 555)*nodemix.m)/sum(nodemix.m)
#durs.pers <- sum(c(131, 286, 144)*nodemix.p)/sum(nodemix.p)
durs.main <- c(288)
durs.pers <- c(142)

# Age-sex-specific mortality rates
ages <- 18:39
asmr.B <- c(rep(0, 17),
            1 - (1 - c(rep(0.00103, 7),
                       rep(0.00133, 10),
                       rep(0.00214, 5))) ^ (1/(365/time.unit)),
            1)

asmr.W <- c(rep(0, 17),
            1 - (1 - c(rep(0.00103, 7),
                       rep(0.00133, 10),
                       rep(0.00214, 5))) ^ (1/(365/time.unit)),
            1)

# asmr.B <- asmr.W <- (asmr.B + asmr.W)/2

# I, R, V role frequencies
role.B.prob <- c(0.28805, 0.28041, 0.43154)
role.W.prob <- c(0.28805, 0.28041, 0.43154)

# Create meanstats
st <- calc_nwstats.mard(
  time.unit = time.unit,
  num.B = num.B,
  num.W = num.W,
  deg.mp.B = deg.mp.B,
  deg.mp.W = deg.mp.W,
  mdeg.inst.B = mdeg.inst.B,
  mdeg.inst.W = mdeg.inst.W,
  qnts.B = qnts.B,
  qnts.W = qnts.W,
  prop.hom.mpi.B = prop.hom.mpi.B,
  prop.hom.mpi.W = prop.hom.mpi.W,
  balance = "mean",
  sqrt.adiff.BB = sqrt.adiff.BB,
  sqrt.adiff.WW = sqrt.adiff.WW,
  sqrt.adiff.BW = sqrt.adiff.BW,
  age.method = "heterogeneous",
  dur.method = "heterogeneous",                                     ## Race diff
  #diss.main = ~offset(edges) + offset(nodemix("race", base = 1)),   ## Race diff
  #diss.pers = ~offset(edges) + offset(nodemix("race", base = 1)),   ## Race diff
  #dur.method = "homogeneous",                                      ## Race eq
  diss.main = ~offset(edges),                                      ## Race eq
  diss.pers = ~offset(edges),                                      ## Race eq
  durs.main = durs.main,
  durs.pers = durs.pers,
  ages = ages,
  asmr.B = asmr.B,
  asmr.W = asmr.W,
  role.B.prob = role.B.prob,
  role.W.prob = role.W.prob)

#save(st, file = "scenarios/rdiffhet/est/nwstats.rda")
#save(st, file = "/net/proj/camp/rdiffhet/est/nwstats.rda")
save(st, file="weighted_avg.rda")
rm(list = ls())
