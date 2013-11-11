#' Demonstration of the concept of confidence intervals
#'
#' This function gives a demonstration of the concept of confidence intervals in
#' mathematical statistics.
#'
#' Keep on drawing samples from the Normal distribution N(0, 1), computing the
#' intervals based on a given confidence level and plotting them as segments in
#' a graph. In the end, we may check the coverage rate against the given
#' confidence level.
#'
#' Intervals that cover the true parameter are denoted in color \code{cl[2]},
#' otherwise in color \code{cl[1]}. Each time we draw a sample, we can compute
#' the corresponding confidence interval. As the process of drawing samples goes
#' on, there will be a legend indicating the numbers of the two kinds of
#' intervals respectively and the coverage rate is also denoted in the top-left
#' of the plot.
#'
#' The argument \code{nmax} in \code{\link{ani.options}} controls the maximum
#' times of drawing samples.
#' @param level the confidence level \eqn{(1 - \alpha)}, e.g. 0.95
#' @param size the sample size for drawing samples from N(0, 1)
#' @param cl two different colors to annotate whether the confidence intervals
#'   cover the true mean (\code{cl[1]}: no; \code{cl[2]}: yes)
#' @param \dots other arguments passed to \code{\link{plot.default}}
#' @return A list containing \item{level }{confidence level} \item{size }{sample
#'   size} \item{CI}{a matrix of confidence intervals for each sample}
#'   \item{CR}{coverage rate}
#' @author Yihui Xie
#' @references George Casella and Roger L. Berger. \emph{Statistical Inference}.
#'   Duxbury Press, 2th edition, 2001.
#'
#' @export
#' @example inst/examples/conf.int-ex.R
conf.int = function(level = 0.95, size = 50, cl = c('red', 'gray'), ...) {
  n = ani.options('nmax')
  d = replicate(n, rnorm(size))
  m = colMeans(d)
  z = qnorm(1 - (1 - level)/2)
  y0 = m - z/sqrt(size)
  y1 = m + z/sqrt(size)
  rg = range(c(y0, y1))
  cvr = y0 < 0 & y1 > 0
  xax = pretty(1:n)
  for (i in 1:n) {
    dev.hold()
    plot(
      1:n, ylim = rg, type = 'n', xlab = 'Samples',
      ylab = expression('CI: [' ~ bar(x) - z[alpha/2] * sigma/sqrt(n) ~ ', ' ~ bar(x) +
                          z[alpha/2] * sigma/sqrt(n) ~ ']'), xaxt = 'n', ...)
    abline(h = 0, lty = 2)
    axis(1, xax[xax <= i])
    arrows(
      1:i, y0[1:i], 1:i, y1[1:i], length = par('din')[1]/n * 0.5,
      angle = 90, code = 3, col = cl[cvr[1:i] + 1])
    points(1:i, m[1:i], col = cl[cvr[1:i] + 1])
    legend(
      'topright', legend = format(c(i - sum(cvr[1:i]), sum(cvr[1:i])), width = nchar(n)),
      fill = cl, bty = 'n', ncol = 2)
    legend(
      'topleft',
      legend = paste('coverage rate:', format(round(mean(cvr[1:i]), 3), nsmall = 3)),
      bty = 'n')
    ani.pause()
  }
  CI = cbind(y0, y1)
  colnames(CI) = paste(round(c((1 - level)/2, 1 - (1 - level)/2), 2) * 100, '%')
  rownames(CI) = 1:n
  invisible(list(level = level, size = size, CI = CI, CR = mean(cvr)))
}
