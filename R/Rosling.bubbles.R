#' The bubbles animation in Hans Rosling's Talk
#'
#' In Hans Rosling's attractive talk ``Debunking third-world myths with the best
#' stats you've ever seen'', he used a lot of bubble plots to illustrate trends
#' behind the data over time. This function gives an imitation of those moving
#' bubbles, besides, as this function is based on \code{\link{symbols}}, we can
#' also make use of other symbols such as squares, rectangles, thermometers,
#' etc.
#'
#' Suppose we have observations of \eqn{n} individuals over
#' \code{ani.options('nmax')} years. In this animation, the data of each year
#' will be shown in the bubbles (symbols) plot; as time goes on, certain trends
#' will be revealed (like those in Rosling's talk). Please note that the
#' arrangement of the data for bubbles (symbols) should be a matrix like
#' \eqn{A_{ijk}} in which \eqn{i} is the individual id (from 1 to n), \eqn{j}
#' denotes the \eqn{j}-th variable (from 1 to p) and \eqn{k} indicates the time
#' from 1 to \code{ani.options('nmax')}.
#'
#' And the length of \code{x} and \code{y} should be equal to the number of rows
#' of this matrix.
#'
#' @param x,y the x and y co-ordinates for the centres of the bubbles (symbols).
#'   Default to be 10 uniform random numbers in [0, 1] for each single image
#'   frame (so the length should be 10 * \code{ani.options('nmax')})
#' @param type,data the type and data for symbols; see \code{\link{symbols}}.
#'   The default type is \code{circles}.
#' @param bg,main,xlim,ylim,xlab,ylab,... see \code{\link{symbols}}. Note that
#'   \code{bg} has default values taking semi-transparent colors.
#' @param grid logical; add a grid to the plot?
#' @param text a character vector to be added to the plot one by one (e.g. the
#'   year in Rosling's talk)
#' @param text.col,text.cex color and magnification of the background text
#' @return \code{NULL}.
#' @author Yihui Xie
#' @seealso \code{\link{symbols}}
#' @references
#' \url{http://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen.html}
#'
#' @export
#' @example inst/examples/Rosling.bubbles-ex.R
Rosling.bubbles = function(
  x, y, data,
  type = c('circles', 'squares', 'rectangles', 'stars', 'thermometers', 'boxplots'),
  bg, xlim = range(x), ylim = range(y), main = NULL, xlab = 'x', ylab = 'y',
  ..., grid = TRUE, text = 1:ani.options('nmax'), text.col = rgb(0, 0, 0, 0.5), text.cex = 5
) {
  nmax = ani.options('nmax')
  type = match.arg(type)
  if (missing(data)) data = matrix(runif(10 * nmax))
  if (is.null(dim(data))) data = matrix(data)
  n = nrow(data)%/%nmax
  if (missing(x)) x = runif(n) + sort(rnorm(n * nmax, 0, 0.02))
  if (missing(y)) y = runif(n) + sort(rnorm(n * nmax, 0, 0.02))
  if (missing(bg)) bg = rgb(runif(n), runif(n), runif(n), 0.5)
  md = c(mean(xlim), mean(ylim))
  for (i in 1:nmax) {
    dev.hold()
    xy = xy.coords(x[((i - 1) * n + 1):(n * i)], y[((i - 1) * n + 1):(n * i)])
    xi = xy$x
    yi = xy$y
    plot(NA, NA, type = 'n', xlim = xlim, ylim = ylim,
         xlab = xlab, ylab = ylab, main = main, panel.first = {
           if (grid) grid()
           text(md[1], md[2], text[i], col = text.col, cex = text.cex)
         })
    z = list(x = xi, y = yi, add = TRUE, bg = bg, ...)
    z[[type]] = data[((i - 1) * n + 1):(n * i), ]
    do.call('symbols', z)
    ani.pause()
  }
}
