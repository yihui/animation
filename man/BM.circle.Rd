\name{BM.circle}
\alias{BM.circle}
\title{Brownian Motion in a circle}
\usage{
BM.circle(n = 20, col = rainbow(n), ...)
}
\arguments{
  \item{n}{number of points}

  \item{col}{colors of points}

  \item{\dots}{other parameters passed to
  \code{\link{points}}}
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
\examples{
oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 300, 2))
par(mar = rep(0.5, 4))
BM.circle(cex = 2, pch = 19)

saveHTML({
  par(mar = rep(0.5, 4), pch=19)
  ani.options(interval=0.05,nmax=ifelse(interactive(), 100, 10))
  BM.circle(cex = 2, pch = 19)
}, img.name='BM.circle', htmlfile='BM.circle.html', ani.height = 450, ani.width = 450,
         single.opts = paste(
           "'controls':", "['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'],",
           "'delayMin': 0"),
         title = 'Brownian Motion in a Circle',
         description = 'Brownian Motion in a circle.')

ani.options(oopt)

}
\author{
Yihui Xie
}
\references{
\url{http://http://vis.supstat.com/2012/11/brownian-motion-with-r/}
}
\seealso{
\code{\link{brownian.motion}}, \code{\link{rnorm}}
}

