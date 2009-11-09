\name{sim.qqnorm}
\Rdversion{1.1}
\alias{sim.qqnorm}
\title{
Simulation of QQ plots for Normal distribution
}
\description{
This demo shows the possible QQ plots created by random numbers generated from a Normal distribution so that users can get a rough idea about how QQ plots really look like. 
}
\usage{
sim.qqnorm(n = 20, ...)
}
\arguments{
  \item{n}{
integer: sample size
}
  \item{\dots}{
other arguments passed to \code{\link[stats]{qqnorm}}
}
}
\details{
When the sample size is small, it is hard to get a correct inference about the distribution of data from a QQ plot. Even if the sample size is large, usually there are outliers far away from the straight line. Therefore, don't overinterpret the QQ plots.
}
\value{
\code{NULL}
}
\author{
Yihui Xie <\url{http://yihui.name}>
}
\seealso{
\code{\link[stats]{qqnorm}}
}
\examples{
oopt = ani.options(interval = 0.1, nmax = 100)
op = par(mar = c(3, 3, 2, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
sim.qqnorm()
par(op)

\dontrun{
 
# HTML animation page
ani.options(ani.height = 500, ani.width = 500, nmax = 100,
    interval = 0.1, title = "Demonstration of Simulated QQ Plots",
    description = "This animation shows the QQ plots of random numbers 
    from a Normal distribution. Does them really look like normally 
    distributed?")
ani.start()
par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
sim.qqnorm(n = 15, pch = 20, main = "")
ani.stop()
}
ani.options(oopt)
}
\keyword{ dynamic }
\keyword{ distribution }
\keyword{ dplot }
