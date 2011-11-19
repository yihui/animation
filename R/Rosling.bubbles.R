##' The bubbles animation in Hans Rosling's Talk
##'
##' In Hans Rosling's attractive talk ``Debunking third-world myths
##' with the best stats you've ever seen'', he used a lot of bubble
##' plots to illustrate trends behind the data over time. This
##' function gives an imitation of those moving bubbles, besides, as
##' this function is based on \code{\link[graphics]{symbols}}, we can
##' also make use of other symbols such as squares, rectangles,
##' thermometers, etc.
##'
##' Suppose we have observations of \eqn{n} individuals over
##' \code{ani.options("nmax")} years. In this animation, the data of
##' each year will be shown in the bubbles (symbols) plot; as time
##' goes on, certain trends will be revealed (like those in Rosling's
##' talk). Please note that the arrangement of the data for bubbles
##' (symbols) should be a matrix like \eqn{A_{ijk}} in which \eqn{i}
##' is the individual id (from 1 to n), \eqn{j} denotes the \eqn{j}-th
##' variable (from 1 to p) and \eqn{k} indicates the time from 1 to
##' \code{ani.options('nmax')}.
##'
##' And the length of \code{x} and \code{y} should be equal to the
##' number of rows of this matrix.
##'
##' @param x,y the x and y co-ordinates for the centres of the bubbles
##' (symbols). Default to be 10 uniform random numbers in [0, 1] for
##' each single image frame (so the length should be 10 *
##' \code{ani.options("nmax")})
##' @param circles,squares,rectangles,stars,thermometers,boxplots
##' different symbols; see \code{\link[graphics]{symbols}}. Default to
##' be \code{circles}.
##' @param inches,fg,bg,xlab,ylab,main,xlim,ylim,\dots see
##' \code{\link[graphics]{symbols}}. Note that \code{bg} has default
##' values taking semi-transparent colors.
##' @param grid logical; add a grid to the plot?
##' @param text a character vector to be added to the plot one by one
##' (e.g. the year in Rosling's talk)
##' @param text.col,text.cex color and magnification of the background
##' text
##' @return \code{NULL}.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[graphics]{symbols}}
##' @references \url{http://animation.yihui.name/da:ts:hans_rosling_s_talk}
##'
##' \url{http://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen.html}
##' @keywords dynamic
##' @example inst/examples/Rosling.bubbles-ex.R
Rosling.bubbles = function(x, y, circles, squares,
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
    md = c(mean(xlim), mean(ylim))
    for (i in 1:nmax) {
        dev.hold()
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
        ani.pause()
    }
}

