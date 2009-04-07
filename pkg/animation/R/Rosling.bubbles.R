`Rosling.bubbles` <-
function(x, y, circles, squares,
    rectangles, stars, thermometers, boxplots, inches = TRUE,
    fg = par("col"), bg, xlab = "x", ylab = "y", main = NULL,
    xlim = range(x), ylim = range(y), ..., grid = TRUE, text = 1:ani.options("nmax"),
    text.col = rgb(0, 0, 0, 0.5), text.cex = 5) {
    nmax = ani.options("nmax")
    count = 0
    if (!missing(circles)) {
        count = count + 1
        data = circles
        type = 1
    }
    if (!missing(squares)) {
        count = count + 1
        data = squares
        type = 2
    }
    if (!missing(rectangles)) {
        count = count + 1
        data = rectangles
        type = 3
    }
    if (!missing(stars)) {
        count = count + 1
        data = stars
        type = 4
    }
    if (!missing(thermometers)) {
        count = count + 1
        data = thermometers
        type = 5
    }
    if (!missing(boxplots)) {
        count = count + 1
        data = boxplots
        type = 6
    }
    if (count != 1) {
        n = 10
        data = matrix(runif(n * nmax))
        type = 1
    }
    if (is.null(dim(data))) data = matrix(data)
    n = nrow(data)%/%nmax
    if (missing(x))
        x = runif(n) + sort(rnorm(n * nmax, 0, 0.02))
    if (missing(y))
        y = runif(n) + sort(rnorm(n * nmax, 0, 0.02))
    if (missing(bg))
        bg = rgb(runif(n), runif(n), runif(n), 0.5)
    interval = ani.options("interval")
    md = c(mean(xlim), mean(ylim))
    for (i in 1:nmax) {
        xy = xy.coords(x[((i - 1) * n + 1):(n * i)], y[((i -
            1) * n + 1):(n * i)], xlab = deparse(substitute(x)),
            ylab = deparse(substitute(y)))
        xi = xy$x
        yi = xy$y
        plot(NA, NA, type = "n", xlim = xlim, ylim = ylim, xlab = xlab,
            ylab = ylab, main = main, panel.first = {
                if (grid)
                  grid()
                text(md[1], md[2], text[i], col = text.col, cex = text.cex)
            }, ...)
        .Internal(symbols(xi, yi, type, data[((i - 1) * n + 1):(n *
            i), ], inches, bg, fg, ...))
        Sys.sleep(interval)
    }
}

