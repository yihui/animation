% Please edit documentation in R/BM.circle.R
\name{BM.circle}
\alias{BM.circle}
\title{Brownian Motion in a circle}
\usage{
BM.circle(n = 20, col = rainbow(n), ...)
}
\arguments{
\item{n}{number of points}

\item{col}{colors of points}

\item{\dots}{other parameters passed to \code{\link{points}}}
}
\value{
Invisible \code{NULL}.
}
\description{
Several points moving randomly in a circle.
}
\details{
This is a solution to the question raised in R-help:
\url{https://stat.ethz.ch/pipermail/r-help/2008-December/183018.html}.
}
\note{
The maximum number of steps in the motion is specified in
  \code{ani.options('nmax')}.
}
\author{
Yihui Xie
}
\references{
Examples at \url{https://yihui.name/animation/examples/bm-circle/}
}
\seealso{
\code{\link{brownian.motion}}, \code{\link{rnorm}}
}
