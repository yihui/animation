\name{sample.system}
\alias{sample.system}
\title{Demonstration for the systematic sampling}
\usage{
sample.system(nrow = 10, ncol = 10, size = 15, p.col = c("blue", "red"),
  p.cex = c(1, 3))
}
\arguments{
  \item{nrow}{the desired number of rows of the sample
  frame.}

  \item{ncol}{the desired number of columns of the sample
  frame.}

  \item{size}{the sample size.}

  \item{p.col,p.cex}{different colors / magnification rate
  to annotate the population and the sample}
}
\value{
None (invisible \code{NULL}).
}
\description{
The whole sample frame is denoted by a matrix (\code{nrow *
ncol}) in the plane, and the sample points with equal
intervals are drawn out according to a random starting
point. The points being sampled are marked by red circles.
}
\examples{
oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4), lwd = 2)

sample.system()

## HTML animation pages
saveHTML({
  ani.options(interval = 1, nmax = ifelse(interactive(), 30,2))
  par(mar = rep(1, 4), lwd = 2)
  sample.system()
}, img.name='sample.system', htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = 'Demonstration of the systematic sampling',
         description = 'Sampling with equal distances.')

ani.options(oopt)

}
\author{
Yihui Xie
}
\seealso{
\code{\link{sample}}, \code{\link{sample.simple}},
\code{\link{sample.cluster}}, \code{\link{sample.ratio}},
\code{\link{sample.strat}}
}

