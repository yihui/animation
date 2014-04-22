\name{vi.lilac.chaser}
\alias{vi.lilac.chaser}
\title{Visual Illusions: Lilac Chaser}
\usage{
vi.lilac.chaser(np = 16, col = "magenta", bg = "gray", p.cex = 7,
  c.cex = 5)
}
\arguments{
  \item{np}{number of points}

  \item{col}{color of points}

  \item{bg}{background color of the plot}

  \item{p.cex}{magnification of points}

  \item{c.cex}{magnification of the center cross}
}
\value{
\code{NULL}
}
\description{
Stare at the center cross for a few (say 30) seconds to
experience the phenomena of the illusion.
}
\details{
Just try it out.
}
\note{
In fact, points in the original version of `Lilac Chaser'
are \emph{blurred}, which is not implemented in this
function.
}
\examples{
oopt = ani.options(interval = 0.05, nmax = 20)
par(pty = 's')
vi.lilac.chaser()

## HTML animation page; nmax = 1 is enough!
saveHTML({
  ani.options(interval = 0.05, nmax = 1)
  par(pty = 's', mar = rep(1, 4))
  vi.lilac.chaser()
}, img.name='vi.lilac.chaser', htmlfile='vi.lilac.chaser.html',
         ani.height = 480, ani.width = 480,
         title = 'Visual Illusions: Lilac Chaser',
         description = c('Stare at the center cross for a few (say 30) seconds',
                         'to experience the phenomena of the illusion.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
\url{http://vis.supstat.com/2013/03/make-visual-illusions-in-r}
}
\seealso{
\code{\link{points}}
}

