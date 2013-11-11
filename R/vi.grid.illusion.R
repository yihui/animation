#' Visual illusions: Scintillating grid illusion and Hermann grid illusion
#'
#' The two most common types of grid illusions are Hermann grid illusions and
#' Scintillating grid illusions. This function provides illustrations for both
#' illusions.
#'
#' A grid illusion is any kind of grid that deceives a person's vision.
#'
#' This is actually a static image; pay attention to the intersections of the
#' grid and there seems to be some moving points (non-existent in fact).
#' @param nrow number of rows for the grid
#' @param ncol number of columns for the grid
#' @param lwd line width for grid lines
#' @param cex magnification for points in Scintillating grid illusions
#' @param col color for grid lines
#' @param type type of illusions: \code{'s'} for Scintillating grid illusions
#'   and \code{'h'} for Hermann grid illusions
#' @return \code{NULL}
#' @author Yihui Xie
#' @seealso \code{\link{points}}, \code{\link{abline}}
#' @references \url{http://vis.supstat.com/2013/03/make-visual-illusions-in-r}
#' @export
#' @examples
#' ## default to be Scintillating grid illusions
#' vi.grid.illusion()
#'
#' ## set wider lines to see Hermann grid illusions
#' vi.grid.illusion(type = 'h', lwd = 22, nrow = 5, ncol = 5,
#'     col = 'white')
vi.grid.illusion = function(
  nrow = 8, ncol = 8, lwd = 8, cex = 3, col = 'darkgray', type = c('s', 'h')
) {
  op = par(mar = rep(0, 4), bg = 'black')
  plot.new()
  x = seq(0, 1, length = ncol)
  y = seq(0, 1, length = nrow)
  abline(v = x, h = y, col = col, lwd = lwd)
  if (type[1] == 's')
    points(rep(x, each = nrow), rep(y, ncol), col = 'white', cex = cex, pch = 20)
  par(op)
}
