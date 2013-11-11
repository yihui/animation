#' Demonstration of the Quincunx (Bean Machine/Galton Box)
#'
#' Simulates the quincunx with ``balls'' (beans) falling through several layers
#' (denoted by triangles) and the distribution of the final locations at which
#' the balls hit is denoted by a histogram; \code{quincunx()} is shows single
#' layer, and \code{quincunx2()} is a two-stage version of the quincunx.
#'
#' The bean machine, also known as the quincunx or Galton box, is a device
#' invented by Sir Francis Galton to demonstrate the law of error and the normal
#' distribution.
#'
#' When a ball falls through a layer, it can either go to the right or left side
#' with the probability 0.5. At last the location of all the balls will show us
#' the bell-shaped distribution.
#' @param balls number of balls
#' @param layers number of layers
#' @param pch.layers point character of layers; triangles (\code{pch = 2}) are
#'   recommended
#' @param pch.balls,col.balls,cex.balls point character, colors and
#'   magnification of balls
#' @return A named vector: the frequency table for the locations of the balls.
#'   Note the names of the vector are the locations: 1.5, 2.5, ..., layers -
#'   0.5.
#' @note The maximum number of animation frames is controlled by
#'   \code{ani.options('nmax')} as usual, but it is strongly recommended that
#'   \code{ani.options(nmax = balls + layers -2)}, in which case all the balls
#'   will just fall through all the layers and there will be no redundant
#'   animation frames.
#' @author Yihui Xie, Lijia Yu, and Keith ORourke
#' @seealso \code{\link{rbinom}}
#' @references \url{http://vis.supstat.com/2013/04/bean-machine}
#' @export
#' @example inst/examples/quincunx-ex.R
#' @example inst/examples/quincunx2-ex.R
quincunx = function(
  balls = 200, layers = 15, pch.layers = 2, pch.balls = 19,
  col.balls = sample(colors(), balls, TRUE), cex.balls = 2
) {
  op = par(mar = c(1, 0.1, 0.1, 0.1), mfrow = c(2, 1)); on.exit(par(op))
  if (ani.options('nmax') != (balls + layers - 2))
    warning("It's strongly recommended that ani.options(nmax = balls + layers -2)")
  nmax = max(balls + layers - 2, ani.options('nmax'))
  layerx = layery = NULL
  for (i in 1:layers) {
    layerx = c(layerx, seq(0.5 * (i + 1), layers - 0.5 * (i - 1), 1))
    layery = c(layery, rep(i, layers - i + 1))
  }
  ballx = bally = matrix(nrow = balls, ncol = nmax)
  finalx = numeric(balls)
  for (i in 1:balls) {
    ballx[i, i] = (1 + layers)/2
    if (layers > 2) {
      tmp = rbinom(layers - 2, 1, 0.5) * 2 - 1
      ballx[i, i + 1:(layers - 2)] = cumsum(tmp) * 0.5 + (1 + layers)/2
    }
    bally[i, (i - 1) + 1:(layers - 1)] = (layers - 1):1
    finalx[i] = ballx[i, i + layers - 2]
  }
  rgx = c(1, layers)
  rgy = c(0, max(table(finalx)))
  for (i in 1:ani.options('nmax')) {
    dev.hold()
    plot(1:layers, type = 'n', ann = FALSE, axes = FALSE)
    points(layerx, layery, pch = pch.layers)
    points(ballx[, i], bally[, i], pch = pch.balls, col = col.balls, cex = cex.balls)
    par(bty = 'u')
    if (i < layers - 1) plot.new() else {
      hist(finalx[1:(i - layers + 2)], breaks = 1:layers, xlim = rgx, ylim = rgy,
           main = '', xlab = '', ylab = '', ann = FALSE, axes = FALSE)
    }
    ani.pause()
  }
  invisible(c(table(finalx)))
}
