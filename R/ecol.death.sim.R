#' A simulation of the death of two species with certain probabilities
#'
#' Suppose there are two plant species in a field: A and B. One of them will die
#' at each time and a new plant will grow in the place where the old plant died;
#' the species of the new plant depends on the proportions of two species: the
#' larger the proportion is, the greater the probability for this species to
#' come up will be.
#'
#' @param nr,nc number of rows and columns of the field (plants grow on a
#'   \code{nr} x \code{nc} grid)
#' @param num.sp number of two plants respectively
#' @param col.sp,pch.sp colors and point symbols of the two species respectively
#' @param col.die,pch.die,cex the color, point symbol and magnification to
#'   annotate the plant which dies (symbol default to be an `X')
#' @param \dots other arguments passed to \code{\link{plot}} to set up the plot
#' @return a vector (factor) containing 1's and 2's, denoting the plants finally
#'   survived
#' @note \code{2 * ani.options('nmax')} image frames will actually be produced.
#' @author Yihui Xie
#' @references This animation is motivated by a question raised from Jing Jiao,
#'   a student in biology, to show the evolution of two species.
#'
#'   The original post is in the forum of the ``Capital of Statistics'':
#'   \url{http://cos.name/cn/topic/14093} (in Chinese)
#' @export
#' @examples
#'
#' oopt = ani.options(nmax = ifelse(interactive(), 50, 2), interval = 0.3)
#' par(ann = FALSE, mar = rep(0, 4))
#' ecol.death.sim()
#'
#' ## large scale simulation
#' ani.options(nmax = ifelse(interactive(), 1000, 2), interval = 0.02)
#' ecol.death.sim(col.sp = c(8, 2), pch.sp = c(20, 17))
#'
#' ani.options(oopt)
#'
ecol.death.sim = function(
  nr = 10, nc = 10, num.sp = c(50, 50), col.sp = c(1, 2), pch.sp = c(1, 2),
  col.die = 1, pch.die = 4, cex = 3, ...
) {
  x = rep(1:nc, nr)
  y = rep(1:nr, each = nc)
  p = factor(sample(rep(1:2, num.sp)), levels = 1:2)
  nmax = ani.options('nmax')
  for (i in 1:nmax) {
    dev.hold()
    plot(1:nc, 1:nr, type = 'n', xlim = c(0.5, nc + 0.5), ylim = c(0.5, nr + 0.5), ...)
    abline(h = 1:nr, v = 1:nc, col = 'lightgray', lty = 3)
    points(x, y, col = col.sp[p], pch = pch.sp[p], cex = cex)
    ani.pause()
    idx = sample(nr * nc, 1)
    points(x[idx], y[idx], pch = pch.die, col = col.die, cex = cex, lwd = 3)
    tbl = as.vector(table(p))
    tbl = tbl + if (as.integer(p[idx]) > 1) c(0, -1) else c(-1, 0)
    p[idx] = sample(1:2, 1, prob = tbl)
    ani.pause()
  }
    invisible(p)
}

