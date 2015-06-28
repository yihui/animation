#' Sample Mean Monte Carlo integration
#'
#' Integrate a function from 0 to 1 using the Sample Mean Monte Carlo algorithm
#'
#' \emph{Sample Mean Monte Carlo} integration can compute
#'
#' \deqn{I=\int_0^1 f(x) dx}
#'
#' by drawing random numbers \eqn{x_i} from Uniform(0, 1) distribution and
#' average the values of \eqn{f(x_i)}. As \eqn{n} goes to infinity, the sample
#' mean will approach to the expectation of \eqn{f(X)} by Law of Large Numbers.
#'
#' The height of the \eqn{i}-th rectangle in the animation is \eqn{f(x_i)} and
#' the width is \eqn{1/n}, so the total area of all the rectangles is \eqn{\sum
#' f(x_i) 1/n}, which is just the sample mean. We can compare the area of
#' rectangles to the curve to see how close is the area to the real integral.
#' @param FUN the function to be integrated
#' @param n number of points to be sampled from the Uniform(0, 1) distribution
#' @param col.rect colors of rectangles (for the past rectangles and the current
#'   one)
#' @param adj.x should the locations of rectangles on the x-axis be adjusted?
#'   If \code{TRUE}, the rectangles will be laid side by side and it is
#'   informative for us to assess the total area of the rectangles, otherwise
#'   the rectangles will be laid at their exact locations.
#' @param \dots other arguments passed to \code{\link{rect}}
#' @return A list containing \item{x}{ the Uniform random numbers } \item{y}{
#'   function values evaluated at \code{x} } \item{n}{ number of points drawn
#'   from the Uniform distribtion } \item{est}{ the estimated value of the
#'   integral }
#' @note This function is for demonstration purpose only; the integral might be
#'   very inaccurate when \code{n} is small.
#'
#'   \code{ani.options('nmax')} specifies the maximum number of trials.
#' @author Yihui Xie
#' @seealso \code{\link{integrate}}, \code{\link{MC.hitormiss}}
#' @export
#' @example inst/examples/MC.samplemean-ex.R
MC.samplemean = function(
  FUN = function(x) x - x^2, n = ani.options('nmax'), col.rect = c('gray', 'black'),
  adj.x = TRUE, ...
) {
  nmax = n
  x = runif(n)
  y = FUN(x)
  xx = if (adj.x)
    seq(0, 1, length.out = nmax)[rank(x, ties.method = 'random')] else x
  for (i in 1:nmax) {
    dev.hold()
    curve(FUN, from = 0, to = 1,
          ylab = eval(substitute(expression(y == x), list(x = body(FUN)))))
    rect(xx[1:i] - 0.5/nmax, 0, xx[1:i] + 0.5/nmax, y[1:i],
         col = c(rep(col.rect[1], i - 1), col.rect[2]), ...)
    abline(h = 0, col = 'gray')
    curve(FUN, from = 0, to = 1, add = TRUE)
    rug(x)
    rug(x[i], lwd = 2, side = 3, col = col.rect[2])
    ani.pause()
  }
  invisible(list(x = x, y = y, n = nmax, est = mean(y)))
}

