`lln.ani` <- function(FUN = rnorm, mu = 0, np = 30,
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
    interval = ani.options("interval")
    for (i in 1:n) {
        plot(1:n, ylim = rg, type = "n", xlab = paste("n =", i),
            ylab = expression(bar(x)), xaxt = "n")
        axis(1, xax[xax <= i])
        polygon(c(1:i, i:1), c(x[1:i, 1], x[i:1, 2]), border = NA,
            col = col.poly)
        points(rep(1:i, each = np), m[1:(i * np)], pch = pch, ...)
        abline(h = mu, col = col.mu)
        Sys.sleep(interval)
    }
}
