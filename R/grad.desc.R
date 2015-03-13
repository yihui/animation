#' Gradient Descent Algorithm for the 2D case
#'
#' This function provids a visual illustration for the process of minimizing a
#' real-valued function through Gradient Descent Algorithm.
#'
#' Gradient descent is an optimization algorithm. To find a local minimum of a
#' function using gradient descent, one takes steps proportional to the negative
#' of the gradient (or the approximate gradient) of the function at the current
#' point. If instead one takes steps proportional to the gradient, one
#' approaches a local maximum of that function; the procedure is then known as
#' gradient ascent.
#'
#' The arrows are indicating the result of iterations and the process of
#' minimization; they will go to a local minimum in the end if the maximum
#' number of iterations \code{ani.options('nmax')} has not been reached.
#' @param FUN a bivariate objective function to be minimized (variable names do
#'   not have to be \code{x} and \code{y}); if the gradient argument \code{gr}
#'   is \code{NULL}, \code{\link{deriv}} will be used to calculate the gradient,
#'   in which case we should not put braces around the function body of
#'   \code{FUN} (e.g. the default function is \code{function(x, y) x^2 + 2 *
#'   y^2})
#' @param rg ranges for independent variables to plot contours; in a \code{c(x0,
#'   y0, x1, y1)} form
#' @param init starting values
#' @param gamma size of a step
#' @param tol tolerance to stop the iterations, i.e. the minimum difference
#'   between \eqn{F(x_i)}{F(x[i])} and \eqn{F(x_{i+1})}{F(x[i+1])}
#' @param gr the gradient of \code{FUN}; it should be a bivariate function to
#'   calculate the gradient (not the negative gradient!) of \code{FUN} at a
#'   point \eqn{(x,y)}, e.g. \code{function(x, y) 2 * x + 4 * y}. If it is
#'   \code{NULL}, R will use \code{\link{deriv}} to calculate the gradient
#' @param len desired length of the independent sequences (to compute z values
#'   for contours)
#' @param interact logical; whether choose the starting values by clicking on the
#'   contour plot directly?
#' @param col.contour,col.arrow colors for the contour lines and arrows
#'   respectively (default to be red and blue)
#' @param main the title of the plot; if missing, it will be derived from
#'   \code{FUN}
#' @return A list containing \item{par }{the solution for the local minimum}
#'   \item{value }{the value of the objective function corresponding to
#'   \code{par}} \item{iter}{the number of iterations; if it is equal to
#'   \code{ani.options('nmax')}, it's quite likely that the solution is not
#'   reliable because the maximum number of iterations has been reached}
#'   \item{gradient}{the gradient function of the objective function}
#'   \item{persp}{a function to make the perspective plot of the objective
#'   function; can accept further arguments from \code{\link{persp}} (see the
#'   examples below)}
#' @note Please make sure the function \code{FUN} provided is differentiable at
#'   \code{init}, what's more, it should also be 'differentiable' using
#'   \code{\link{deriv}} if you do not provide the gradient function \code{gr}.
#'
#'   If the arrows cannot reach the local minimum, the maximum number of
#'   iterations \code{nmax} in \code{\link{ani.options}} may need to be
#'   increased.
#' @author Yihui Xie
#' @seealso \code{\link{deriv}}, \code{\link{persp}}, \code{\link{contour}},
#'   \code{\link{optim}}
#' @references
#' \url{http://vis.supstat.com/2013/03/gradient-descent-algorithm-with-r/}
#' @export
#' @example inst/examples/grad.desc-ex.R
grad.desc = function(
  FUN = function(x, y) x^2 + 2 * y^2, rg = c(-3, -3, 3, 3), init = c(-3, 3),
  gamma = 0.05, tol = 0.001, gr = NULL, len = 50, interact = FALSE,
  col.contour = 'red', col.arrow = 'blue', main
) {
  nmax = ani.options('nmax')
  x = seq(rg[1], rg[3], length = len)
  y = seq(rg[2], rg[4], length = len)
  nms = names(formals(FUN))
  grad = if (is.null(gr)) {
    deriv(as.expression(body(FUN)), nms, function.arg = TRUE)
  } else {
    function(...) {
      res = FUN(...)
      attr(res, 'gradient') = matrix(gr(...), nrow = 1, ncol = 2)
      res
    }
  }
  z = outer(x, y, FUN)
  xy = if (interact) {
    contour(x, y, z, col = 'red', xlab = nms[1], ylab = nms[2],
            main = 'Choose initial values by clicking on the graph')
    unlist(locator(1))
  } else init
  newxy = xy - gamma * attr(grad(xy[1], xy[2]), 'gradient')
  gap = abs(FUN(newxy[1], newxy[2]) - FUN(xy[1], xy[2]))
  if(!is.finite(gap))  stop("Could not find any local minimum! Please check the input function and arguments.")
  if (missing(main)) main = eval(substitute(expression(z == x), list(x = body(FUN))))
  i = 1
  while (gap > tol && i <= nmax) {
    dev.hold()
    contour(x, y, z, col = col.contour, xlab = nms[1], ylab = nms[2], main = main)
    xy = rbind(xy, newxy[i, ])
    newxy = rbind(newxy, xy[i + 1, ] - gamma * attr(grad(xy[i + 1, 1], xy[i + 1, 2]), 'gradient'))
    arrows(xy[1:i, 1], xy[1:i, 2], newxy[1:i, 1], newxy[1:i, 2],
           length = par('din')[1] / 50, col = col.arrow)
    if(!is.finite(gap))  stop("Could not find any local minimum! Please check the input function and arguments.")
    gap = abs(FUN(newxy[i + 1, 1], newxy[i + 1, 2]) - FUN(xy[i + 1, 1], xy[i + 1, 2]))
    ani.pause()
    i = i + 1
    if (i > nmax) warning('Maximum number of iterations reached!')
  }
  invisible(
    list(
      par = newxy[i - 1, ], value = FUN(newxy[i - 1, 1], newxy[i - 1, 2]),
      iter = i - 1, gradient = grad,
      persp = function(...) persp(x, y, z, ...)
    )
  )
}
