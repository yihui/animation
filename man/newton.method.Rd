\name{newton.method}
\alias{newton.method}
\title{Demonstration of the Newton-Raphson method for root-finding}
\usage{
newton.method(FUN = function(x) x^2 - 4, init = 10, rg = c(-1, 10),
  tol = 0.001, interact = FALSE, col.lp = c("blue", "red", "red"), main,
  xlab, ylab, ...)
}
\arguments{
  \item{FUN}{the function in the equation to solve
  (univariate), which has to be defined without braces like
  the default one (otherwise the derivative cannot be
  computed)}

  \item{init}{the starting point}

  \item{rg}{the range for plotting the curve}

  \item{tol}{the desired accuracy (convergence tolerance)}

  \item{interact}{logical; whether choose the starting
  point by cliking on the curve (for 1 time) directly?}

  \item{col.lp}{a vector of length 3 specifying the colors
  of: vertical lines, tangent lines and points}

  \item{main,xlab,ylab}{titles of the plot; there are
  default values for them (depending on the form of the
  function \code{FUN})}

  \item{\dots}{other arguments passed to
  \code{\link{curve}}}
}
\value{
A list containing \item{root }{the root found by the
algorithm} \item{value }{the value of \code{FUN(root)}}
\item{iter}{number of iterations; if it is equal to
\code{ani.options('nmax')}, it's quite likely that the root
is not reliable because the maximum number of iterations
has been reached}
}
\description{
This function provides an illustration of the iterations in
Newton's method.
}
\details{
Newton's method (also known as the Newton-Raphson method or
the Newton-Fourier method) is an efficient algorithm for
finding approximations to the zeros (or roots) of a
real-valued function f(x).

The iteration goes on in this way:

\deqn{x_{k + 1} = x_{k} -
\frac{FUN(x_{k})}{FUN'(x_{k})}}{x[k + 1] = x[k] - FUN(x[k])
/ FUN'(x[k])}

From the starting value \eqn{x_0}, vertical lines and
points are plotted to show the location of the sequence of
iteration values \eqn{x_1, x_2, \ldots}{x1, x2, \dots};
tangent lines are drawn to illustrate the relationship
between successive iterations; the iteration values are in
the right margin of the plot.
}
\note{
The algorithm might not converge -- it depends on the
starting value.  See the examples below.
}
\examples{
oopt = ani.options(interval = 1, nmax = ifelse(interactive(), 50, 2))
par(pch = 20)

## default example
xx = newton.method()
xx$root  # solution

## take a long long journey
newton.method(function(x) 5 * x^3 - 7 * x^2 - 40 * x + 100, 7.15, c(-6.2, 7.1))

## another function
ani.options(interval = 0.5)
xx = newton.method(function(x) exp(-x) * x, rg = c(0, 10), init = 2)

## does not converge!
xx = newton.method(function(x) atan(x), rg = c(-5, 5), init = 1.5)
xx$root   # Inf

## interaction: use your mouse to select the starting point
if (interactive()) {
  ani.options(interval = 0.5, nmax = 50)
  xx = newton.method(function(x) atan(x), rg = c(-2,
                                                 2), interact = TRUE)
}

## HTML animation pages
saveHTML({
  ani.options(nmax = ifelse(interactive(), 100, 2))
  par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0), pch = 19)
  newton.method(function(x) 5 * x^3 - 7 * x^2 - 40 *
                  x + 100, 7.15, c(-6.2, 7.1), main = '')
}, img.name='newton.method', htmlfile='newton.method.html',
         ani.height = 500, ani.width = 600,
         title = 'Demonstration of the Newton-Raphson Method',
         description = 'Go along with the tangent lines and iterate.')

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
\url{http://en.wikipedia.org/wiki/Newton's_method}
}
\seealso{
\code{\link{optim}}
}

