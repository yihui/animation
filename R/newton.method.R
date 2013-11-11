#' Demonstration of the Newton-Raphson method for root-finding
#'
#' This function provides an illustration of the iterations in Newton's method.
#'
#' Newton's method (also known as the Newton-Raphson method or the
#' Newton-Fourier method) is an efficient algorithm for finding approximations
#' to the zeros (or roots) of a real-valued function f(x).
#'
#' The iteration goes on in this way:
#'
#' \deqn{x_{k + 1} = x_{k} - \frac{FUN(x_{k})}{FUN'(x_{k})}}{x[k + 1] = x[k] -
#' FUN(x[k]) / FUN'(x[k])}
#'
#' From the starting value \eqn{x_0}, vertical lines and points are plotted to
#' show the location of the sequence of iteration values \eqn{x_1, x_2,
#' \ldots}{x1, x2, \dots}; tangent lines are drawn to illustrate the
#' relationship between successive iterations; the iteration values are in the
#' right margin of the plot.
#'
#' @param FUN the function in the equation to solve (univariate), which has to
#'   be defined without braces like the default one (otherwise the derivative
#'   cannot be computed)
#' @param init the starting point
#' @param rg the range for plotting the curve
#' @param tol the desired accuracy (convergence tolerance)
#' @param interact logical; whether choose the starting point by cliking on the
#'   curve (for 1 time) directly?
#' @param col.lp a vector of length 3 specifying the colors of: vertical lines,
#'   tangent lines and points
#' @param main,xlab,ylab titles of the plot; there are default values for them
#'   (depending on the form of the function \code{FUN})
#' @param \dots other arguments passed to \code{\link{curve}}
#' @return A list containing \item{root }{the root found by the algorithm}
#'   \item{value }{the value of \code{FUN(root)}} \item{iter}{number of
#'   iterations; if it is equal to \code{ani.options('nmax')}, it's quite likely
#'   that the root is not reliable because the maximum number of iterations has
#'   been reached}
#' @note The algorithm might not converge -- it depends on the starting value.
#'   See the examples below.
#' @author Yihui Xie
#' @seealso \code{\link{optim}}
#' @references \url{http://en.wikipedia.org/wiki/Newton's_method}
#'
#' @export
#' @example inst/examples/newton.method-ex.R
newton.method = function(
  FUN = function(x) x^2 - 4, init = 10, rg = c(-1, 10), tol = 0.001, interact = FALSE,
  col.lp = c('blue', 'red', 'red'), main, xlab, ylab, ...
) {
  if (interact) {
    curve(
      FUN, min(rg), max(rg), xlab = 'x',
      ylab = eval(substitute(expression(f(x) == y), list(y = body(FUN)))),
      main = 'Locate the starting point'
    )
    init = unlist(locator(1))[1]
  }
  i = 1
  nms = names(formals(FUN))
  grad = deriv(as.expression(body(FUN)), nms, function.arg = TRUE)
  x = c(init, init - FUN(init)/attr(grad(init), 'gradient'))
  gap = FUN(x[2])
  if (missing(xlab))
    xlab = nms
  if (missing(ylab))
    ylab = eval(substitute(expression(f(x) == y), list(y = body(FUN))))
  if (missing(main))
    main = eval(
      substitute(expression('Root-finding by Newton-Raphson Method:' ~ y == 0),
                 list(y = body(FUN)))
    )
  nmax = ani.options('nmax')
  while (abs(gap) > tol & i <= nmax & !is.na(x[i + 1])) {
    dev.hold()
    curve(FUN, min(rg), max(rg), main = main, xlab = xlab, ylab = ylab, ...)
    abline(h = 0, col = 'gray')
    segments(x[1:i], rep(0, i), x[1:i], FUN(x[1:i]), col = col.lp[1])
    segments(x[1:i], FUN(x[1:i]), x[2:(i + 1)], rep(0, i), col = col.lp[2])
    points(x, rep(0, i + 1), col = col.lp[3])
    points(x[1:i], FUN(x[1:i]), col = col.lp[3])
    mtext(paste('Current root:', x[i + 1]), 4)
    gap = FUN(x[i + 1])
    x = c(x, x[i + 1] - FUN(x[i + 1])/attr(grad(x[i + 1]), 'gradient'))
    ani.pause()
    i = i + 1
  }
  rtx = par('usr')[4]
  arrows(x[i], rtx, x[i], 0, col = 'gray')
  invisible(list(root = x[i], value = gap, iter = i - 1))
}
