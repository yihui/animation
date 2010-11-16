`kmeans.ani` <- function(x = matrix(runif(100), ncol = 2,
    dimnames = list(NULL, c("X1", "X2"))), centers = 3, pch = 1:3,
    col = 1:3, hints = c("Move centers!", "Find cluster?")) {
    x = as.matrix(x)
    ocluster = sample(centers, nrow(x), replace = TRUE)
    if (length(centers) == 1)
        centers = x[sample(nrow(x), centers), ]
    else centers = as.matrix(centers)
    numcent = nrow(centers)
    dst = matrix(nrow = nrow(x), ncol = numcent)
    j = 1
    pch = rep(pch, length = numcent)
    col = rep(col, length = numcent)
    interval = ani.options("interval")
    while (j <= ani.options("nmax")) {
        plot(x, pch = pch[ocluster], col = col[ocluster], panel.first = grid())
        mtext(hints[1], 4)
        points(centers, pch = pch[1:numcent], cex = 3,
            lwd = 2, col = col[1:numcent])
        j = j + 1
        Sys.sleep(interval)
        for (i in 1:numcent) {
            dst[, i] = sqrt(apply((t(t(x) - unlist(centers[i,
                ])))^2, 1, sum))
        }
        ncluster = apply(dst, 1, which.min)
        plot(x, type = "n")
        mtext(hints[2], 4)
        grid()
        ocenters = centers
        for (i in 1:numcent) {
            xx = subset(x, ncluster == i)
            polygon(xx[chull(xx), ], density = 10, col = col[i],
                lty = 2)
            points(xx, pch = pch[i], col = col[i])
            centers[i, ] = apply(xx, 2, mean)
        }
        points(ocenters, cex = 3, col = col[1:numcent],
            pch = pch[1:numcent], lwd = 2)
        j = j + 1
        Sys.sleep(interval)
        if (all(ncluster == ocluster))
            break
        ocluster = ncluster
    }
    ani.options(nmax = j - 1)
    invisible(list(cluster = ncluster, centers = centers))
}
