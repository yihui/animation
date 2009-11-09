\name{sample.cluster}
\alias{sample.cluster}
\title{ Demonstration for cluster sampling }
\description{
  Every rectangle stands for a cluster, and the simple random sampling without replacement is performed for each cluster. All points in the clusters being sampled will be drawn out.
}
\usage{
sample.cluster(pop = ceiling(10 * runif(10, 0.2, 1)), size = 3,
    p.col = c("blue", "red"), p.cex = c(1, 3), ...)
}
\arguments{
  \item{pop}{ a vector for the size of each cluster in the population. }
  \item{size}{ the number of clusters to be drawn out. }
  \item{p.col, p.cex}{ different colors / magnification rate to annotate the population and the sample }
  \item{\dots}{ other arguments passed to \code{\link[graphics]{rect}} to annotate the ``clusters'' }
}
\value{
None (invisible `\code{NULL}').
}
\references{
Cochran, W G (1977) \emph{Sampling Techniques}, Wiley, ISBN 0-471-16240-X 

\url{http://animation.yihui.name/samp:cluster_sampling}
}
\author{ Yihui Xie <\url{http://yihui.name}> }
\seealso{ \code{\link[base]{sample}} }
\examples{

oopt = ani.options(interval = 1, nmax = 30)
op = par(mar = rep(1, 4))
sample.cluster(col = c("bisque", "white"))
par(op)
\dontrun{ 

# HTML animation page
ani.options(ani.height = 350, ani.width = 500, nmax = 30,
    interval = 1, title = "Demonstration of the cluster sampling",
    description = "Once a cluster is sampled, all its elements will be
    chosen.")
ani.start()
par(mar = rep(1, 4), lwd = 2)
sample.cluster(col = c("bisque", "white"))
ani.stop()

}
ani.options(oopt)
}
\keyword{ distribution }
\keyword{ dynamic }