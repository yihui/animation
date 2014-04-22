\name{ecol.death.sim}
\alias{ecol.death.sim}
\title{A simulation of the death of two species with certain probabilities}
\usage{
ecol.death.sim(nr = 10, nc = 10, num.sp = c(50, 50), col.sp = c(1, 2),
  pch.sp = c(1, 2), col.die = 1, pch.die = 4, cex = 3, ...)
}
\arguments{
  \item{nr,nc}{number of rows and columns of the field
  (plants grow on a \code{nr} x \code{nc} grid)}

  \item{num.sp}{number of two plants respectively}

  \item{col.sp,pch.sp}{colors and point symbols of the two
  species respectively}

  \item{col.die,pch.die,cex}{the color, point symbol and
  magnification to annotate the plant which dies (symbol
  default to be an `X')}

  \item{\dots}{other arguments passed to \code{\link{plot}}
  to set up the plot}
}
\value{
a vector (factor) containing 1's and 2's, denoting the
plants finally survived
}
\description{
Suppose there are two plant species in a field: A and B.
One of them will die at each time and a new plant will grow
in the place where the old plant died; the species of the
new plant depends on the proportions of two species: the
larger the proportion is, the greater the probability for
this species to come up will be.
}
\note{
\code{2 * ani.options('nmax')} image frames will actually
be produced.
}
\examples{
oopt = ani.options(nmax = ifelse(interactive(), 50, 2), interval = 0.3)
par(ann = FALSE, mar = rep(0, 4))
ecol.death.sim()

## large scale simulation
ani.options(nmax = ifelse(interactive(), 1000, 2), interval = 0.02)
ecol.death.sim(col.sp = c(8, 2), pch.sp = c(20, 17))

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
This animation is motivated by a question raised from Jing
Jiao, a student in biology, to show the evolution of two
species.

The original post is in the forum of the ``Capital of
Statistics'': \url{http://cos.name/cn/topic/14093} (in
Chinese)
}

