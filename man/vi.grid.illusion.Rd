\name{vi.grid.illusion}
\alias{vi.grid.illusion}
\title{Visual illusions: Scintillating grid illusion and Hermann grid illusion}
\usage{
vi.grid.illusion(nrow = 8, ncol = 8, lwd = 8, cex = 3,
  col = "darkgray", type = c("s", "h"))
}
\arguments{
  \item{nrow}{number of rows for the grid}

  \item{ncol}{number of columns for the grid}

  \item{lwd}{line width for grid lines}

  \item{cex}{magnification for points in Scintillating grid
  illusions}

  \item{col}{color for grid lines}

  \item{type}{type of illusions: \code{'s'} for
  Scintillating grid illusions and \code{'h'} for Hermann
  grid illusions}
}
\value{
\code{NULL}
}
\description{
The two most common types of grid illusions are Hermann
grid illusions and Scintillating grid illusions. This
function provides illustrations for both illusions.
}
\details{
A grid illusion is any kind of grid that deceives a
person's vision.

This is actually a static image; pay attention to the
intersections of the grid and there seems to be some moving
points (non-existent in fact).
}
\examples{
## default to be Scintillating grid illusions
vi.grid.illusion()

## set wider lines to see Hermann grid illusions
vi.grid.illusion(type = 'h', lwd = 22, nrow = 5, ncol = 5,
    col = 'white')
}
\author{
Yihui Xie
}
\references{
\url{http://vis.supstat.com/2013/03/make-visual-illusions-in-r}
}
\seealso{
\code{\link{points}}, \code{\link{abline}}
}

