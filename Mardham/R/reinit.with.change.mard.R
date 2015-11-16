#' @title Re-Initialization Module with new model fit
#'
#' @description This function reinitializes an epidemic model to restart at a
#'              specified time step given an input \code{netsim} object, and 
#'              allows for the case where the new simulation is based on a 
#'              different model fit than the old one
#'
#' @param x An \code{EpiModel} object of class \code{\link{netsim}}.
#' @inheritParams initialize.mard
#'
#' @return
#' This function resets the data elements on the \code{dat} master data object
#' in the needed ways for the time loop to function.
#'
#' @export
#' @keywords module
#'
reinit.with.change.mard <- function(x, param, init, control, s) {
  
  if (is.null(x$network)) {
    stop("x must contain network to restart simulation", call. = FALSE)
  }
  if (is.null(x$attr)) {
    stop("x must contain attr to restart simulation", call. = FALSE)
  }
  if (is.null(x$temp)) {
    stop("x must contain temp to restart simulation", call. = FALSE)
  }
  if (is.null(param$nwstatsfile)) {
    stop("param must contain nwstatsfile to restart simulation", call. = FALSE)
  }

    if (!is.null(control$currsim) & length(x$network) > 1) {
    s <- control$currsim
  }
  
  dat <- list()
  dat$nw <- x$network[[s]]
  if (!is.null(x$last.ts)) {
    for (i in 1:2) {
      dat$nw[[i]] <- network.extract(dat$nw[[i]], at = x$last.ts)
    }
  }
  dat$param <- param
  dat$param$modes <- 1
  dat$control <- control
  load(dat$param$nwstatsfile)
  dat$nwparam <- nwparam
  
  
  dat$epi <- sapply(x$epi, function(var) var[s])
  names(dat$epi) <- names(x$epi)
  dat$attr <- x$attr[[s]]
  dat$stats <- list()
  dat$stats$nwstats <- x$stats$nwstats[[s]]
  dat$temp <- x$temp[[s]]
  
  class(dat) <- "dat"
  
  return(dat)
}
