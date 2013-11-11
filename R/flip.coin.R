#' Probability in flipping coins
#'
#' This function provides a simulation to the process of flipping coins and
#' computes the frequencies for `heads' and `tails'.
#'
#' If \code{faces} is a single integer, say 2, a sequence of integers from 1 to
#' \code{faces} will be used to denote the faces of a coin; otherwise this
#' character vector just gives the names of each face.
#'
#' When the \eqn{i}-th face shows up, a colored thin rectangle will be added to
#' the corresponding place (the \eqn{i}-th bar), and there will be corresponding
#' annotations for the number of tosses and frequencies.
#'
#' The special argument \code{grid} is for consideration of a too large number
#' of flipping, in which case if you still draw horizontal lines in these
#' rectangles, the rectangles will be completely covered by these lines, thus we
#' should specify it as \code{NA}.
#'
#' At last the frequency for each face will be computed and shown in the header
#' of the plot -- this shall be close to \code{prob} if
#' \code{ani.options('nmax')} is large enough.
#'
#' @param faces an integer or a character vector. See details below.
#' @param prob the probability vector of showing each face. If \code{NULL}, each
#'   face will be shown in the same probability.
#' @param border The border style for the rectangles which stand for
#'   probabilities.
#' @param grid the color for horizontal grid lines in these rectangles
#' @param col The colors to annotate different faces of the `coin'.
#' @param type,pch,bg See \code{\link{points}}.
#' @param digits integer indicating the precision to be used in the annotation
#'   of frequencies in the plot
#' @return A list containing \item{freq}{A vector of frequencies (simulated
#'   probabilities)} \item{nmax}{the total number of tosses}
#' @note You may change the colors of each face using the argument \code{col}
#'   (repeated if shorter than the number of faces).
#' @author Yihui Xie
#' @seealso \code{\link{points}}, \code{\link{sample}}
#' @references \url{http://vis.supstat.com/2013/03/simulation-of-coin-flipping}
#' @export
#' @example inst/examples/flip.coin-ex.R
flip.coin = function(
  faces = 2, prob = NULL, border = 'white', grid = 'white', col = 1:2, type = 'p',
  pch = 21, bg = 'transparent', digits = 3
) {
  nmax = ani.options('nmax')
  if (length(faces) == 1) {
    faces = as.factor(seq(faces))
  }
  else {
    faces = as.factor(faces)
  }
  if (length(faces) < 2)
    stop("'faces' must be at least 2")
  lv = levels(faces)
  n = length(lv)
  res = sample(faces, nmax, replace = TRUE, prob = prob)
  frq = table(res)/nmax
  ylm = max(frq)
  x = runif(nmax, 1.1, 1.9)
  y = runif(nmax, 0, ylm)
  col = rep(col, length = n)
  y0 = numeric(n)
  s = seq(0, ylm, 1/nmax)
  for (i in 1:nmax) {
    dev.hold()
    plot(1, xlim = c(0, 2), ylim = c(0, ylm * 1.04), type = 'n', axes = FALSE,
         xlab = '', ylab = '', xaxs = 'i', yaxs = 'i')
    abline(v = 1)
    axis(1, (1:n - 0.5)/n, lv)
    axis(2)
    mtext('Frequency', side = 2, line = 2)
    mtext("Flip 'coins'", side = 4)
    k = as.integer(res[1:i])
    points(x[1:i], y[1:i], cex = 3, col = col[k], type = type, pch = pch, bg = bg)
    text(x[1:i], y[1:i], res[1:i], col = col[k])
    y0[k[i]] = y0[k[i]] + 1
    rect(seq(n)/n - 1/n, 0, seq(n)/n, y0/nmax, border = border, col = col)
    segments(0, s, 1, s, col = grid)
    abline(v = 1)
    axis(3, (1:n - 0.5)/n,
         paste(y0, ' (', round(y0/nmax, digits = digits), ')', sep = ''),
         tcl = 0, mgp = c(0, 0.5, 0))
    axis(1, 1.5, paste('Number of Tosses:', i), tcl = 0)
    box()
    ani.pause()
  }
  invisible(list(freq = as.matrix(frq)[, 1], nmax = i))
}
