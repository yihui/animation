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
