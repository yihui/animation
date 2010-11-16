`newton.method` <- function(FUN = function(x) x^2 -
    4, init = 10, rg = c(-1, 10), tol = 0.001, interact = FALSE,
    col.lp = c("blue", "red", "red"), main, xlab, ylab, ...) {
    if (interact) {
        curve(FUN, min(rg), max(rg), xlab = "x", ylab = eval(substitute(expression(f(x) ==
            y), list(y = body(FUN)))), main = "Locate the starting point")
        init = unlist(locator(1))[1]
    }
    i = 1
    nms = names(formals(FUN))
    grad = deriv(as.expression(body(FUN)), nms, function.arg = TRUE)
    x = c(init, init - FUN(init)/attr(grad(init), "gradient"))
    gap = FUN(x[2])
    if (missing(xlab))
        xlab = nms
    if (missing(ylab))
        ylab = eval(substitute(expression(f(x) == y), list(y = body(FUN))))
    if (missing(main))
        main = eval(substitute(expression("Root-finding by Newton-Raphson Method:" ~
            y == 0), list(y = body(FUN))))
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    while (abs(gap) > tol & i <= nmax & !is.na(x[i + 1])) {
        curve(FUN, min(rg), max(rg), main = main, xlab = xlab,
            ylab = ylab, ...)
        abline(h = 0, col = "gray")
        segments(x[1:i], rep(0, i), x[1:i], FUN(x[1:i]), col = col.lp[1])
        segments(x[1:i], FUN(x[1:i]), x[2:(i + 1)], rep(0, i),
            col = col.lp[2])
        points(x, rep(0, i + 1), col = col.lp[3])
        points(x[1:i], FUN(x[1:i]), col = col.lp[3])
        mtext(paste("Current root:", x[i + 1]), 4)
        gap = FUN(x[i + 1])
        x = c(x, x[i + 1] - FUN(x[i + 1])/attr(grad(x[i + 1]),
            "gradient"))
        Sys.sleep(interval)
        i = i + 1
    }
    rtx = par("usr")[4]
    arrows(x[i], rtx, x[i], 0, col = "gray")
    ani.options(nmax = i - 1)
    invisible(list(root = x[i], value = gap, iter = i - 1))
}
