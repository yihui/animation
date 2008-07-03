`flip.coin` <- function(faces = 2, prob = NULL, border = "white",
    grid = "white", col = 1:2, type = "p", pch = 21, bg = "transparent",
    digits = 3) {
    nmax = ani.options("nmax")
    if (length(faces) == 1) {
        faces = as.factor(seq(faces))
    }
    else {
        faces = as.factor(faces)
    }
    if (length(faces) < 2)
        stop("'faces' must be at least 2")
    lv = levels(faces)
    n = length(lv)
    res = sample(faces, nmax, replace = TRUE, prob = prob)
    frq = table(res)/nmax
    ylm = max(frq)
    x = runif(nmax, 1.1, 1.9)
    y = runif(nmax, 0, ylm)
    col = rep(col, length = n)
    y0 = numeric(n)
    s = seq(0, ylm, 1/nmax)
    interval = ani.options("interval")
    for (i in 1:nmax) {
        plot(1, xlim = c(0, 2), ylim = c(0, ylm * 1.04), type = "n",
            axes = FALSE, xlab = "", ylab = "", xaxs = "i", yaxs = "i")
        abline(v = 1)
        axis(1, (1:n - 0.5)/n, lv)
        axis(2)
        mtext("Frequency", side = 2, line = 2)
        mtext("Flip 'coins'", side = 4)
        k = as.integer(res[1:i])
        points(x[1:i], y[1:i], cex = 3, col = col[k], type = type,
            pch = pch, bg = bg)
        text(x[1:i], y[1:i], res[1:i], col = col[k])
        y0[k[i]] = y0[k[i]] + 1
        rect(seq(n)/n - 1/n, 0, seq(n)/n, y0/nmax, border = border,
            col = col)
        segments(0, s, 1, s, col = grid)
        abline(v = 1)
        axis(3, (1:n - 0.5)/n, paste(y0, " (", round(y0/nmax,
            digits = digits), ")", sep = ""), tcl = 0, mgp = c(0,
            0.5, 0))
        axis(1, 1.5, paste("Number of Tosses:", i), tcl = 0)
        Sys.sleep(interval)
        box()
    }
    invisible(list(freq = as.matrix(frq)[, 1], nmax = i))
}
