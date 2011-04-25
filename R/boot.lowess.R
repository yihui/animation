##' Bootstrapping with LOWESS.
##' Sample the original data with replacement and fit LOWESS curves accordingly.
##'
##' We keep on resampling the data and finally we will see several
##' bootstrapped LOWESS curves, which may give us a rough idea about a
##' ``confidence interval'' of the LOWESS fit.
##' @param x,y,f,iter passed to \code{\link[stats]{lowess}}
##' @param line.col the color of the LOWESS lines
##' @param ... other arguments passed to the scatterplot by \code{\link[graphics]{plot}}
##' @return NULL
##' @author Yihui Xie <\url{http://yihui.name}>
##' @examples
##' oopt = ani.options(nmax = if (interactive()) 100 else 2, interval = .02)
##'
##' boot.lowess(cars, pch = 20, xlab = 'speed', ylab = 'dist')
##'
##' boot.lowess(cars, f = 1/3, pch = 20)
##'
##' ## save in HTML pages
##' saveHTML({
##' par(mar = c(4.5,4,.5,.5))
##' boot.lowess(cars, f = 1/3, pch = 20, xlab='speed', ylab='dist')
##' }, img.name='boot_lowess', imgdir='boot_lowess', interval=.1,
##' title='Bootstrapping with LOWESS',
##' description='Fit LOWESS curves repeatedly via bootstrapping.')
##'
##' ani.options(oopt)
##'
boot.lowess = function(x, y = NULL, f = 2/3, iter = 3, line.col = "#FF000033", ...) {
    if (missing(x)) {
        x = cars[, 1]
        y = cars[, 2]
    }
    if (NCOL(x) > 1) {
        y = x[, 2]
        x = x[, 1]
    }
    idx = replicate(ani.options('nmax'), sample(length(x), replace = TRUE))
    for (i in 1:ncol(idx)) {
        plot(x, y, ...)
        apply(idx[, 1:i, drop = FALSE], 2, function(j) {
            lines(lowess(x[j], y[j], f = f, iter = iter), col = line.col)
        })
        ani.pause()
    }
}
