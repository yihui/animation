`brownian.motion` <- function(n = 10, xlim = c(-20,
    20), ylim = c(-20, 20), ...) {
    x = rnorm(n)
    y = rnorm(n)
    interval = ani.options("interval")
    for (i in seq_len(ani.options("nmax"))) {
        plot(x, y, xlim = xlim, ylim = ylim, ...)
        text(x, y)
        x = x + rnorm(n)
        y = y + rnorm(n)
        Sys.sleep(interval)
    }
    invisible(NULL)
}
