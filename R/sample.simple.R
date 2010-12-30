##' Demonstration for simple random sampling without replacement.
##'
##' The whole sample frame is denoted by a matrix (\code{nrow * ncol})
##' in the plane just for convenience, and the points being sampled
##' are marked out (by red circles by default). Each member of the
##' population has an equal and known chance of being selected.
##'
##' @param nrow the desired number of rows of the sample frame.
##' @param ncol the desired number of columns of the sample frame.
##' @param size the sample size.
##' @param p.col,p.cex different colors /magnification rate to
##' annotate the population and the sample
##' @return None (invisible \code{NULL}).
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[base]{sample}}, \code{\link{sample.ratio}},
##' \code{\link{sample.cluster}}, \code{\link{sample.strat}},
##' \code{\link{sample.system}}
##' @references \url{http://animation.yihui.name/samp:srswr}
##' @keywords distribution dynamic
##' @examples
##'
##' oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
##' par(mar = rep(1, 4))
##' sample.simple()
##'
##' ## HTML animation page
##' saveHTML({
##' par(mar = rep(1, 4), lwd = 2)
##' ani.options(nmax = ifelse(interactive(), 50, 2))
##' sample.simple()
##' }, img.name='sample.simple',htmlfile='sample.html',
##' ani.height = 350, ani.width = 500,
##'     title = "Demonstration of the simple random sampling without replacement",
##'     description = c("Each member of the population has an equal and",
##' "known chance of being selected."))
##'
##' ani.options(oopt)
##'
sample.simple = function(nrow = 10, ncol = 10, size = 15,
    p.col = c("blue", "red"), p.cex = c(1, 3)) {
    if (size > nrow * ncol)
        stop("sample size must be smaller than the population")
    x = cbind(rep(1:ncol, nrow), gl(nrow, ncol))
    nmax = ani.options("nmax")
    for (i in 1:nmax) {
        plot(x, pch = 19, col = p.col[1], cex = p.cex[1], axes = FALSE,
            ann = FALSE, xlab = "", ylab = "")
        points(x[sample(nrow * ncol, size), ], col = p.col[2],
            cex = p.cex[2])
        box(lwd = 1)
        ani.pause()
    }
    invisible(NULL)
}
