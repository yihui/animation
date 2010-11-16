\name{sample.strat}
\alias{sample.strat}
\title{ Demonstration for stratified sampling }
\description{
  Every rectangle stands for a stratum, and the simple random sampling without replacement is performed within each stratum. The points being sampled are marked out (by red circles by default).
}
\usage{
sample.strat(pop = ceiling(10 * runif(10, 0.5, 1)),
    size = ceiling(pop * runif(length(pop), 0, 0.5)),
    p.col = c("blue", "red"), p.cex = c(1, 3), ...)
}
\arguments{
  \item{pop}{ a vector for the size of each stratum in the population. }
  \item{size}{ a corresponding vector for the sample size in each stratum (recycled if necessary). }
  \item{p.col, p.cex}{ different colors /magnification rate to annotate the population and the sample }
  \item{\dots}{ other arguments passed to \code{\link[graphics]{rect}} to annotate the ``strata'' }
}
\value{
None (invisible `\code{NULL}').
}
\references{
Cochran, W G (1977) \emph{Sampling Techniques}, Wiley, ISBN 0-471-16240-X 

\url{http://animation.yihui.name/samp:stratified_sampling}
}
\author{ Yihui Xie <\url{http://yihui.name}> }
\seealso{
\code{\link[base]{sample}}, \code{\link{sample.simple}}, \code{\link{sample.cluster}}, \code{\link{sample.ratio}}, \code{\link{sample.system}}
}
\examples{
oopt = ani.options(interval = 1, nmax = 30)
op = par(mar = rep(1, 4), lwd = 2)
sample.strat(col = c("bisque", "white"))
par(op)
\dontrun{

# HTML animation page
ani.options(ani.height = 350, ani.width = 500, outdir = getwd(), nmax = 30,
    interval = 1, title = "Demonstration of the stratified sampling",
    description = "Every rectangle stands for a stratum, and the simple
    random sampling without replacement is performed within each stratum.")
ani.start()
par(mar = rep(1, 4), lwd = 2)
sample.strat(col = c("bisque", "white"))
ani.stop()

}
ani.options(oopt)
}
\keyword{ distribution }
\keyword{ dynamic }