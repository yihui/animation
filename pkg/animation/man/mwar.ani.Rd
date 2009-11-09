\name{mwar.ani}
\alias{mwar.ani}
\title{ Demonstration for ``Moving Window Auto-Regression'' }
\description{
  This function just fulfills a very naive idea about moving window regression using rectangles to denote the ``windows'' and move them, and the corresponding AR(1) coefficients as long as rough confidence intervals are computed for data points inside the ``windows'' during the process of moving.  
}
\usage{
mwar.ani(x, k = 15, conf = 2, mat = matrix(1:2,
    2), widths = rep(1, ncol(mat)), heights = rep(1, nrow(mat)),
    lty.rect = 2, ...)
}
\arguments{
  \item{x}{ univariate time-series (a single numerical vector); default to be \code{sin(seq(0, 2 * pi, length = 50)) + rnorm(50, sd = 0.2)} }
  \item{k}{ an integer of the window width }
  \item{conf}{ a positive number: the confidence intervals are computed as [ar1 - conf*s.e., ar1 + conf*s.e.] }
  \item{mat, widths, heights}{ arguments passed to \code{\link[graphics]{layout}} to divide the device into 2 parts }
  \item{lty.rect}{ the line type of the rectangles respresenting the moving ``windows'' }
  \item{\dots}{ other arguments passed to \code{\link[graphics]{points}} in the bottom plot (the centers of the arrows) }
}
\details{
The AR(1) coefficients are computed by \code{\link[stats]{arima}}.
} 
\value{
A list containing 
  \item{phi }{the AR(1) coefficients}
  \item{L }{lower bound of the confidence interval}
  \item{U }{upper bound of the confidence interval} 
}
\references{ 
Robert A. Meyer, Jr. Estimating coefficients that change over time. \emph{International Economic Review}, 13(3):705-710, 1972.

\url{http://animation.yihui.name/ts:moving_window_ar}
}
\author{ Yihui Xie <\url{http://yihui.name}> }
\seealso{  \code{\link[stats]{arima}} }
\examples{
# moving window along a sin curve 
oopt = ani.options(interval = 0.1, nmax = 50)
op = par(mar = c(2, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
mwar.ani(lty.rect = 3, pch = 21, col = "red", bg = "yellow",type='o')

# for the data 'pageview'
ani.options(interval = 0.1, nmax = 50)
data(pageview)
mwar.ani(pageview$visits, k = 30)

par(op)

\dontrun{ 
# HTML animation page
ani.options(ani.height = 500, ani.width = 600, nmax = 50,
    title = "Demonstration of Moving Window Auto-Regression",
    description = "Compute the AR(1) coefficient for the data in the
    window and plot the confidence intervals. Repeat this step as the
    window moves.")
ani.start()
par(mar = c(2, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
mwar.ani(lty.rect = 3, pch = 21, col = "red", bg = "yellow",type='o')
ani.stop()
}

ani.options(oopt)
}
\keyword{ dplot }
\keyword{ dynamic }
\keyword{ ts }
