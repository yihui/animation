##' Brownian Motion in a circle.
##' Several points moving randomly in a circle.
##'
##' This is a solution to the question raised in R-help:
##' \url{https://stat.ethz.ch/pipermail/r-help/2008-December/183018.html}.
##'
##' @param n number of points
##' @param col colors of points
##' @param \dots other parameters passed to \code{\link[graphics]{points}}
##' @return Invisible \code{NULL}.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link{brownian.motion}}, \code{\link[stats]{rnorm}}
##' @references \url{http://animation.yihui.name/prob:brownian_motion_circle}
##' @keywords dynamic
##' @examples
##'
##' oopt = ani.options(interval = 0.1, nmax = 300)
##' opar = par(mar = rep(0.5, 4))
##' BM.circle(cex = 2, pch = 19)
##'
##' \dontrun{
##' ani.options(ani.height = 450, ani.width = 450,
##'     interval = 0.05, nmax = 100, title = "Brownian Motion in a Circle",
##'     description = "Brownian Motion in a circle.")
##' ani.start()
##' par(mar = rep(0.5, 4))
##' BM.circle(cex = 2, pch = 19)
##' ani.stop()
##' }
##'
##' par(opar)
##' ani.options(oopt)
##'
##'
BM.circle = function(n = 20, col = rainbow(n), ...) {
    par(pty = "s", ann = FALSE, xaxt = "n", yaxt = "n", bty = "n")
    theta = seq(0, 2 * pi, length = 512)
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    x = runif(n, -1, 1)
    y = runif(n, -1, 1)
    for (i in 1:nmax) {
        plot(sin(theta), cos(theta), type = "l", lwd = 5)
        x = x + rnorm(n, 0, 0.1)
        y = y + rnorm(n, 0, 0.1)
        cond = x^2 + y^2 > 1
        r = sqrt(x[cond]^2 + y[cond]^2)
        x[cond] = x[cond]/r/1.1
        y[cond] = y[cond]/r/1.1
        points(x, y, col = col, ...)
        Sys.sleep(interval)
    }
    invisible(NULL)
}

