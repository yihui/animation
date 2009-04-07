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
