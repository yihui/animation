\name{vi.lilac.chaser}
\alias{vi.lilac.chaser}
\title{ Visual Illusions: Lilac Chaser }
\description{
  Stare at the center cross for a few (say 30) seconds to experience the phenomena of the illusion.
}
\usage{
vi.lilac.chaser(np = 16, col = "magenta", bg = "gray", p.cex = 7, c.cex = 5)
}
\arguments{
  \item{np}{ number of points }
  \item{col}{ color of points }
  \item{bg}{ background color of the plot }
  \item{p.cex}{ magnification of points }
  \item{c.cex}{ magnification of the center cross }
}
\details{
  Just try it out. 
}
\value{
None.
}
\references{
\url{http://en.wikipedia.org/wiki/Lilac_chaser}

\url{http://animation.yihui.name/animation:misc\#lilac_chaser}
}
\author{ Yihui Xie }
\note{ 
In fact, points in the original version of `Lilac Chaser' are \emph{blurred}, which is not implemented in this function. If you have any idea, please contact me. 
}
\seealso{ \code{\link[graphics]{points}} }
\examples{
oopt = ani.options(interval = 0.05, nmax = 20)
op = par(pty = "s") 
vi.lilac.chaser()

\dontrun{ 

# HTML animation page; nmax = 1 is enough! 
ani.options(ani.height = 480, ani.width = 480, outdir = getwd(), nmax = 1,
    interval = 0.05, title = "Visual Illusions: Lilac Chaser",
    description = "Stare at the center cross for a few (say 30) seconds
    to experience the phenomena of the illusion.")
ani.start()
par(pty = "s", mar = rep(1, 4))
vi.lilac.chaser()
ani.stop()

}
par(op) 
ani.options(oopt)
}
\keyword{ dynamic }

