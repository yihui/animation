`brownian.motion` <- function(n = 10, xlim = c(-20,
    20), ylim = c(-20, 20), ...) {
    x = rnorm(n)
    y = rnorm(n)
    i = 1
    interval = ani.options("interval")
    while (i <= ani.options("nmax")) {
        plot(x, y, xlim = xlim, ylim = ylim, ...)
        text(x, y)
        x = x + rnorm(n)
        y = y + rnorm(n)
        i = i + 1
        Sys.sleep(interval)
    }
    invisible(NULL)
}
