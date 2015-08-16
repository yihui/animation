#' Bootstrapping with LOWESS
#'
#' Sample the original data with replacement and fit LOWESS curves accordingly.
#'
#' We keep on resampling the data and finally we will see several bootstrapped
#' LOWESS curves, which may give us a rough idea about a ``confidence interval''
#' of the LOWESS fit.
#' @param x,y,f,iter passed to \code{\link{lowess}}
#' @param line.col the color of the LOWESS lines
#' @param ... other arguments passed to the scatterplot by \code{\link{plot}}
#' @return NULL
#' @author Yihui Xie
#' @export
#' @example inst/examples/boot.lowess-ex.R
boot.lowess = function(x, y = NULL, f = 2/3, iter = 3, line.col = '#FF000033', ...) {
  if (missing(x)) {
    x = datasets::cars[, 1]
    y = datasets::cars[, 2]
  }
  if (NCOL(x) > 1) {
    y = x[, 2]
    x = x[, 1]
  }
  idx = replicate(ani.options('nmax'), sample(length(x), replace = TRUE))
  for (i in 1:ncol(idx)) {
    dev.hold()
    plot(x, y, ...)
    sunflowerplot(x[idx[, i]], y[idx[, i]], add = TRUE)
    apply(idx[, 1:i, drop = FALSE], 2, function(j) {
      lines(lowess(x[j], y[j], f = f, iter = iter), col = line.col)
    })
    ani.pause()
  }
}
