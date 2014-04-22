\name{buffon.needle}
\alias{buffon.needle}
\title{Simulation of Buffon's Needle}
\usage{
buffon.needle(l = 0.8, d = 1, redraw = TRUE, mat = matrix(c(1, 3, 2, 3),
  2), heights = c(3, 2), col = c("lightgray", "red", "gray", "red", "blue",
  "black", "red"), expand = 0.4, type = "l", ...)
}
\arguments{
  \item{l}{numerical. length of the needle; shorter than
  \code{d}.}

  \item{d}{numerical. distances between lines; it should be
  longer than \code{l}.}

  \item{redraw}{logical. redraw former `needles' or not for
  each drop.}

  \item{mat,heights}{arguments passed to
  \code{\link{layout}} to set the layout of the three
  graphs.}

  \item{col}{a character vector of length 7 specifying the
  colors of: background of the area between parallel lines,
  the needles, the sin curve, points below / above the sin
  curve, estimated \eqn{\pi} values, and the true \eqn{\pi}
  value.}

  \item{expand}{a numerical value defining the expanding
  range of the y-axis when plotting the estimated \eqn{\pi}
  values: the \code{ylim} will be \code{(1 +/- expand) *
  pi}.}

  \item{type}{an argument passed to
  \code{\link[graphics:plot.default]{plot}} when plotting
  the estimated \eqn{\pi} values (default to be lines).}

  \item{\dots}{other arguments passed to
  \code{\link[graphics:plot.default]{plot}} when plotting
  the values of estimated \eqn{\pi}.}
}
\value{
The values of estimated \eqn{\pi} are returned as a
numerical vector (of length \code{nmax}).
}
\description{
This function provides a simulation for the problem of
Buffon's Needle, which is one of the oldest problems in the
field of geometrical probability.
}
\details{
This is quite an old problem in probability. For
mathematical background, please refer to
\url{http://en.wikipedia.org/wiki/Buffon's_needle} or
\url{http://www.mste.uiuc.edu/reese/buffon/buffon.html}.

`Needles' are denoted by segments on the 2D plane, and
dropped randomly to check whether they cross the parallel
lines. Through many times of `dropping' needles, the
approximate value of \eqn{\pi} can be calculated out.

There are three graphs made in each step: the top-left one
is a simulation of the scenario, the top-right one is to
help us understand the connection between dropping needles
and the mathematical method to estimate \eqn{\pi}, and the
bottom one is the result for each drop.
}
\note{
Note that \code{redraw} has great influence on the speed of
the simulation (animation) if the control argument
\code{nmax} (in \code{\link{ani.options}}) is quite large,
so you'd better specify it as \code{FALSE} when doing a
large amount of simulations.

The maximum number of drops is specified in
\code{ani.options('nmax')}.
}
\examples{
## it takes several seconds if 'redraw = TRUE'
oopt = ani.options(nmax = ifelse(interactive(), 500, 2), interval = 0.05)
par(mar = c(3, 2.5, 0.5, 0.2), pch = 20, mgp = c(1.5, 0.5, 0))
buffon.needle()

## this will be faster
buffon.needle(redraw = FALSE)

## create an HTML animation page
saveHTML({
  par(mar = c(3, 2.5, 1, 0.2), pch = 20, mgp = c(1.5, 0.5, 0))
  ani.options(nmax = ifelse(interactive(), 300, 10), interval = 0.1)
  buffon.needle(type = 'S')
}, img.name='buffon.needle', htmlfile='buffon.needle.html',
         ani.height = 500, ani.width = 600, title = "Simulation of Buffon's Needle",
         description = c(
           'There are three graphs made in each step: the',
           'top-left, one is a simulation of the scenario, the top-right one',
           'is to help us understand the connection between dropping needles',
           'and the mathematical method to estimate pi, and the bottom one is',
           'the result for each dropping.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
Ramaley, J. F. (Oct 1969). Buffon's Noodle Problem.
\emph{The American Mathematical Monthly} \bold{76} (8):
916-918.

\url{http://vis.supstat.com/2013/04/buffons-needle}
}

