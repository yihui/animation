

##' Demonstration of Confidence Intervals
##' This function gives a demonstration of the concept of confidence intervals
##' in mathematical statistics.
##' 
##' Keep on drawing samples from the Normal distribution N(0, 1), computing the
##' intervals based on a given confidence level and plotting them as segments
##' in a graph. In the end, we may check the coverage rate against the given
##' confidence level.
##' 
##' Intervals that cover the true parameter are denoted in color \code{cl[2]},
##' otherwise in color \code{cl[1]}. Each time we draw a sample, we can compute
##' the corresponding confidence interval. As the process of drawing samples
##' goes on, there will be a legend indicating the numbers of the two kinds of
##' intervals respectively and the coverage rate is also denoted in the
##' top-left of the plot.
##' 
##' The argument \code{nmax} in \code{\link{ani.options}} controls the maximum
##' times of drawing samples.
##' 
##' @param level the confidence level \eqn{(1 - \alpha)}, e.g. 0.95
##' @param size the sample size for drawing samples from N(0, 1)
##' @param cl two different colors to annotate whether the confidence intervals
##'   cover the true mean (\code{cl[1]}: yes; \code{cl[2]}: no)
##' @param \dots other arguments passed to \code{\link{plot}}
##' @return A list containing \item{level confidence level} \item{size sample
##'   size} \item{CIa matrix of confidence intervals for each sample}
##'   \item{CRcoverage rate}
##' @author Yihui Xie <\url{http://yihui.name}>
##' @references George Casella and Roger L. Berger. \emph{Statistical
##'   Inference}. Duxbury Press, 2th edition, 2001.
##' 
##' \url{http://animation.yihui.name/mathstat:confidence_interval}
##' @keywords dynamic dplot distribution
##' @examples
##' 
##' oopt = ani.options(interval = 0.1, nmax = 100)
##' # 90% interval
##' conf.int(0.90, main = "Demonstration of Confidence Intervals")
##' 
##' \dontrun{
##' # save the animation in HTML pages
##' ani.options(ani.height = 400, ani.width = 600, nmax = 100,
##'     interval = 0.15, title = "Demonstration of Confidence Intervals",
##'     description = "This animation shows the concept of the confidence
##'     interval which depends on the observations: if the samples change,
##'     the interval changes too. At last we can see that the coverage rate
##'     will be approximate to the confidence level.")
##' ani.start()
##' par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
##' conf.int()
##' ani.stop() 
##' }
##' 
##' ani.options(oopt)
##' 
`conf.int` <- function(level = 0.95, size = 50, cl = c("red",
    "gray"), ...) {
    n = ani.options("nmax")
    d = replicate(n, rnorm(size))
    m = colMeans(d)
    z = qnorm(1 - (1 - level)/2)
    y0 = m - z/sqrt(size)
    y1 = m + z/sqrt(size)
    rg = range(c(y0, y1))
    cvr = y0 < 0 & y1 > 0
    xax = pretty(1:n)
    interval = ani.options("interval")
    for (i in 1:n) {
        plot(1:n, ylim = rg, type = "n", xlab = "Samples", ylab = expression("CI: [" ~
            bar(x) - z[alpha/2] * sigma/sqrt(n) ~ ", " ~ bar(x) +
            z[alpha/2] * sigma/sqrt(n) ~ "]"), xaxt = "n", ...)
        abline(h = 0, lty = 2)
        axis(1, xax[xax <= i])
        arrows(1:i, y0[1:i], 1:i, y1[1:i], length = par("din")[1]/n *
            0.5, angle = 90, code = 3, col = c("red", "gray")[cvr[1:i] +
            1])
        points(1:i, m[1:i], col = cl[cvr[1:i] + 1])
        legend("topright", legend = format(c(i - sum(cvr[1:i]),
            sum(cvr[1:i])), width = nchar(n)), fill = cl, bty = "n",
            ncol = 2)
        legend("topleft", legend = paste("coverage rate:", format(round(mean(cvr[1:i]),
            3), nsmall = 3)), bty = "n")
        Sys.sleep(interval)
    }
    CI = cbind(y0, y1)
    colnames(CI) = paste(round(c((1 - level)/2, 1 - (1 - level)/2),
        2) * 100, "%")
    rownames(CI) = 1:n
    invisible(list(level = level, size = size, CI = CI, CR = mean(cvr)))
}
