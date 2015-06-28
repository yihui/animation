#' Demonstrate bootstrapping for iid data
#'
#' Use a sunflower scatter plot to illustrate the results of resampling, and a
#' histogram to show the distribution of the statistic of interest.
#'
#' This is actually a very naive version of bootstrapping but may be useful for
#' novices. By default, the circles denote the original dataset, while the red
#' sunflowers (probably) with leaves denote the points being resampled; the
#' number of leaves just means how many times these points are resampled, as
#' bootstrap samples \emph{with} replacement. The x-axis is the sample values,
#' and y-axis is the indices of sample points.
#'
#' The whole process has illustrated the steps of resampling, computing the
#' statistic and plotting its distribution based on bootstrapping.
#'
#' @param x a numerical vector (the original data).
#' @param statistic A function which returns a value of the statistic of
#'   interest when applied to the data x.
#' @param m the sample size for bootstrapping (\eqn{m}-out-of-\eqn{n} bootstrap)
#' @param mat,widths,heights arguments passed to \code{\link{layout}} to set the
#'   layout of the two graphs
#' @param col a character vector of length 5 specifying the colors of: points of
#'   original data, points for the sunflowerplot, rectangles of the histogram,
#'   the density line, and the rug.
#' @param cex a numeric vector of length 2: magnification of original data
#'   points and the sunflowerplot points.
#' @param main a character vector of length 2: the main titles of the two
#'   graphs.
#' @param ... other arguments passed to \code{\link{hist}}
#' @return A list containing \item{t0 }{ The observed value of 'statistic'
#'   applied to 'x'.} \item{tstar }{Bootstrap versions of the 'statistic'.}
#' @note The maximum times of resampling is specified in
#'   \code{ani.options('nmax')}.
#' @author Yihui Xie
#' @seealso \code{\link{sunflowerplot}}
#' @references There are many references explaining the bootstrap and its
#'   variations.
#'
#'   Efron, B. and Tibshirani, R. (1993) \emph{An Introduction to the
#'   Bootstrap}. Chapman & Hall.
#'
#' @export
#' @example inst/examples/boot.iid-ex.R
boot.iid <- function(
  x = runif(20), statistic = mean, m = length(x), mat = matrix(1:2, 2),
  widths = rep(1, ncol(mat)), heights = rep(1, nrow(mat)),
  col = c('black', 'red', 'bisque', 'red', 'gray'), cex = c(1.5, 0.8), main, ...
) {
  xlab = deparse(substitute(x))
  idx = replicate(ani.options('nmax'), sample(length(x), m, TRUE))
  xx = matrix(x[idx], nrow = m)
  xest = apply(xx, 2, statistic)
  xrg = range(hist(xest, plot = FALSE)$breaks)
  layout(mat, widths, heights)
  if (missing(main)) main = c('Bootstrap sample', 'Density of bootstrap estimates')
  for (i in 1:ani.options('nmax')) {
    dev.hold()
    sunflowerplot(
      xx[, i], idx[, i], col = col[2], cex = cex[2], ylim = c(1, length(x)),
      xlim = range(x) + c(-1, 1) * diff(range(x)) * 0.1,
      panel.first = points(x, seq_along(x), col = col[1], cex = cex[1]), xlab = xlab,
      ylab = 'sample index', main = main[1])
    hist(xest[1:i], freq = FALSE, main = main[2], col = col[3], xlab = '', xlim = xrg, ...)
    if (i > 1) lines(density(xest[1:i]), col = col[4]) else axis(2)
    rug(xest[1:i], col = col[5])
    axis(1)
    ani.pause()
  }
  invisible(list(t0 = statistic(x), tstar = xx))
}
