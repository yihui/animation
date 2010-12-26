##' Demonstration for the cluster sampling.
##' Each rectangle stands for a cluster, and the simple random sampling
##' without replacement is performed for each cluster. All points in the
##' clusters being sampled will be drawn out.
##'
##' @param pop a vector for the size of each cluster in the population.
##' @param size the number of clusters to be drawn out.
##' @param p.col,p.cex different colors / magnification rate to annotate the
##'   population and the sample
##' @param \dots other arguments passed to \code{\link[graphics]{rect}} to
##'   annotate the ``clusters''
##' @return None (invisible `\code{NULL}').
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[base]{sample}}, \code{\link{sample.simple}},
##'   \code{\link{sample.ratio}}, \code{\link{sample.strat}},
##'   \code{\link{sample.system}}
##' @references \url{http://animation.yihui.name/samp:cluster_sampling}
##' @keywords distribution dynamic
##' @examples
##' oopt = ani.options(interval = 1, nmax = 30)
##' op = par(mar = rep(1, 4))
##' sample.cluster(col = c("bisque", "white"))
##' par(op)
##' \dontrun{
##'
##' # HTML animation page
##' ani.options(ani.height = 350, ani.width = 500, nmax = 30,
##'     interval = 1, title = "Demonstration of the cluster sampling",
##'     description = "Once a cluster is sampled, all its elements will be
##'     chosen.")
##' ani.start()
##' par(mar = rep(1, 4), lwd = 2)
##' sample.cluster(col = c("bisque", "white"))
##' ani.stop()
##'
##' }
##' ani.options(oopt)
##'
sample.cluster = function(pop = ceiling(10 * runif(10,
    0.2, 1)), size = 3, p.col = c("blue", "red"), p.cex = c(1,
    3), ...) {
    if (size > length(pop))
        stop("sample size must be smaller than the number of clusters")
    ncol = max(pop)
    nrow = length(pop)
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    for (i in 1:nmax) {
        plot(1, axes = FALSE, ann = FALSE, type = "n", xlim = c(0.5,
            ncol + 0.5), ylim = c(0.5, nrow + 0.5), xaxs = "i",
            yaxs = "i", xlab = "", ylab = "")
        rect(rep(0.5, nrow), seq(0.5, nrow, 1), rep(ncol + 0.5,
            nrow), seq(1.5, nrow + 1, 1), lwd = 1, ...)
        idx = sample(nrow, size)
        for (j in 1:nrow) {
            points(1:pop[j], rep(j, pop[j]), col = p.col[1],
                cex = p.cex[1], pch = 19)
            if (j %in% idx)
                points(1:pop[j], rep(j, pop[j]), col = p.col[2],
                  cex = p.cex[2])
        }
        Sys.sleep(interval)
    }
    invisible(NULL)
}