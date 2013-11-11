#' Demonstration of the Bisection Method for root-finding on an interval
#'
#' This is a visual demonstration of finding the root of an equation \eqn{f(x) =
#' 0} on an interval using the Bisection Method.
#'
#' Suppose we want to solve the equation \eqn{f(x) = 0}. Given two points a and
#' b such that \eqn{f(a)} and \eqn{f(b)} have opposite signs, we know by the
#' intermediate value theorem that \eqn{f} must have at least one root in the
#' interval \eqn{[a, b]} as long as \eqn{f} is continuous on this interval. The
#' bisection method divides the interval in two by computing \eqn{c = (a + b) /
#' 2}. There are now two possibilities: either \eqn{f(a)} and \eqn{f(c)} have
#' opposite signs, or \eqn{f(c)} and \eqn{f(b)} have opposite signs. The
#' bisection algorithm is then applied recursively to the sub-interval where the
#' sign change occurs.
#'
#' During the process of searching, the mid-point of subintervals are annotated
#' in the graph by both texts and blue straight lines, and the end-points are
#' denoted in dashed red lines. The root of each iteration is also plotted in
#' the right margin of the graph.
#'
#' @param FUN the function in the equation to solve (univariate)
#' @param rg a vector containing the end-points of the interval to be searched
#'   for the root; in a \code{c(a, b)} form
#' @param tol the desired accuracy (convergence tolerance)
#' @param interact logical; whether choose the end-points by cliking on the
#'   curve (for two times) directly?
#' @param xlab,ylab,main axis and main titles to be used in the plot
#' @param \dots other arguments passed to \code{\link{curve}}
#' @return A list containing \item{root }{the root found by the algorithm}
#'   \item{value }{the value of \code{FUN(root)}} \item{iter}{number of
#'   iterations; if it is equal to \code{ani.options('nmax')}, it's quite likely
#'   that the root is not reliable because the maximum number of iterations has
#'   been reached}
#' @author Yihui Xie
#' @note The maximum number of iterations is specified in
#'   \code{ani.options('nmax')}.
#' @seealso \code{\link{deriv}}, \code{\link{uniroot}}, \code{\link{curve}}
#' @references \url{http://en.wikipedia.org/wiki/Bisection_method}
#'
#' @export
#' @example inst/examples/bisection.method-ex.R
bisection.method = function(
  FUN = function(x) x^2 - 4, rg = c(-1, 10), tol = 0.001, interact = FALSE, main,
  xlab, ylab, ...) {
  if (interact) {
    if (!interactive()) {
      warning('Not in an interactive session!')
      return(invisible(NULL))
    }
    curve(FUN, min(rg), max(rg), xlab = 'x',
          ylab = eval(substitute(expression(f(x) == y), list(y = body(FUN)))),
          main = 'Locate the interval for finding root')
    rg = unlist(locator(2))[1:2]
  }
  l = min(rg)
  u = max(rg)
  if (FUN(l) * FUN(u) > 0)
    stop('The function must have opposite signs at the lower and upper bound of the range!')
  mid = FUN((l + u)/2)
  i = 1
  bd = rg
  if (missing(xlab))
    xlab = names(formals(FUN))
  if (missing(ylab))
    ylab = eval(substitute(expression(f(x) == y), list(y = body(FUN))))
  if (missing(main))
    main = eval(
      substitute(expression('Root-finding by Bisection Method:' ~ y == 0), list(y = body(FUN))))
  while (abs(mid) > tol && i <= ani.options('nmax')) {
    dev.hold()
    curve(FUN, min(rg), max(rg), xlab = xlab, ylab = ylab, main = main, ...)
    abline(h = 0, col = 'gray')
    abline(v = bd, col = 'red', lty = 2)
    abline(v = (l + u)/2, col = 'blue')
    arrh = mean(par('usr')[3:4])
    if (u - l > 0.001 * diff(par('usr')[1:2])/par('din')[1])
      arrows(l, arrh, u, arrh, code = 3, col = 'gray', length = par('din')[1]/2^(i + 2))
    mtext(paste('Current root:', (l + u)/2), 4)
    bd = c(bd, (l + u)/2)
    assign(ifelse(mid * FUN(l) > 0, 'l', 'u'), (l + u)/2)
    mid = FUN((l + u)/2)
    ani.pause()
    i = i + 1
  }
  invisible(list(root = (l + u)/2, value = mid, iter = i - 1))
}
