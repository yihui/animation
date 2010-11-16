MC.hitormiss <-
function(FUN = function(x) x - x^2, 
    n = ani.options("nmax"), from = 0, to = 1, col.points = c("black", 
        "red"), pch.points = c(20, 4), ...) {
    nmax = n
    x1 = runif(n, from, to)
    ymin = optimize(FUN, c(from, to), maximum = FALSE)$objective
    ymax = optimize(FUN, c(from, to), maximum = TRUE)$objective
    x2 = runif(n, ymin, ymax)
    y = FUN(x1)
    if (any(y < 0)) 
        stop("This Hit-or-Miss Monte Carlo algorithm only applies to\n", 
            "_non-negative_ functions!")
    for (i in 1:nmax) {
        curve(FUN, from = from, to = to, ylab = eval(substitute(expression(y == 
            x), list(x = body(FUN)))))
        points(x1[1:i], x2[1:i], col = col.points[(x2[1:i] > 
            y[1:i]) + 1], pch = pch.points[(x2[1:i] > y[1:i]) + 
            1], ...)
        curve(FUN, from = from, to = to, add = TRUE)
        Sys.sleep(ani.options("interval"))
    }
    ani.options(nmax = nmax)
    invisible(list(x1 = x1, x2 = x2, y = y, n = nmax, est = mean(x2 < 
        y) * ((to - from) * (ymax - ymin))))
}

