#' Demonstration for the process of cross-validation
#'
#' This function uses rectangles to illustrate the \eqn{k} folds and
#' mark the test set and the training set with different colors.
#'
#' Briefly speaking, the process of cross-validation is just to split
#' the whole data set into several parts and select one part as the
#' test set and the rest parts as the training set.
#'
#' The computation of sample sizes is base on \code{\link{kfcv}}.
#'
#' @param x a numerical vector which stands for the sample points.
#' @param k an integer: how many parts should we split the data into?
#' (comes from the \eqn{k}-fold cross-validation.)
#' @param col a character vector of length 3 specifying the colors
#' of: the rectangle representing the test set, the points of the
#' test set, and points of the training set.
#' @param pch a numeric vector of length 2 specifying the symbols of
#' the test set and training set respectively.
#' @param \dots other arguments passed to
#' \code{\link{plot.default}}
#' @return None (invisible \code{NULL}).
#' @note For the `leave-one-out' cross-validation, just specify
#' \code{k} as \code{length(x)}, then the rectangles will `shrink'
#' into single lines.
#'
#' The final number of animation frames is the smaller one of
#' \code{ani.options('nmax')} and \code{k}.
#'
#' This function has nothing to do with specific models used in
#' cross-validation.
#' @author Yihui Xie
#' @seealso \code{\link{kfcv}}
#' @export
#' @example inst/examples/cv.ani-ex.R
cv.ani = function(
  x = runif(150), k = 10, col = c('green', 'red', 'blue'), pch = c(4, 1), ...
) {
  N = length(x)
  n = sample(N)
  x = x[n]
  kf = cumsum(c(1, kfcv(k, N)))
  j = 1
  for (i in 2:length(kf)) {
    if (j > ani.options('nmax'))
      break
    dev.hold()
    plot(x, xlim = c(1, N), type = 'n', xlab = 'Sample index',
         ylab = 'Sample values', xaxt = 'n', ...)
    xax = as.integer(pretty(1:N))
    if (xax[1] == 0) xax = xax[-1]
    axis(side = 1, xax, n[xax])
    idx = kf[i - 1]:(kf[i] - 1)
    rect(kf[-length(kf)], min(x), kf[-1] - 1, max(x), border = 'gray', lty = 2)
    rect(kf[i - 1], min(x), kf[i] - 1, max(x), density = 10, col = col[1])
    points(idx, x[idx], col = col[2], pch = pch[1], lwd = 2)
    text(mean(idx), quantile(x, prob = 0.75), 'Test Set', cex = 1.5, col = col[2])
    points(seq(N)[-idx], x[-idx], col = col[3], pch = pch[2], lwd = 1)
    text(mean(seq(N)[-idx]), quantile(x, prob = 0.25), 'Training Set',
         cex = 1.5, col = col[3])
    ani.pause()
    j = j + 1
  }
  invisible(NULL)
}
