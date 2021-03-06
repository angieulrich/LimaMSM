% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/mod.update.aiclass.R
\name{update_aiclass.mard}
\alias{update_aiclass.mard}
\title{Update Role Class in One-Off Partnerships}
\usage{
update_aiclass.mard(dat, at)
}
\arguments{
\item{dat}{Master data list object of class \code{dat} containing networks,
individual-level attributes, and summary statistics.}

\item{at}{Current time step.}
}
\value{
This function updates the individual-level attribute \code{inst.ai.class} on
\code{dat$attr}.
}
\description{
Module function for updating act class in one-off partnerships
             based on probabilities of transition.
}
\keyword{module}

