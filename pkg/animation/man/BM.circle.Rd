\name{BM.circle}
\alias{BM.circle}
\title{ Brownian Motion in a Circle }
\description{
  Several points moving in a circle.
}
\usage{
BM.circle(n = 20, col = rainbow(n), ...)
}
\arguments{
  \item{n}{ number of points }
  \item{col}{ colors of points }
  \item{\dots}{ other parameters passed to \code{\link[graphics]{points}} }
}
\details{
This is a solution to the question raised in R-help: \url{https://stat.ethz.ch/pipermail/r-help/2008-December/183018.html}.
}
\value{
Invisible \code{NULL}.
}
\references{ \url{http://animation.yihui.name/prob:brownian_motion_circle} }
\author{ Yihui Xie }
\seealso{ \code{\link{brownian.motion}}, \code{\link[stats:Normal]{rnorm}} }
\examples{
oopt = ani.options(interval = 0.1, nmax = 300)
opar = par(mar = rep(0.5, 4))
BM.circle(cex = 2, pch = 19)

\dontrun{

ani.options(ani.height = 450, ani.width = 450, outdir = getwd(), 
    interval = 0.05, nmax = 100, title = "Brownian Motion in a Circle", 
    description = "Brownian Motion in a circle.")
ani.start()
par(mar = rep(0.5, 4))
BM.circle(cex = 2, pch = 19)
ani.stop()

}

par(opar)
ani.options(oopt) 

}
\keyword{ dynamic }
