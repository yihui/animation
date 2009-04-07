`buffon.needle` <- function(l = 0.8, d = 1, redraw = TRUE,
    mat = matrix(c(1, 3, 2, 3), 2), heights = c(3, 2), col = c("lightgray",
        "red", "gray", "red", "blue", "black", "red"), expand = 0.4,
    type = "l", ...) {
    j = 1
    n = 0
    PI = rep(NA, ani.options("nmax"))
    x = y = x0 = y0 = phi = ctr = NULL
    layout(mat, heights = heights)
    interval = ani.options("interval")
    while (j <= length(PI)) {
        plot(1, xlim = c(-0.5 * l, 1.5 * l), ylim = c(0, 2 *
            d), type = "n", xlab = "", ylab = "", axes = FALSE)
        axis(1, c(0, l), c("", ""), tcl = -1)
        axis(1, 0.5 * l, "L", font = 3, tcl = 0, cex.axis = 1.5,
            mgp = c(0, 0.5, 0))
        axis(2, c(0.5, 1.5) * d, c("", ""), tcl = -1)
        axis(2, d, "D", font = 3, tcl = 0, cex.axis = 1.5, mgp = c(0,
            0.5, 0))
        box()
        bd = par("usr")
        rect(bd[1], 0.5 * d, bd[2], 1.5 * d, col = col[1])
        abline(h = c(0.5 * d, 1.5 * d), lwd = 2)
        phi = c(phi, runif(1, 0, pi))
        ctr = c(ctr, runif(1, 0, 0.5 * d))
        y = c(y, sample(c(0.5 * d + ctr[j], 1.5 * d - ctr[j]),
            1))
        x = c(x, runif(1, 0, l))
        x0 = c(x0, 0.5 * l * cos(phi[j]))
        y0 = c(y0, 0.5 * l * sin(phi[j]))
        if (redraw) {
            segments(x - x0, y - y0, x + x0, y + y0, col = col[2])
        }
        else {
            segments(x[j] - x0[j], y[j] - y0[j], x[j] + x0[j],
                y[j] + y0[j], col = col[2])
        }
        xx = seq(0, pi, length = 200)
        plot(xx, 0.5 * l * sin(xx), type = "l", ylim = c(0, 0.5 *
            d), bty = "l", xlab = "", ylab = "", col = col[3])
        if (redraw) {
            points(phi, ctr, col = c(col[4], col[5])[as.numeric(ctr >
                0.5 * l * sin(phi)) + 1])
        }
        else {
            points(phi[j], ctr[j], col = c(col[4], col[5])[as.numeric(ctr[j] >
                0.5 * l * sin(phi[j])) + 1])
        }
        text(pi/2, 0.4 * l, expression(y == frac(L, 2) * sin(phi)),
            cex = 1.5)
        n = n + (ctr[j] <= 0.5 * l * sin(phi[j]))
        if (n > 0)
            PI[j] = 2 * l * j/(d * n)
        plot(PI, ylim = c((1 - expand) * pi, (1 + expand) * pi),
            xlab = paste("Times of Dropping:", j), ylab = expression(hat(pi)),
            col = col[6], type = type, ...)
        abline(h = pi, lty = 2, col = col[7])
        legend("topright", legend = eval(substitute(expression(hat(pi) ==
                pihat), list(pihat = format(PI[j], nsmall = 7, digits = 7)))),
                bty = "n", cex = 1.3)
        Sys.sleep(interval)
        j = j + 1
    }
    invisible(PI)
}
