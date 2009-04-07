`cv.ani` <- function(x = runif(150), k = 10, col = c("green",
    "red", "blue"), pch = c(4, 1), ...) {
    N = length(x)
    n = sample(N)
    x = x[n]
    kf = cumsum(c(1, kfcv(k, N)))
    j = 1
    interval = ani.options("interval")
    for (i in 2:length(kf)) {
        if (j > ani.options("nmax"))
            break
        plot(x, xlim = c(1, N), type = "n", xlab = "Sample index",
            ylab = "Sample values", xaxt = "n", ...)
        xax = as.integer(pretty(1:N))
        if (xax[1] == 0)
            xax = xax[-1]
        axis(side = 1, xax, n[xax])
        idx = kf[i - 1]:(kf[i] - 1)
        rect(kf[-length(kf)], min(x), kf[-1] - 1, max(x), border = "gray",
            lty = 2)
        rect(kf[i - 1], min(x), kf[i] - 1, max(x), density = 10,
            col = col[1])
        points(idx, x[idx], col = col[2], pch = pch[1], lwd = 2)
        text(mean(idx), quantile(x, prob = 0.75), "Test Set",
            cex = 1.5, col = col[2])
        points(seq(N)[-idx], x[-idx], col = col[3], pch = pch[2],
            lwd = 1)
        text(mean(seq(N)[-idx]), quantile(x, prob = 0.25), "Training Set",
            cex = 1.5, col = col[3])
        Sys.sleep(interval)
        j = j + 1
    }
    ani.options(nmax = j - 1)
    invisible(NULL)
}
