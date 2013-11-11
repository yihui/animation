#' Demonstration for ``Moving Window Auto-Regression''
#'
#' This function just fulfills a very naive idea about moving window regression
#' using rectangles to denote the ``windows'' and move them, and the
#' corresponding AR(1) coefficients as long as rough confidence intervals are
#' computed for data points inside the ``windows'' during the process of moving.
#'
#' The AR(1) coefficients are computed by \code{\link{arima}}.
#' @param x univariate time-series (a single numerical vector); default to be
#'   \code{sin(seq(0, 2 * pi, length = 50)) + rnorm(50, sd = 0.2)}
#' @param k an integer of the window width
#' @param conf a positive number: the confidence intervals are computed as
#'   \code{c(ar1 - conf*s.e., ar1 + conf*s.e.)}
#' @param mat,widths,heights arguments passed to \code{\link{layout}} to divide
#'   the device into 2 parts
#' @param lty.rect the line type of the rectangles respresenting the moving
#'   ``windows''
#' @param \dots other arguments passed to \code{\link{points}} in the bottom
#'   plot (the centers of the arrows)
#' @return A list containing \item{phi }{the AR(1) coefficients} \item{L }{lower
#'   bound of the confidence interval} \item{U }{upper bound of the confidence
#'   interval}
#' @author Yihui Xie
#' @seealso \code{\link{arima}}
#' @references Robert A. Meyer, Jr. Estimating coefficients that change over
#'   time. \emph{International Economic Review}, 13(3):705-710, 1972.
#'
#' @export
#' @example inst/examples/mwar.ani-ex.R
mwar.ani = function(
  x, k = 15, conf = 2, mat = matrix(1:2, 2), widths = rep(1, ncol(mat)),
  heights = rep(1, nrow(mat)), lty.rect = 2, ...
) {
  nmax = ani.options('nmax')
  if (missing(x))
    x = sin(seq(0, 2 * pi, length = 50)) + rnorm(50, sd = 0.2)
  n = length(x)
  if (k > n)
    stop('The window width k must be smaller than the length of x!')
  idx = matrix(1:k, nrow = k, ncol = n - k + 1) +
    matrix(rep(0:(n - k), each = k), nrow = k, ncol = n - k + 1)
  phi = se = numeric(ncol(idx))
  j = 1
  for (i in 1:ncol(idx)) {
    if (j > nmax)
      break
    fit = arima(x[idx[, i]], order = c(1, 0, 0))
    phi[i] = coef(fit)['ar1']
    se[i] = sqrt(vcov(fit)[1, 1])
    j = j + 1
  }
  layout(mat, widths, heights)
  U = phi + conf * se
  L = phi - conf * se
  j = 1
  minx = maxx = NULL
  for (i in 1:ncol(idx)) {
    if (j > nmax) break
    dev.hold()
    plot(x, xlab = '', ylab = 'Original data')
    minx = c(minx, min(x[idx[, i]]))
    maxx = c(maxx, max(x[idx[, i]]))
    rect(1:i, minx, k:(i + k - 1), maxx, lty = lty.rect, border = 1:i)
    plot(x, xlim = c(1, n), ylim = range(c(U, L), na.rm = TRUE),
         type = 'n', ylab = 'AR(1) coefficient', xlab = '')
    arrows(1:i + k/2 - 0.5, L[1:i], 1:i + k/2 - 0.5, U[1:i], angle = 90, code = 3,
           length = par('din')[1]/n * 0.4, col = 1:i)
    points(1:i + k/2 - 0.5, phi[1:i], ...)
    ani.pause()
    j = j + 1
  }
  invisible(list(phi = phi, lower = L, upper = U))
}
