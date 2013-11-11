#' Hit or Miss Monte Carlo integration
#'
#' Integrate a function using the Hit-or-Miss Monte Carlo algorithm.
#'
#' We compute the proportion of points hitting the area under the curve, and the
#' integral can be estimated by the proportion multiplied by the total area of
#' the rectangle (from xmin to xmax, ymin to ymax).
#'
#' @param FUN the function to be integrated
#' @param n number of points to be sampled from the Uniform(0, 1) distribution
#' @param from,to the limits of integration
#' @param col.points,pch.points colors and point characters for points which
#'   ``hit'' or ``miss'' the area under the curve
#' @param \dots other arguments passed to \code{\link{points}}
#' @return A list containing \item{x1}{ the Uniform random numbers generated on
#'   x-axis} \item{x2}{ the Uniform random numbers generated on y-axis}
#'   \item{y}{ function values evaluated at \code{x1} } \item{n}{ number of
#'   points drawn from the Uniform distribtion } \item{est}{ the estimated value
#'   of the integral }
#' @note This function is for demonstration purpose only; the integral might be
#'   very inaccurate when \code{n} is small.
#'
#'   \code{ani.options('nmax')} specifies the maximum number of trials.
#' @author Yihui Xie
#' @seealso \code{\link{integrate}}, \code{\link{MC.samplemean}}
#' @export
#' @example inst/examples/MC.hitormiss-ex.R
MC.hitormiss = function(
  FUN = function(x) x - x^2, n = ani.options('nmax'), from = 0, to = 1,
  col.points = c('black', 'red'), pch.points = c(20, 4), ...
) {
  nmax = n
  x1 = runif(n, from, to)
  ymin = optimize(FUN, c(from, to), maximum = FALSE)$objective
  ymax = optimize(FUN, c(from, to), maximum = TRUE)$objective
  x2 = runif(n, ymin, ymax)
  y = FUN(x1)
  if (any(y < 0))
    stop('This Hit-or-Miss Monte Carlo algorithm only applies to\n',
         '_non-negative_ functions!')
  for (i in 1:nmax) {
    dev.hold()
    curve(FUN, from = from, to = to,
          ylab = eval(substitute(expression(y == x), list(x = body(FUN)))))
    points(
      x1[1:i], x2[1:i], col = col.points[(x2[1:i] > y[1:i]) + 1],
      pch = pch.points[(x2[1:i] > y[1:i]) + 1], ...
    )
    curve(FUN, from = from, to = to, add = TRUE)
    ani.pause()
  }
  invisible(list(x1 = x1, x2 = x2, y = y, n = nmax,
                 est = mean(x2 < y) * ((to - from) * (ymax - ymin))))
}

