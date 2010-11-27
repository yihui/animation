

#' Demonstration for stratified sampling
#' Every rectangle stands for a stratum, and the simple random sampling without
#' replacement is performed within each stratum. The points being sampled are
#' marked out (by red circles by default).
#' 
#' 
#' @param pop a vector for the size of each stratum in the population.
#' @param size a corresponding vector for the sample size in each stratum
#'   (recycled if necessary).
#' @param p.col, p.cex different colors /magnification rate to annotate the
#'   population and the sample
#' @param \dots other arguments passed to \code{\link{rect}} to annotate the
#'   ``strata''
#' @return None (invisible `\code{NULL}').
#' @author Yihui Xie <\url{http://yihui.name}>
#' @seealso \code{\link{sample}}, \code{\link{sample.simple}},
#'   \code{\link{sample.cluster}}, \code{\link{sample.ratio}},
#'   \code{\link{sample.system}}
#' @references Cochran, W G (1977) \emph{Sampling Techniques}, Wiley, ISBN
#'   0-471-16240-X
#' 
#' \url{http://animation.yihui.name/samp:stratified_sampling}
#' @keywords distribution dynamic
#' @examples
#' 
#' oopt = ani.options(interval = 1, nmax = 30)
#' op = par(mar = rep(1, 4), lwd = 2)
#' sample.strat(col = c("bisque", "white"))
#' par(op)
#' \dontrun{
#' 
#' # HTML animation page
#' ani.options(ani.height = 350, ani.width = 500, outdir = getwd(), nmax = 30,
#'     interval = 1, title = "Demonstration of the stratified sampling",
#'     description = "Every rectangle stands for a stratum, and the simple
#'     random sampling without replacement is performed within each stratum.")
#' ani.start()
#' par(mar = rep(1, 4), lwd = 2)
#' sample.strat(col = c("bisque", "white"))
#' ani.stop()
#' 
#' }
#' ani.options(oopt)
#' 
`sample.strat` <- function(pop = ceiling(10 * runif(10,
    0.5, 1)), size = ceiling(pop * runif(length(pop), 0, 0.5)),
    p.col = c("blue", "red"), p.cex = c(1, 3), ...) {
    if (any(size > pop))
        stop("sample size must be smaller than population")
    ncol = max(pop)
    nrow = length(pop)
    size = rep(size, length = nrow)
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    for (i in 1:nmax) {
        plot(1, axes = FALSE, ann = FALSE, type = "n", xlim = c(0.5,
            ncol + 0.5), ylim = c(0.5, nrow + 0.5), xaxs = "i",
            yaxs = "i", xlab = "", ylab = "")
        rect(rep(0.5, nrow), seq(0.5, nrow, 1), rep(ncol + 0.5,
            nrow), seq(1.5, nrow + 1, 1), lwd = 1, ...)
        for (j in 1:nrow) {
            points(1:pop[j], rep(j, pop[j]), pch = 19, col = p.col[1],
                cex = p.cex[1])
            points(sample(pop[j], size[j]), rep(j, size[j]),
                col = p.col[2], cex = p.cex[2])
        }
        Sys.sleep(interval)
    }
    invisible(NULL)
}
