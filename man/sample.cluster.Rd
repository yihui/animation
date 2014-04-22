\name{sample.cluster}
\alias{sample.cluster}
\title{Demonstration for the cluster sampling}
\usage{
sample.cluster(pop = ceiling(10 * runif(10, 0.2, 1)), size = 3,
  p.col = c("blue", "red"), p.cex = c(1, 3), ...)
}
\arguments{
  \item{pop}{a vector for the size of each cluster in the
  population.}

  \item{size}{the number of clusters to be drawn out.}

  \item{p.col,p.cex}{different colors / magnification rate
  to annotate the population and the sample}

  \item{\dots}{other arguments passed to \code{\link{rect}}
  to annotate the ``clusters''}
}
\value{
None (invisible \code{NULL}).
}
\description{
Each rectangle stands for a cluster, and the simple random
sampling without replacement is performed for each cluster.
All points in the clusters being sampled will be drawn out.
}
\examples{
oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4))
sample.cluster(col = c('bisque', 'white'))

## HTML animation page
saveHTML({
  par(mar = rep(1, 4), lwd = 2)
  ani.options(nmax = ifelse(interactive(), 50, 2))
  sample.cluster(col = c('bisque', 'white'))
}, img.name='sample.cluster',htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = 'Demonstration of the cluster sampling',
         description = c('Once a cluster is sampled,',
                         'all its elements will be chosen.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{sample}}, \code{\link{sample.simple}},
\code{\link{sample.ratio}}, \code{\link{sample.strat}},
\code{\link{sample.system}}
}

