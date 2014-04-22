\name{bisection.method}
\alias{bisection.method}
\title{Demonstration of the Bisection Method for root-finding on an interval}
\usage{
bisection.method(FUN = function(x) x^2 - 4, rg = c(-1, 10), tol = 0.001,
  interact = FALSE, main, xlab, ylab, ...)
}
\arguments{
  \item{FUN}{the function in the equation to solve
  (univariate)}

  \item{rg}{a vector containing the end-points of the
  interval to be searched for the root; in a \code{c(a, b)}
  form}

  \item{tol}{the desired accuracy (convergence tolerance)}

  \item{interact}{logical; whether choose the end-points by
  cliking on the curve (for two times) directly?}

  \item{xlab,ylab,main}{axis and main titles to be used in
  the plot}

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
This is a visual demonstration of finding the root of an
equation \eqn{f(x) = 0} on an interval using the Bisection
Method.
}
\details{
Suppose we want to solve the equation \eqn{f(x) = 0}. Given
two points a and b such that \eqn{f(a)} and \eqn{f(b)} have
opposite signs, we know by the intermediate value theorem
that \eqn{f} must have at least one root in the interval
\eqn{[a, b]} as long as \eqn{f} is continuous on this
interval. The bisection method divides the interval in two
by computing \eqn{c = (a + b) / 2}. There are now two
possibilities: either \eqn{f(a)} and \eqn{f(c)} have
opposite signs, or \eqn{f(c)} and \eqn{f(b)} have opposite
signs. The bisection algorithm is then applied recursively
to the sub-interval where the sign change occurs.

During the process of searching, the mid-point of
subintervals are annotated in the graph by both texts and
blue straight lines, and the end-points are denoted in
dashed red lines. The root of each iteration is also
plotted in the right margin of the graph.
}
\note{
The maximum number of iterations is specified in
\code{ani.options('nmax')}.
}
\examples{
oopt = ani.options(nmax = ifelse(interactive(), 30, 2))

## default example
xx = bisection.method()
xx$root  # solution

## a cubic curve
f = function(x) x^3 - 7 * x - 10
xx = bisection.method(f, c(-3, 5))

## interaction: use your mouse to select the two end-points
if (interactive())
  bisection.method(f, c(-3, 5), interact = TRUE)

## HTML animation pages
saveHTML({
  par(mar = c(4, 4, 1, 2))
  bisection.method(main = "")
}, img.name='bisection.method', htmlfile = 'bisection.method.html',
         ani.height = 400, ani.width = 600, interval = 1,
         title = "The Bisection Method for Root-finding on an Interval",
         description = c("The bisection method is a root-finding algorithm",
                         "which works by repeatedly dividing an interval in half and then",
                         "selecting the subinterval in which a root exists."))

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
\url{http://en.wikipedia.org/wiki/Bisection_method}
}
\seealso{
\code{\link{deriv}}, \code{\link{uniroot}},
\code{\link{curve}}
}

