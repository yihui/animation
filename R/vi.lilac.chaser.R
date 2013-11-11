#' Visual Illusions: Lilac Chaser
#'
#' Stare at the center cross for a few (say 30) seconds to experience the
#' phenomena of the illusion.
#'
#' Just try it out.
#' @param np number of points
#' @param col color of points
#' @param bg background color of the plot
#' @param p.cex magnification of points
#' @param c.cex magnification of the center cross
#' @return \code{NULL}
#' @note In fact, points in the original version of `Lilac Chaser' are
#'   \emph{blurred}, which is not implemented in this function.
#' @author Yihui Xie
#' @seealso \code{\link{points}}
#' @references \url{http://vis.supstat.com/2013/03/make-visual-illusions-in-r}
#' @export
#' @example inst/examples/vi.lilac.chaser-ex.R
vi.lilac.chaser = function(
  np = 16, col = 'magenta', bg = 'gray', p.cex = 7, c.cex = 5
) {
  nmax = ani.options('nmax')
  op = par(bg = bg, xpd = NA)
  x = seq(0, 2 * pi * np/(np + 1), length = np)
  for (j in 1:nmax) {
    for (i in 1:np) {
      dev.hold()
      plot(sin(x[-i]), cos(x[-i]), col = col, cex = p.cex,
           pch = 19, xlim = c(-1, 1), ylim = c(-1, 1), ann = FALSE, axes = FALSE)
      points(0, 0, pch = '+', cex = c.cex, lwd = 2)
      ani.pause()
    }
  }
  par(op)
  invisible(NULL)
}
