ecol.death.sim <-
function(nr = 10, nc = 10, num.sp = c(50, 50), col.sp = c(1, 
    2), pch.sp = c(1, 2), col.die = 1, pch.die = 4, cex = 3, ...) {
    x = rep(1:nc, nr)
    y = rep(1:nr, each = nc)
    p = factor(sample(rep(1:2, num.sp)), levels = 1:2)
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    for (i in 1:nmax) {
        plot(1:nc, 1:nr, type = "n", xlim = c(0.5, nc + 0.5), 
            ylim = c(0.5, nr + 0.5), ...)
        abline(h = 1:nr, v = 1:nc, col = "lightgray", lty = 3)
        points(x, y, col = col.sp[p], pch = pch.sp[p], cex = cex)
        Sys.sleep(interval)
        idx = sample(nr * nc, 1)
        points(x[idx], y[idx], pch = pch.die, col = col.die, 
            cex = cex, lwd = 3)
        tbl = as.vector(table(p))
        tbl = tbl + if (as.integer(p[idx]) > 1) c(0, -1) else c(-1, 0)
        p[idx] = sample(1:2, 1, prob = tbl)
        Sys.sleep(interval)
    }
    ani.options(nmax = 2 * nmax)
    invisible(p)
}

