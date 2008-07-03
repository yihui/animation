\name{sample.system}
\alias{sample.system}
\title{ Demonstration for systematic sampling }
\description{
  The whole sample frame is denoted by a matrix (\code{nrow * ncol}) in the plane, and the sample points with equal intervals are drawn out according to a random starting point. The points being sampled are marked by red circles.
}
\usage{
sample.system(nrow = 10, ncol = 10, size = 15,
    p.col = c("blue", "red"), p.cex = c(1, 3))
}
\arguments{
  \item{nrow}{ the desired number of rows of the sample frame. }
  \item{ncol}{ the desired number of columns of the sample frame. }
  \item{size}{ the sample size. }
  \item{p.col, p.cex}{ different colors / magnification rate to annotate the population and the sample }
}
\value{
None (invisible `\code{NULL}').
}
\references{
Cochran, W G (1977) \emph{Sampling Techniques}, Wiley, ISBN 0-471-16240-X 

\url{}
}
\author{ Yihui Xie }
\seealso{ \code{\link[base:sample]{sample}} }
\examples{
oopt = ani.options(interval = 1, nmax = 30)
op = par(mar = rep(1, 4), lwd = 2)
sample.system()
par(op)
\dontrun{

# HTML animation page
ani.options(ani.height = 350, ani.width = 500, outdir = getwd(), nmax = 30,
    interval = 1, title = "Demonstration of the systematic sampling",
    description = "Sampling with equal distances.")
ani.start()
par(mar = rep(1, 4), lwd = 2)
sample.system()
ani.stop()

}
ani.options(oopt)
}
\keyword{ distribution }
\keyword{ dynamic }