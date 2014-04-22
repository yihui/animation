\name{quincunx}
\alias{quincunx}
\alias{quincunx2}
\title{Demonstration of the Quincunx (Bean Machine/Galton Box)}
\usage{
quincunx(balls = 200, layers = 15, pch.layers = 2, pch.balls = 19,
  col.balls = sample(colors(), balls, TRUE), cex.balls = 2)

quincunx2(balls = 200, layers = 15, pch.layers = 2, pch.balls = 19,
  col.balls = sample(colors(), balls, TRUE), cex.balls = 2)
}
\arguments{
  \item{balls}{number of balls}

  \item{layers}{number of layers}

  \item{pch.layers}{point character of layers; triangles
  (\code{pch = 2}) are recommended}

  \item{pch.balls,col.balls,cex.balls}{point character,
  colors and magnification of balls}
}
\value{
A named vector: the frequency table for the locations of
the balls.  Note the names of the vector are the locations:
1.5, 2.5, ..., layers - 0.5.
}
\description{
Simulates the quincunx with ``balls'' (beans) falling
through several layers (denoted by triangles) and the
distribution of the final locations at which the balls hit
is denoted by a histogram; \code{quincunx()} is shows
single layer, and \code{quincunx2()} is a two-stage version
of the quincunx.
}
\details{
The bean machine, also known as the quincunx or Galton box,
is a device invented by Sir Francis Galton to demonstrate
the law of error and the normal distribution.

When a ball falls through a layer, it can either go to the
right or left side with the probability 0.5. At last the
location of all the balls will show us the bell-shaped
distribution.
}
\note{
The maximum number of animation frames is controlled by
\code{ani.options('nmax')} as usual, but it is strongly
recommended that \code{ani.options(nmax = balls + layers
-2)}, in which case all the balls will just fall through
all the layers and there will be no redundant animation
frames.
}
\examples{
set.seed(123)
oopt=ani.options(nmax = ifelse(interactive(), 200 + 15 -2, 2), interval = 0.03)
freq = quincunx(balls = 200, col.balls = rainbow(200))
## frequency table
barplot(freq, space = 0)

## HTML animation page
saveHTML({
  ani.options(nmax = ifelse(interactive(), 200 + 15 -2, 2), interval = 0.03)
  quincunx(balls = 200, col.balls = rainbow(200))
}, img.name='quincunx', htmlfile='quincunx.html',
         ani.height = 500, ani.width = 600,
         single.opts = paste("'controls':", "['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'],", "'delayMin': 0"),
         title = 'Demonstration of the Galton Box',
         description = c('Balls', 'falling through pins will show you the Normal',
                         'distribution.'))

ani.options(oopt)
set.seed(123)
oopt=ani.options(nmax = ifelse(interactive(), 200 + 15 -2, 2), interval = 0.03)
freq = quincunx2(balls = 200, col.balls = rainbow(200))

## frequency table
barplot(freq$top, space = 0) # top layers
barplot(freq$bottom, space = 0) # bottom layers

## HTML animation page
saveHTML({
  ani.options(nmax = ifelse(interactive(), 200 + 15 -2, 2), interval = 0.03)
  quincunx2(balls = 200, col.balls = rainbow(200))
}, img.name='quincunx2', htmlfile='quincunx2.html',
         ani.height = 500, ani.width = 600,
         single.opts = paste("'controls':", "['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'],", "'delayMin': 0"),
         title = 'Demonstration of the Galton Box',
         description = c('Balls', 'falling through pins will show you the Normal',
                         'distribution.'))

ani.options(oopt)

}
\author{
Yihui Xie, Lijia Yu, and Keith ORourke
}
\references{
\url{http://vis.supstat.com/2013/04/bean-machine}
}
\seealso{
\code{\link{rbinom}}
}

