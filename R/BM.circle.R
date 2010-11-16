`BM.circle` <-
function(n = 20, col = rainbow(n), ...) {
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

