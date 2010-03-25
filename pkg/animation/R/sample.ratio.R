sample.ratio <-
function(X = runif(50, 0, 5), R = 1, 
    Y = R * X + rnorm(X), size = length(X)/2, p.col = c("blue", 
        "red"), p.cex = c(1, 3), p.pch = c(20, 21), m.col = c("black", 
        "gray"), legend.loc = "topleft", ...) {
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    N = length(X)
    r = est1 = est2 = numeric(nmax)
    for (i in 1:nmax) {
        idx = sample(N, size)
        plot(X, Y, col = p.col[1], pch = p.pch[1], cex = p.cex[1], 
            ...)
        points(X[idx], Y[idx], col = p.col[2], pch = p.pch[2],
            cex = p.cex[2])
        abline(v = c(mean(X), mean(X[idx])), h = c(mean(Y), est1[i] <- mean(Y[idx])),
            col = m.col, lty = c(2, 1))
        abline(h = est2[i] <- mean(X) * (r[i] <- est1[i]/mean(X[idx])),
            col = p.col[2])
        legend(legend.loc, expression(bar(X), bar(x), bar(X) %.% 
            (bar(y)/bar(x)), bar(Y), bar(y)), lty = c(2, 1, 1, 
            2, 1), col = c(m.col[c(1, 2)], p.col[2], m.col[c(1, 
            2)]), bty = "n", ncol = 2)
        Sys.sleep(interval)
    }
    invisible(list(X = X, Y = Y, R = R, r = r, Ybar = mean(Y), 
        ybar.simple = est1, ybar.ratio = est2))
}
