##' Demonstration of Law of Large Numbers.
##' This function plots the sample mean as the sample size grows to check
##' whether the sample mean approaches to the population mean.
##'
##' \code{np} points are plotted to denote the distribution of the sample mean;
##' we will observe that the range of the sample mean just becomes smaller and
##' smaller as the sample size increases and ultimately there will be an
##' obvious trend that the sample mean converges to the population mean
##' \code{mu}.
##'
##' The parameter \code{nmax} in \code{\link{ani.options}} means the maximum
##' sample size.
##'
##' @param FUN a function to generate random numbers from a certain
##' distribution: \code{function(n, mu)}
##' @param mu population mean; passed to \code{FUN}
##' @param np times for sampling from a distribution (not the sample
##' size!); to examine the behaviour of the sample mean, we need more
##' times of sampling to get a series of mean values
##' @param pch symbols for points; see Details
##' @param col.poly the color of the polygon to annotate the range of
##' sample means
##' @param col.mu the color of the horizontal line which denotes the
##' population mean
##' @param \dots other arguments passed to
##' \code{\link[graphics]{points}}
##' @return None (invisible \code{NULL}).
##' @note The argument \code{pch} will influence the speed of
##' plotting, and for a very large sample size (say, 300), it is
##' suggested that this argument be specified as `\code{.}'.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @references
##' \url{http://animation.yihui.name/prob:law_of_large_numbers}
##' @keywords dynamic dplot distribution
##' @examples
##'
##' oopt = ani.options(interval = 0.01, nmax = ifelse(interactive(), 150, 2))
##'
##' lln.ani(pch = ".")
##'
##' ## chi-square distribution; population mean = df
##' lln.ani(FUN = function(n, mu) rchisq(n, df = mu), mu = 5, cex = 0.6)
##'
##' ## save the animation in HTML pages
##' saveHTML({
##' par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
##' ani.options(interval = 0.1, nmax = ifelse(interactive(), 150, 2))
##' lln.ani(cex = 0.6)
##' }, img.name='lln.ani',htmlfile='lln.ani.html',
##' ani.height = 480, ani.width = 600,
##'     title = "Demonstration of the Law of Large Numbers",
##'     description = c("The sample mean approaches to the population mean as",
##'     "the sample size n grows."))
##'
##' ani.options(oopt)
##'
lln.ani = function(FUN = rnorm, mu = 0, np = 30,
    pch = 20, col.poly = "bisque", col.mu = "gray", ...) {
    n = ani.options("nmax")
    m = x = NULL
    for (i in 1:n) {
        d = colMeans(matrix(replicate(np, FUN(i, mu)), i))
        m = c(m, d)
        x = rbind(x, range(d))
    }
    rg = range(m)
    xax = pretty(1:n)
    for (i in 1:n) {
        plot(1:n, ylim = rg, type = "n", xlab = paste("n =", i),
            ylab = expression(bar(x)), xaxt = "n")
        axis(1, xax[xax <= i])
        polygon(c(1:i, i:1), c(x[1:i, 1], x[i:1, 2]), border = NA,
            col = col.poly)
        points(rep(1:i, each = np), m[1:(i * np)], pch = pch, ...)
        abline(h = mu, col = col.mu)
        ani.pause()
    }
}
