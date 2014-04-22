\name{sample.simple}
\alias{sample.simple}
\title{Demonstration for simple random sampling without replacement}
\usage{
sample.simple(nrow = 10, ncol = 10, size = 15, p.col = c("blue", "red"),
  p.cex = c(1, 3))
}
\arguments{
  \item{nrow}{the desired number of rows of the sample
  frame.}

  \item{ncol}{the desired number of columns of the sample
  frame.}

  \item{size}{the sample size.}

  \item{p.col,p.cex}{different colors /magnification rate
  to annotate the population and the sample}
}
\value{
None (invisible \code{NULL}).
}
\description{
The whole sample frame is denoted by a matrix (\code{nrow *
ncol}) in the plane just for convenience, and the points
being sampled are marked out (by red circles by default).
Each member of the population has an equal and known chance
of being selected.
}
\examples{
oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4))
sample.simple()

## HTML animation page
saveHTML({
  par(mar = rep(1, 4), lwd = 2)
  ani.options(nmax = ifelse(interactive(), 50, 2))
  sample.simple()
}, img.name='sample.simple',htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = paste('Demonstration of', 'the simple random sampling without replacement'),
         description = c('Each member of the population has an equal and',
                         'known chance of being selected.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{sample}}, \code{\link{sample.ratio}},
\code{\link{sample.cluster}}, \code{\link{sample.strat}},
\code{\link{sample.system}}
}

