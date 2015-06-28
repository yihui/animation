#' Brownian Motion in a circle
#'
#' Several points moving randomly in a circle.
#'
#' This is a solution to the question raised in R-help:
#' \url{https://stat.ethz.ch/pipermail/r-help/2008-December/183018.html}.
#'
#' @param n number of points
#' @param col colors of points
#' @param \dots other parameters passed to \code{\link{points}}
#' @return Invisible \code{NULL}.
#' @note The maximum number of steps in the motion is specified in
#'   \code{ani.options('nmax')}.
#' @author Yihui Xie
#' @seealso \code{\link{brownian.motion}}, \code{\link{rnorm}}
#' @references \url{http://vis.supstat.com/2012/11/brownian-motion-with-r/}
#' @export
#' @example inst/examples/BM.circle-ex.R
BM.circle = function(n = 20, col = rainbow(n), ...) {
  par(pty = 's', ann = FALSE, xaxt = 'n', yaxt = 'n', bty = 'n')
  theta = seq(0, 2 * pi, length = 512)
  nmax = ani.options('nmax')
  x = runif(n, -1, 1)
  y = runif(n, -1, 1)
  for (i in 1:nmax) {
    dev.hold()
    plot(sin(theta), cos(theta), type = 'l', lwd = 5)
    x = x + rnorm(n, 0, 0.1)
    y = y + rnorm(n, 0, 0.1)
    cond = x^2 + y^2 > 1
    r = sqrt(x[cond]^2 + y[cond]^2)
    x[cond] = x[cond]/r/1.1
    y[cond] = y[cond]/r/1.1
    points(x, y, col = col, ...)
    ani.pause()
  }
  invisible(NULL)
}

