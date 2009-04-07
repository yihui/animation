\name{conf.int}
\alias{conf.int}
\title{ Demonstration of Confidence Intervals }
\description{
  This function gives a demonstration of the concept of confidence intervals in mathematical statistics in this way: keep on drawing samples from the Normal distribution N(0, 1), computing the intervals based on a given confidence level and plotting them as segments in a graph. In the end, we may check the coverage rate against the given confidence level. 
}
\usage{
conf.int(level = 0.95, size = 50, cl = c("red", "gray"), ...)
}
\arguments{
  \item{level}{ the confidence level \eqn{(1 - \alpha)}, e.g. 0.95 }
  \item{size}{ the sample size for drawing samples from N(0, 1) }
  \item{cl}{ two different colors to annotate whether the confidence intervals cover the true mean (\code{cl[1]}: yes; \code{cl[2]}: no) }
  \item{\dots}{ other arguments passed to \code{\link[graphics:plot.default]{plot}} }
}
\details{
  Intervals that cover the true parameter are denoted in color \code{cl[2]}, otherwise in color \code{cl[1]}. Each time we draw a sample, we can compute the corresponding confidence interval. As the process of drawing samples goes on, there will be a legend indicating the numbers of the two kinds of intervals respectively and the coverage rate is also denoted in the top-left of the plot.
  
  The argument \code{nmax} in \code{\link{ani.options}} controls the maximum times of drawing samples.
}
\value{
  A list containing 
  \item{level }{confidence level}
  \item{size }{sample size}
  \item{CI}{a matrix of confidence intervals for each sample}
  \item{CR}{coverage rate} 
}
\references{
George Casella and Roger L. Berger. \emph{Statistical Inference}. Duxbury Press, 2th edition, 2001. 

\url{http://animation.yihui.name/mathstat:confidence_interval}
}
\author{ Yihui Xie }
\examples{
oopt = ani.options(interval = 0.1, nmax = 100)
# 90\% interval
conf.int(0.90, main = "Demonstration of Confidence Intervals")

\dontrun{
 
# save the animation in HTML pages
ani.options(ani.height = 400, ani.width = 600, outdir = getwd(), nmax = 100,
    interval = 0.15, title = "Demonstration of Confidence Intervals",
    description = "This animation shows the concept of the confidence
    interval which depends on the observations: if the samples change,
    the interval changes too. At last we can see that the coverage rate
    will be approximate to the confidence level.")
ani.start()
par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
conf.int()
ani.stop() 

}
ani.options(oopt)
}
\keyword{ dynamic }
\keyword{ dplot }
\keyword{ distribution }
