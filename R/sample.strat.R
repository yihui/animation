#' Demonstration for the stratified sampling
#'
#' Each rectangle stands for a stratum, and the simple random sampling without
#' replacement is performed within each stratum. The points being sampled are
#' marked out (by red circles by default).
#' @param pop a vector for the size of each stratum in the population.
#' @param size a corresponding vector for the sample size in each stratum
#'   (recycled if necessary).
#' @param p.col,p.cex different colors /magnification rate to annotate the
#'   population and the sample
#' @param \dots other arguments passed to \code{\link{rect}} to annotate the
#'   ``strata''
#' @return None (invisible `\code{NULL}').
#' @author Yihui Xie
#' @seealso \code{\link{sample}}, \code{\link{sample.simple}},
#'   \code{\link{sample.cluster}}, \code{\link{sample.ratio}},
#'   \code{\link{sample.system}}
#' @export
#' @example inst/examples/sample.strat-ex.R
sample.strat = function(
  pop = ceiling(10 * runif(10, 0.5, 1)), size = ceiling(pop * runif(length(pop), 0, 0.5)),
  p.col = c('blue', 'red'), p.cex = c(1, 3), ...
) {
  if (any(size > pop))
    stop('sample size must be smaller than population')
  ncol = max(pop)
  nrow = length(pop)
  size = rep(size, length = nrow)
  nmax = ani.options('nmax')
  for (i in 1:nmax) {
    dev.hold()
    plot(1, axes = FALSE, ann = FALSE, type = 'n', xlim = c(0.5, ncol + 0.5),
         ylim = c(0.5, nrow + 0.5), xaxs = 'i', yaxs = 'i', xlab = '', ylab = '')
    rect(rep(0.5, nrow), seq(0.5, nrow, 1),
         rep(ncol + 0.5, nrow), seq(1.5, nrow + 1, 1), lwd = 1, ...)
    for (j in 1:nrow) {
      points(1:pop[j], rep(j, pop[j]), pch = 19, col = p.col[1], cex = p.cex[1])
      points(sample(pop[j], size[j]), rep(j, size[j]), col = p.col[2], cex = p.cex[2])
    }
    ani.pause()
  }
  invisible(NULL)
}
