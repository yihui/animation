`boot.iid` <- function(x = runif(20), statistic = mean,
    m = length(x), mat = matrix(1:2, 2), widths = rep(1, ncol(mat)),
    heights = rep(1, nrow(mat)), col = c("black", "red", "bisque",
        "red", "gray"), cex = c(1.5, 0.8), main = c("Bootstrapping the i.i.d data",
        "Density of bootstrap estimates"), ...) {
    idx = replicate(ani.options("nmax"), sample(length(x), m,
        TRUE))
    xx = matrix(x[idx], nrow = m)
    xest = apply(xx, 2, statistic)
    xrg = range(hist(xest, plot = FALSE)$breaks)
    layout(mat, widths, heights)
    interval = ani.options("interval")
    for (i in 1:ani.options("nmax")) {
        sunflowerplot(idx[, i], xx[, i], col = col[2], cex = cex[2],
            xlim = c(1, length(x)), ylim = range(x) + c(-1, 1) *
                diff(range(x)) * 0.1, panel.first = points(x,
                col = col[1], cex = cex[1]), xlab = "", ylab = "x",
            main = main[1], ...)
        hist(xest[1:i], freq = FALSE, main = main[2], col = col[3],
            xlab = "", xlim = xrg)
        if (i > 1) lines(density(xest[1:i]), col = col[4]) else axis(2)
        rug(xest[1:i], col = col[5])
        axis(1)
        Sys.sleep(interval)
    }
    invisible(list(t0 = statistic(x), tstar = xx))
}
