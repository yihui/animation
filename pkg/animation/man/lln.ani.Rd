\name{lln.ani}
\alias{lln.ani}
\title{ Demonstration of Law of Large Numbers }
\description{
  This function plots the sample mean as the sample size grows to check whether the sample mean approaches to the population mean. 
}
\usage{
lln.ani(FUN = rnorm, mu = 0, np = 30, pch = 20, col.poly = "bisque",
    col.mu = "gray", ...)
}
\arguments{
  \item{FUN}{ a function to generate random numbers from a certain distribution: \code{function(n, mu)} }
  \item{mu}{ population mean; passed to \code{FUN} }
  \item{np}{ times for sampling from a distribution (not the sample size!); to examine the behaviour of the sample mean, we need more times of sampling to get a series of mean values }
  \item{pch}{ symbols for points; see Details }
  \item{col.poly}{ the color of the polygon to annotate the range of sample means }
  \item{col.mu}{ the color of the horizontal line which denotes the population mean }
  \item{\dots}{ other arguments passed to \code{\link[graphics:points]{points}} }
}
\details{
  \code{np} points are plotted to denote the distribution of the sample mean; we will observe that the range of the sample mean just becomes smaller and smaller as the sample size increases and ultimately there will be an obvious trend that the sample mean converges to the population mean \code{mu}. 
  
  The parameter \code{nmax} in \code{\link{ani.options}} means the maximum sample size.
}
\note{
  The argument \code{pch} will influence the speed of plotting, and for a very large sample size (say, 300), it is suggested that this argument be specified as '\code{.}'. 
} 
\value{
None (invisible `\code{NULL}').
}
\references{ 
George Casella and Roger L. Berger. \emph{Statistical Inference}. Duxbury Press, 2th edition, 2001. 

\url{http://animation.yihui.name/prob:law_of_large_numbers}
}
\author{ Yihui Xie <\url{http://yihui.name}> }
\examples{
oopt = ani.options(interval = 0.01, nmax = 150)
lln.ani(pch = ".")

# chi-square distribution; population mean = df
lln.ani(function(n, mu) rchisq(n, df = mu), mu = 5, cex = 0.6)

\dontrun{ 
# save the animation in HTML pages
ani.options(ani.height = 480, ani.width = 600, outdir = getwd(), nmax = 100,
    interval = 0.1, title = "Demonstration of the Law of Large Numbers",
    description = "The sample mean approaches to the population mean as
    the sample size n grows.")
ani.start()
par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
lln.ani(cex = 0.6)
ani.stop()
}
ani.options(oopt)
}
\keyword{ dynamic }
\keyword{ dplot }
\keyword{ distribution }
