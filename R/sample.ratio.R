#' Demonstrate the ratio estimation in sampling survey
#'
#' This function demonstrates the advantage of ratio estimation when further
#' information (ratio) about x and y is available.
#'
#' From this demonstration we can clearly see that the ratio estimation is
#' generally better than the simple sample average when the ratio \bold{R}
#' really exists, otherwise ratio estimation may not help.
#' @param X the X variable (ancillary)
#' @param R the population ratio Y/X
#' @param Y the Y variable (whose mean we what to estimate)
#' @param size sample size
#' @param p.col,p.cex,p.pch point colors, magnification and symbols for the
#'   population and sample respectively
#' @param m.col color for the horizontal line to denote the sample mean of Y
#' @param legend.loc legend location: topleft, topright, bottomleft,
#'   bottomright, ... (see \code{\link{legend}})
#' @param \dots other arguments passed to \code{\link{plot.default}}
#' @return A list containing \item{X}{X population} \item{Y}{Y population}
#'   \item{R}{population ratio} \item{r}{ratio calculated from samples}
#'   \item{Ybar}{population mean of Y} \item{ybar.simple}{simple sample mean of
#'   Y} \item{ybar.ratio}{sample mean of Y via ratio estimation}
#' @author Yihui Xie
#' @seealso \code{\link{sample}}, \code{\link{sample.simple}},
#'   \code{\link{sample.cluster}}, \code{\link{sample.strat}},
#'   \code{\link{sample.system}}
#' @export
#' @example inst/examples/sample.ratio-ex.R
sample.ratio = function(
  X = runif(50, 0, 5), R = 1, Y = R * X + rnorm(X), size = length(X)/2,
  p.col = c('blue', 'red'), p.cex = c(1, 3), p.pch = c(20, 21),
  m.col = c('black', 'gray'), legend.loc = 'topleft', ...
) {
  nmax = ani.options('nmax')
  N = length(X)
  r = est1 = est2 = numeric(nmax)
  for (i in 1:nmax) {
    dev.hold()
    idx = sample(N, size)
    plot(X, Y, col = p.col[1], pch = p.pch[1], cex = p.cex[1], ...)
    points(X[idx], Y[idx], col = p.col[2], pch = p.pch[2], cex = p.cex[2])
    abline(v = c(mean(X), mean(X[idx])), h = c(mean(Y), est1[i] <- mean(Y[idx])),
           col = m.col, lty = c(2, 1))
    abline(h = est2[i] <- mean(X) * (r[i] <- est1[i]/mean(X[idx])), col = p.col[2])
    legend(
      legend.loc, expression(bar(X), bar(x), bar(X) %.% (bar(y)/bar(x)), bar(Y), bar(y)),
      lty = c(2, 1, 1, 2, 1), col = c(m.col[c(1, 2)], p.col[2], m.col[c(1, 2)]),
      bty = 'n', ncol = 2
    )
    ani.pause()
  }
  invisible(
    list(X = X, Y = Y, R = R, r = r, Ybar = mean(Y), ybar.simple = est1, ybar.ratio = est2)
  )
}
