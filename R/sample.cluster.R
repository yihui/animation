`sample.cluster` <- function(pop = ceiling(10 * runif(10,
    0.2, 1)), size = 3, p.col = c("blue", "red"), p.cex = c(1,
    3), ...) {
    if (size > length(pop))
        stop("sample size must be smaller than the number of clusters")
    ncol = max(pop)
    nrow = length(pop)
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    for (i in 1:nmax) {
        plot(1, axes = FALSE, ann = FALSE, type = "n", xlim = c(0.5,
            ncol + 0.5), ylim = c(0.5, nrow + 0.5), xaxs = "i",
            yaxs = "i", xlab = "", ylab = "")
        rect(rep(0.5, nrow), seq(0.5, nrow, 1), rep(ncol + 0.5,
            nrow), seq(1.5, nrow + 1, 1), lwd = 1, ...)
        idx = sample(nrow, size)
        for (j in 1:nrow) {
            points(1:pop[j], rep(j, pop[j]), col = p.col[1],
                cex = p.cex[1], pch = 19)
            if (j %in% idx)
                points(1:pop[j], rep(j, pop[j]), col = p.col[2],
                  cex = p.cex[2])
        }
        Sys.sleep(interval)
    }
    invisible(NULL)
}
