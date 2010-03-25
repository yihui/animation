\name{sample.simple}
\alias{sample.simple}
\title{ Demonstration for simple random sampling without replacement}
\description{
  The whole sample frame is denoted by a matrix (\code{nrow * ncol}) in the plane just for convenience, and the points being sampled are marked out (by red circles by default). Each member of the population has an equal and known chance of being selected.
}
\usage{
sample.simple(nrow = 10, ncol = 10, size = 15, p.col = c("blue", "red"),
    p.cex = c(1, 3))
}
\arguments{
  \item{nrow}{ the desired number of rows of the sample frame. }
  \item{ncol}{ the desired number of columns of the sample frame. }
  \item{size}{ the sample size. }
  \item{p.col, p.cex}{ different colors /magnification rate to annotate the population and the sample }
}
\value{
None (invisible `\code{NULL}').
}
\references{
Cochran, W G (1977) \emph{Sampling Techniques}, Wiley, ISBN 0-471-16240-X 

\url{http://animation.yihui.name/samp:srswr}
}
\author{ Yihui Xie <\url{http://yihui.name}> }
\seealso{
\code{\link[base]{sample}}, \code{\link{sample.ratio}}, \code{\link{sample.cluster}}, \code{\link{sample.strat}}, \code{\link{sample.system}}
}
\examples{
oopt = ani.options(interval = 1, nmax = 30)
op = par(mar = rep(1, 4))
sample.simple()
par(op)
\dontrun{

# HTML animation page
ani.options(ani.height = 350, ani.width = 500, nmax = 30, interval = 1,
    title = "Demonstration of the simple random sampling without replacement",
    description = "Each member of the population has an equal and known chance
    of being selected.")
ani.start()
par(mar = rep(1, 4), lwd = 2)
sample.simple()
ani.stop()

}
ani.options(oopt)
}
\keyword{ distribution }
\keyword{ dynamic }