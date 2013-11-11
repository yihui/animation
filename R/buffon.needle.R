#' Simulation of Buffon's Needle
#'
#' This function provides a simulation for the problem of Buffon's Needle, which
#' is one of the oldest problems in the field of geometrical probability.
#'
#' This is quite an old problem in probability. For mathematical background,
#' please refer to \url{http://en.wikipedia.org/wiki/Buffon's_needle} or
#' \url{http://www.mste.uiuc.edu/reese/buffon/buffon.html}.
#'
#' `Needles' are denoted by segments on the 2D plane, and dropped randomly to
#' check whether they cross the parallel lines. Through many times of `dropping'
#' needles, the approximate value of \eqn{\pi} can be calculated out.
#'
#' There are three graphs made in each step: the top-left one is a simulation of
#' the scenario, the top-right one is to help us understand the connection
#' between dropping needles and the mathematical method to estimate \eqn{\pi},
#' and the bottom one is the result for each drop.
#' @param l numerical. length of the needle; shorter than \code{d}.
#' @param d numerical. distances between lines; it should be longer than
#'   \code{l}.
#' @param redraw logical. redraw former `needles' or not for each drop.
#' @param mat,heights arguments passed to \code{\link{layout}} to set the layout
#'   of the three graphs.
#' @param col a character vector of length 7 specifying the colors of:
#'   background of the area between parallel lines, the needles, the sin curve,
#'   points below / above the sin curve, estimated \eqn{\pi} values, and the
#'   true \eqn{\pi} value.
#' @param expand a numerical value defining the expanding range of the y-axis
#'   when plotting the estimated \eqn{\pi} values: the \code{ylim} will be
#'   \code{(1 +/- expand) * pi}.
#' @param type an argument passed to \code{\link[graphics:plot.default]{plot}}
#'   when plotting the estimated \eqn{\pi} values (default to be lines).
#' @param \dots other arguments passed to
#'   \code{\link[graphics:plot.default]{plot}} when plotting the values of
#'   estimated \eqn{\pi}.
#' @return The values of estimated \eqn{\pi} are returned as a numerical vector
#'   (of length \code{nmax}).
#' @note Note that \code{redraw} has great influence on the speed of the
#'   simulation (animation) if the control argument \code{nmax} (in
#'   \code{\link{ani.options}}) is quite large, so you'd better specify it as
#'   \code{FALSE} when doing a large amount of simulations.
#'
#'   The maximum number of drops is specified in \code{ani.options('nmax')}.
#' @author Yihui Xie
#' @references Ramaley, J. F. (Oct 1969). Buffon's Noodle Problem. \emph{The
#'   American Mathematical Monthly} \bold{76} (8): 916-918.
#'
#'   \url{http://vis.supstat.com/2013/04/buffons-needle}
#' @export
#' @example inst/examples/buffon.needle-ex.R
buffon.needle = function(
  l = 0.8, d = 1, redraw = TRUE, mat = matrix(c(1, 3, 2, 3), 2), heights = c(3, 2),
  col = c('lightgray', 'red', 'gray', 'red', 'blue', 'black', 'red'),
  expand = 0.4, type = 'l', ...
) {
  j = 1; n = 0
  PI = rep(NA, ani.options('nmax'))
  x = y = x0 = y0 = phi = ctr = NULL
  layout(mat, heights = heights)
  while (j <= length(PI)) {
    dev.hold()
    plot(1, xlim = c(-0.5 * l, 1.5 * l), ylim = c(0, 2 * d), type = 'n',
         xlab = '', ylab = '', axes = FALSE)
    axis(1, c(0, l), c('', ''), tcl = -1)
    axis(1, 0.5 * l, 'L', font = 3, tcl = 0, cex.axis = 1.5, mgp = c(0, 0.5, 0))
    axis(2, c(0.5, 1.5) * d, c('', ''), tcl = -1)
    axis(2, d, 'D', font = 3, tcl = 0, cex.axis = 1.5, mgp = c(0, 0.5, 0))
    box()
    bd = par('usr')
    rect(bd[1], 0.5 * d, bd[2], 1.5 * d, col = col[1])
    abline(h = c(0.5 * d, 1.5 * d), lwd = 2)
    phi = c(phi, runif(1, 0, pi))
    ctr = c(ctr, runif(1, 0, 0.5 * d))
    y = c(y, sample(c(0.5 * d + ctr[j], 1.5 * d - ctr[j]), 1))
    x = c(x, runif(1, 0, l))
    x0 = c(x0, 0.5 * l * cos(phi[j]))
    y0 = c(y0, 0.5 * l * sin(phi[j]))
    if (redraw) {
      segments(x - x0, y - y0, x + x0, y + y0, col = col[2])
    } else {
      segments(x[j] - x0[j], y[j] - y0[j], x[j] + x0[j], y[j] + y0[j], col = col[2])
    }
    xx = seq(0, pi, length = 200)
    plot(xx, 0.5 * l * sin(xx), type = 'l', ylim = c(0, 0.5 * d), bty = 'l',
         xlab = '', ylab = '', col = col[3])
    idx = as.numeric(ctr > 0.5 * l * sin(phi)) + 1
    if (redraw) {
      points(phi, ctr, col = c(col[4], col[5])[idx])
    } else {
      points(phi[j], ctr[j], col = c(col[4], col[5])[idx[j]])
    }
    text(pi/2, 0.4 * l, expression(y == frac(L, 2) * sin(phi)), cex = 1.5)
    n = n + (ctr[j] <= 0.5 * l * sin(phi[j]))
    if (n > 0) PI[j] = 2 * l * j/(d * n)
    plot(PI, ylim = c((1 - expand) * pi, (1 + expand) * pi),
         xlab = paste('Times of Dropping:', j), ylab = expression(hat(pi)),
         col = col[6], type = type, ...)
    abline(h = pi, lty = 2, col = col[7])
    pihat = format(PI[j], nsmall = 7, digits = 7)
    legend('topright', legend = substitute(hat(pi) == pihat, list(pihat = pihat)),
           bty = 'n', cex = 1.3)
    ani.pause()
    j = j + 1
  }
  invisible(PI)
}
