#' Simulation of QQ plots for the Normal distribution
#'
#' This demo shows the possible QQ plots created by random numbers generated
#' from a Normal distribution so that users can get a rough idea about how QQ
#' plots really look like.
#'
#' When the sample size is small, it is hard to get a correct inference about
#' the distribution of data from a QQ plot. Even if the sample size is large,
#' usually there are outliers far away from the straight line. Therefore, don't
#' overinterpret the QQ plots.
#' @param n integer: sample size
#' @param last.plot an expression to be evaluated after the plot is drawn, e.g.
#'   \code{expression(abline(0, 1))} to add the diagonal line
#' @param ... other arguments passed to \code{\link{qqnorm}}
#' @return \code{NULL}
#' @author Yihui Xie
#' @seealso \code{\link{qqnorm}}
#' @export
#' @example inst/examples/sim.qqnorm-ex.R
sim.qqnorm = function(n = 20, last.plot = NULL, ...) {
  for(i in 1:ani.options('nmax')) {
    dev.hold()
    qqnorm(rnorm(n), ...)
    eval(last.plot)
    ani.pause()
  }
}
