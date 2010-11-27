

##' Demonstration for systematic sampling
##' The whole sample frame is denoted by a matrix (\code{nrow * ncol}) in the
##' plane, and the sample points with equal intervals are drawn out according
##' to a random starting point. The points being sampled are marked by red
##' circles.
##' 
##' 
##' @param nrow the desired number of rows of the sample frame.
##' @param ncol the desired number of columns of the sample frame.
##' @param size the sample size.
##' @param p.col, p.cex different colors / magnification rate to annotate the
##'   population and the sample
##' @return None (invisible `\code{NULL}').
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link{sample}}, \code{\link{sample.simple}},
##'   \code{\link{sample.cluster}}, \code{\link{sample.ratio}},
##'   \code{\link{sample.strat}}
##' @references Cochran, W G (1977) \emph{Sampling Techniques}, Wiley, ISBN
##'   0-471-16240-X
##' 
##' \url{http://animation.yihui.name/samp:systematic_sampling}
##' @keywords distribution dynamic
##' @examples
##' 
##' oopt = ani.options(interval = 1, nmax = 30)
##' op = par(mar = rep(1, 4), lwd = 2)
##' sample.system()
##' par(op)
##' 
##' \dontrun{
##' # HTML animation page
##' ani.options(ani.height = 350, ani.width = 500, outdir = getwd(), nmax = 30,
##'     interval = 1, title = "Demonstration of the systematic sampling",
##'     description = "Sampling with equal distances.")
##' ani.start()
##' par(mar = rep(1, 4), lwd = 2)
##' sample.system()
##' ani.stop()
##' }
##' ani.options(oopt)
##' 
`sample.system` <- function(nrow = 10, ncol = 10, size = 15,
    p.col = c("blue", "red"), p.cex = c(1, 3)) {
    n = nrow * ncol
    if (size > n)
        stop("sample size must be smaller than the population")
    x = cbind(rep(1:ncol, nrow), gl(nrow, ncol))
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    for (i in 1:nmax) {
        plot(x, pch = 19, col = p.col[1], cex = p.cex[1], axes = FALSE,
            ann = FALSE, xlab = "", ylab = "")
        points(x[seq(sample(n, 1), by = n%/%size, length = size)%%n,
            ], col = p.col[2], cex = p.cex[2])
        box(lwd = 1)
        Sys.sleep(interval)
    }
    invisible(NULL)
}
