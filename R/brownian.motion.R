#' Demonstration of Brownian motion on the 2D plane
#'
#' Brownian motion, or random walk, can be regarded as the trace of some
#' cumulative normal random numbers.
#'
#' The location of the next step is ``current location + random Gaussian
#' numbers'', i.e.,
#'
#' \deqn{x_{k + 1} = x_{k} + rnorm(1)}{x[k + 1] = x[k] + rnorm(1)}
#'
#' \deqn{y_{k + 1} = y_{k} + rnorm(1)}{y[k + 1] = y[k] + rnorm(1)}
#'
#' where \emph{(x, y)} stands for the location of a point.
#'
#' @param n Number of points in the scatterplot
#' @param xlim,ylim Arguments passed to \code{\link{plot.default}} to control
#'   the apperance of the scatterplot (title, points, etc), see
#'   \code{\link{points}} for details.
#' @param ... other arguments passed to \code{\link{plot.default}}
#' @return None (invisible \code{NULL}).
#' @note The maximum number of steps in the motion is specified in
#'   \code{ani.options('nmax')}.
#' @author Yihui Xie
#' @seealso \code{\link{rnorm}}
#' @references \url{http://vis.supstat.com/2012/11/brownian-motion-with-r}
#' @export
#' @example inst/examples/brownian.motion-ex.R
brownian.motion = function(
  n = 10, xlim = c(-20, 20), ylim = c(-20, 20), ...
) {
  x = rnorm(n)
  y = rnorm(n)
  for (i in seq_len(ani.options('nmax'))) {
    dev.hold()
    plot(x, y, xlim = xlim, ylim = ylim, ...)
    text(x, y)
    x = x + rnorm(n)
    y = y + rnorm(n)
    ani.pause()
  }
}
