\name{grad.desc}
\alias{grad.desc}
\title{ Gradient Descent Algorithm for the 2D Case }
\description{
  This function has provided a visual illustration for the process of minimizing a real-valued function through Gradient Descent Algorithm. 
}
\usage{
grad.desc(FUN = function(x, y) x^2 + 2 * y^2, rg = c(-3, -3, 3, 3), 
    init = c(-3, 3), gamma = 0.05, tol = 0.001, len = 50, 
    interact = FALSE)
}
\arguments{
  \item{FUN}{ the objective function to be minimized; contains only two independent variables (variable names do not need to be 'x' and 'y') }
  \item{rg}{ ranges for independent variables to plot contours; in a \code{c(x0, y0, x1, y1)} form }
  \item{init}{ starting values }
  \item{gamma}{ size of a step }
  \item{tol}{ tolerance to stop the iterations, i.e. the minimum difference between \eqn{F(x_i)}{F(x[i])} and \eqn{F(x_{i+1})}{F(x[i+1])} }
  \item{len}{ desired length of the independent sequences (to compute z values for contours) }
  \item{interact}{ logical; whether choose the starting values by cliking on the contour plot directly? }
}
\details{
  Gradient descent is an optimization algorithm. To find a local minimum of a function using gradient descent, one takes steps proportional to the negative of the gradient (or the approximate gradient) of the function at the current point. If instead one takes steps proportional to the gradient, one approaches a local maximum of that function; the procedure is then known as gradient ascent.
  
  The arrows are indicating the result of iterations and the process of minimization; they will go to a local minimum in the end if the maximum number of iterations (\code{nmax} in \code{control}) has not been reached. 

}
\value{
  A list containing 
  \item{par }{the solution for the local minimum}
  \item{value }{the value of the objective function corresponding to \code{par}}
  \item{iter}{the number of iterations; if it is equal to \code{control$nmax}, it's quite likely that the solution is not reliable because the maximum number of iterations has been reached} 
  \item{gradient}{the gradient function of the objective function; it is returned by \code{\link[stats]{deriv}}}
  \item{persp}{a function to make the perspective plot of the objective function; can accept further arguments from \code{\link[graphics]{persp}} (see the examples below)}
}
\references{ 
\url{http://en.wikipedia.org/wiki/Gradient_descent}

\url{http://animation.yihui.name/compstat:gradient_descent_algorithm}
}
\author{ Yihui Xie }
\note{ 
Please make sure the function \code{FUN} provided is differentiable at \code{init}, what's more, it should also be 'differentiable' using \code{\link[stats]{deriv}} (see the help file)! 

If the arrows cannot reach the local minimum, the maximum number of iterations \code{nmax} in \code{\link{ani.options}} may be increased.
}
\seealso{ \code{\link[stats]{deriv}}, \code{\link[graphics]{persp}}, \code{\link[graphics]{contour}}, \code{\link[stats]{optim}} }
\examples{
# default example 
oopt = ani.options(interval = 0.3, nmax = 50)
xx = grad.desc()
xx$par  # solution
xx$persp(col = "lightblue", phi = 30)   # perspective plot 

\dontrun{
 
# define more complex functions; a little time-consuming 
f1 = function(x, y) x^2 + 3 * sin(y) 
xx = grad.desc(f1, pi * c(-2, -2, 2, 2), c(-2 * pi, 2)) 
xx$persp(col = "lightblue", theta = 30, phi = 30)
# or 
ani.options(interval = 0, nmax = 200)
f2 = function(x, y) sin(1/2 * x^2 - 1/4 * y^2 + 3) * 
    cos(2 * x + 1 - exp(y))  
xx = grad.desc(f2, c(-2, -2, 2, 2), c(-1, 0.5), 
    gamma = 0.1, tol = 1e-04)
# click your mouse to select a start point 
xx = grad.desc(f2, c(-2, -2, 2, 2), interact = TRUE, 
    tol = 1e-04)
xx$persp(col = "lightblue", theta = 30, phi = 30)

# HTML animation pages 
ani.options(ani.height = 500, ani.width = 500, outdir = getwd(), interval = 0.3,
    nmax = 50, title = "Demonstration of the Gradient Descent Algorithm",
    description = "The arrows will take you to the optimum step by step.")
ani.start()
grad.desc()
ani.stop()

}
ani.options(oopt)
}
\keyword{ optimize }
\keyword{ dynamic }
\keyword{ dplot }
