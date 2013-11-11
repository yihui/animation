#' Demonstrate the least squares method
#'
#' This is a simple demonstration of the meaning of least squares in univariate
#' linear regression.
#'
#' With either the intercept or the slope changing, the lines will be moving in
#' the graph and corresponding residuals will be plotted. We can finally see the
#' best estimate of the intercept and the slope from the residual plot.
#' @param x a numeric vector: the independent variable
#' @param y a numeric vector: the dependent variable
#' @param n the sample size: when x and y are missing, we use simulated values
#'   of y (\code{x = 1:n} and \code{y = a + b * x + rnorm(n)})
#' @param ani.type \code{'slope'}: the slope is changing with the intercept
#'   fixed; \code{'intercept'}: intercept changing and slope fixed
#' @param a,b the fixed intercept and slope; depending on \code{ani.type}, we
#'   only need to specify one of them; e.g. when \code{ani.type == 'slope'}, we
#'   need to specify the value of \code{a}
#' @param a.range,b.range a vector of length 2 to define the range of the
#'   intercept and the slope; only one of them need to be specified; see above
#' @param ab.col the colors of two lines: the real regression line and the
#'   moving line with either intercept or slope changing
#' @param est.pch the point character of the 'estimated' values given \code{x}
#' @param v.col,v.lty the color and line type of the vetical lines which
#'   demonstrate the residuals
#' @param rss.pch,rss.type the point character and plot type of the residual
#'   plot
#' @param mfrow defines the layout of the graph; see \code{\link{par}}
#' @param ... other parameters passed to \code{\link{plot}} to define the
#'   appearance of the scatterplot
#' @return The value returned depends on the animation type.
#'
#'   If it is a slope animation, the value will be a list containing
#'   \item{lmfit}{ the estimates of the intercept and slope with
#'   \code{\link{lm}} } \item{anifit}{ the estimate of the slope in the
#'   animation } If it is an intercept animation, the second component of the
#'   above list will be the estimate of the intercept.
#'
#'   Note the estimate will not be precise generally.
#' @author Yihui Xie
#' @seealso \code{\link{lm}}
#' @note \code{ani.options('nmax')} specifies the maximum number of steps for
#'   the slope or intercept to move.
#' @export
#' @example inst/examples/least.squares-ex.R
least.squares = function(
  x, y, n = 15, ani.type = c('slope', 'intercept'), a, b, a.range, b.range,
  ab.col = c('gray', 'black'), est.pch = 19, v.col = 'red', v.lty = 2,
  rss.pch = 19, rss.type = 'o', mfrow = c(1, 2), ...
) {
  nmax = ani.options('nmax')
  if (missing(x)) x = 1:n
  if (missing(y)) y = x + rnorm(n)
  ani.type = match.arg(ani.type)
  fit = coef(lm(y ~ x))
  if (missing(a)) a = fit[1]
  if (missing(b)) b = fit[2]
  rss = rep(NA, nmax)
  par(mfrow = mfrow)
  if (ani.type == 'slope') {
    if (missing(b.range))
      bseq = tan(seq(pi/10, 3.5 * pi/10, length = nmax))
    else bseq = seq(b.range[1], b.range[2], length = nmax)
    for (i in 1:nmax) {
      dev.hold()
      plot(x, y, ...)
      abline(fit, col = ab.col[1])
      abline(a, bseq[i], col = ab.col[2])
      points(x, bseq[i] * x + a, pch = est.pch)
      segments(x, bseq[i] * x + a, x, y, col = v.col, lty = v.lty)
      rss[i] = sum((y - bseq[i] * x - a)^2)
      plot(
        1:nmax, rss, xlab = paste('Slope =', round(bseq[i], 3)),
        ylab = 'Residual Sum of Squares', pch = rss.pch, type = rss.type
      )
      ani.pause()
    }
    return(invisible(list(lmfit = fit, anifit = c(x = bseq[which.min(rss)]))))
  } else if (ani.type == 'intercept') {
    aseq = if (missing(a.range))
      seq(-5, 5, length = nmax) else seq(a.range[1], a.range[2], length = nmax)
    for (i in 1:nmax) {
      dev.hold()
      plot(x, y, ...)
      abline(fit, col = ab.col[1])
      abline(aseq[i], b, col = ab.col[2])
      points(x, b * x + aseq[i], pch = est.pch)
      segments(x, b * x + aseq[i], x, y, col = v.col, lty = v.lty)
      rss[i] = sum((y - b * x - aseq[i])^2)
      plot(
        1:nmax, rss, xlab = paste('Intercept =', round(aseq[i], 3)),
        ylab = 'Residual Sum of Squares', pch = rss.pch, type = rss.type
      )
      ani.pause()
    }
    return(invisible(list(lmfit = fit, anifit = c('(Intercept)' = aseq[which.min(rss)]))))
  } else warning('Incorrect animation type!')
}
