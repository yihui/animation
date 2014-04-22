\name{grad.desc}
\alias{grad.desc}
\title{Gradient Descent Algorithm for the 2D case}
\usage{
grad.desc(FUN = function(x, y) x^2 + 2 * y^2, rg = c(-3, -3, 3, 3),
  init = c(-3, 3), gamma = 0.05, tol = 0.001, gr = NULL, len = 50,
  interact = FALSE, col.contour = "red", col.arrow = "blue", main)
}
\arguments{
  \item{FUN}{a bivariate objective function to be minimized
  (variable names do not have to be \code{x} and \code{y});
  if the gradient argument \code{gr} is \code{NULL},
  \code{\link{deriv}} will be used to calculate the
  gradient, in which case we should not put braces around
  the function body of \code{FUN} (e.g. the default
  function is \code{function(x, y) x^2 + 2 * y^2})}

  \item{rg}{ranges for independent variables to plot
  contours; in a \code{c(x0, y0, x1, y1)} form}

  \item{init}{starting values}

  \item{gamma}{size of a step}

  \item{tol}{tolerance to stop the iterations, i.e. the
  minimum difference between \eqn{F(x_i)}{F(x[i])} and
  \eqn{F(x_{i+1})}{F(x[i+1])}}

  \item{gr}{the gradient of \code{FUN}; it should be a
  bivariate function to calculate the gradient (not the
  negative gradient!) of \code{FUN} at a point \eqn{(x,y)},
  e.g. \code{function(x, y) 2 * x + 4 * y}. If it is
  \code{NULL}, R will use \code{\link{deriv}} to calculate
  the gradient}

  \item{len}{desired length of the independent sequences
  (to compute z values for contours)}

  \item{interact}{logical; whether choose the starting
  values by cliking on the contour plot directly?}

  \item{col.contour,col.arrow}{colors for the contour lines
  and arrows respectively (default to be red and blue)}

  \item{main}{the title of the plot; if missing, it will be
  derived from \code{FUN}}
}
\value{
A list containing \item{par }{the solution for the local
minimum} \item{value }{the value of the objective function
corresponding to \code{par}} \item{iter}{the number of
iterations; if it is equal to \code{ani.options('nmax')},
it's quite likely that the solution is not reliable because
the maximum number of iterations has been reached}
\item{gradient}{the gradient function of the objective
function} \item{persp}{a function to make the perspective
plot of the objective function; can accept further
arguments from \code{\link{persp}} (see the examples
below)}
}
\description{
This function provids a visual illustration for the process
of minimizing a real-valued function through Gradient
Descent Algorithm.
}
\details{
Gradient descent is an optimization algorithm. To find a
local minimum of a function using gradient descent, one
takes steps proportional to the negative of the gradient
(or the approximate gradient) of the function at the
current point. If instead one takes steps proportional to
the gradient, one approaches a local maximum of that
function; the procedure is then known as gradient ascent.

The arrows are indicating the result of iterations and the
process of minimization; they will go to a local minimum in
the end if the maximum number of iterations
\code{ani.options('nmax')} has not been reached.
}
\note{
Please make sure the function \code{FUN} provided is
differentiable at \code{init}, what's more, it should also
be 'differentiable' using \code{\link{deriv}} if you do not
provide the gradient function \code{gr}.

If the arrows cannot reach the local minimum, the maximum
number of iterations \code{nmax} in
\code{\link{ani.options}} may need to be increased.
}
\examples{
## default example
oopt = ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))
xx = grad.desc()
xx$par  # solution
xx$persp(col = 'lightblue', phi = 30)   # perspective plot

## define more complex functions; a little time-consuming
f1 = function(x, y) x^2 + 3 * sin(y)
xx = grad.desc(f1, pi * c(-2, -2, 2, 2), c(-2 * pi, 2))
xx$persp(col = 'lightblue', theta = 30, phi = 30)

## need to provide the gradient when deriv() cannot handle the function
grad.desc(FUN = function(x1, x2) {
  x0 = cos(x2)
  x1^2 + x0
}, gr = function(x1, x2) {
  c(2 * x1, -sin(x2))
}, rg = c(-3, -1, 3, 5), init = c(-3, 0.5),
          main = expression(x[1]^2+cos(x[2])))

## or a even more complicated function
ani.options(interval = 0, nmax = ifelse(interactive(), 200, 2))
f2 = function(x, y) sin(1/2 * x^2 - 1/4 * y^2 + 3) *
  cos(2 * x + 1 - exp(y))
xx = grad.desc(f2, c(-2, -2, 2, 2), c(-1, 0.5),
               gamma = 0.1, tol = 1e-04)

## click your mouse to select a start point
if (interactive()) {
  xx = grad.desc(f2, c(-2, -2, 2, 2), interact = TRUE,
                 tol = 1e-04)
  xx$persp(col = 'lightblue', theta = 30, phi = 30)
}

## HTML animation pages
saveHTML({
  ani.options(interval = 0.3)
  grad.desc()
}, img.name='grad.desc',htmlfile='grad.desc.html',
         ani.height = 500, ani.width = 500,
         title = 'Demonstration of the Gradient Descent Algorithm',
         description = 'The arrows will take you to the optimum step by step.')

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
\url{http://vis.supstat.com/2013/03/gradient-descent-algorithm-with-r/}
}
\seealso{
\code{\link{deriv}}, \code{\link{persp}},
\code{\link{contour}}, \code{\link{optim}}
}

