`clt.ani` <- function(obs = 300, FUN = rexp, col = c("bisque",
    "red", "black"), mat = matrix(1:2, 2), widths = rep(1, ncol(mat)),
    heights = rep(1, nrow(mat)), ...) {
    interval = ani.options("interval")
    nmax = ani.options("nmax")
    x = matrix(nrow = nmax, ncol = obs)
    for (i in 1:nmax) x[i, ] = apply(matrix(replicate(obs,
        FUN(i)), i), 2, mean)
    pvalue = apply(x, 1, function(xx) shapiro.test(xx)$p.value)
    layout(mat, widths, heights)
    for (i in 1:nmax) {
        hist(x[i, ], freq = FALSE, main = "", xlab = substitute(italic(bar(x)[i]),
            list(i = i)), col = col[1])
        lines(density(x[i, ]), col = col[2])
        legend("topright", legend = paste("P-value:", format(round(pvalue[i],
            3), nsmall = 3)), bty = "n")
        plot(pvalue[1:i], xlim = c(1, nmax), ylim = range(pvalue),
            xlab = "n", ylab = "P-value", col = col[3], ...)
        Sys.sleep(interval)
    }
    invisible(data.frame(n = 1:nmax, p.value = pvalue))
}
