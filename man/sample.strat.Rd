\name{sample.strat}
\alias{sample.strat}
\title{Demonstration for the stratified sampling}
\usage{
sample.strat(pop = ceiling(10 * runif(10, 0.5, 1)), size = ceiling(pop *
  runif(length(pop), 0, 0.5)), p.col = c("blue", "red"), p.cex = c(1, 3),
  ...)
}
\arguments{
  \item{pop}{a vector for the size of each stratum in the
  population.}

  \item{size}{a corresponding vector for the sample size in
  each stratum (recycled if necessary).}

  \item{p.col,p.cex}{different colors /magnification rate
  to annotate the population and the sample}

  \item{\dots}{other arguments passed to \code{\link{rect}}
  to annotate the ``strata''}
}
\value{
None (invisible `\code{NULL}').
}
\description{
Each rectangle stands for a stratum, and the simple random
sampling without replacement is performed within each
stratum. The points being sampled are marked out (by red
circles by default).
}
\examples{
oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4), lwd = 2)

sample.strat(col = c('bisque', 'white'))

## HTML animation page
saveHTML({
  par(mar = rep(1, 4), lwd = 2)
  ani.options(nmax = ifelse(interactive(), 50, 2))
  sample.strat(col = c('bisque', 'white'))
}, img.name='sample.strat', htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = 'Demonstration of the stratified sampling',
         description = c('Every rectangle stands for a stratum, and the simple',
                         'random sampling without replacement is performed within each stratum.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{sample}}, \code{\link{sample.simple}},
\code{\link{sample.cluster}}, \code{\link{sample.ratio}},
\code{\link{sample.system}}
}

