MC.samplemean <-
function(FUN = function(x) x - x^2, 
    n = ani.options("nmax"), col.rect = c('gray', 'black'), adj.x = TRUE, ...) {
    nmax = n
    x = runif(n)
    y = FUN(x)
    xx = if (adj.x) 
        seq(0, 1, length.out = nmax)[rank(x, ties.method = "random")]
    else x
    for (i in 1:nmax) {
        curve(FUN, from = 0, to = 1, ylab = eval(substitute(expression(y == 
            x), list(x = body(FUN)))))
        rect(xx[1:i] - 0.5/nmax, 0, xx[1:i] + 0.5/nmax, y[1:i], 
            col = c(rep(col.rect[1], i - 1), col.rect[2]), ...)
        abline(h = 0, col = "gray")
        curve(FUN, from = 0, to = 1, add = TRUE)
        rug(x)
        rug(x[i], lwd = 2, side = 3, col = col.rect[2])
        Sys.sleep(ani.options("interval"))
    }
    ani.options(nmax = nmax)
    invisible(list(x = x, y = y, n = nmax, est = mean(y)))
}

