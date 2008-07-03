\name{boot.iid}
\alias{boot.iid}
\title{ Bootstrapping the i.i.d data }
\description{
  Demonstrate bootstrapping for i.i.d data: use a sunflower scatter plot to illustrate the results of sampling, and a histogram to show the distribution of the statistic of interest.
}
\usage{
boot.iid(x = runif(20), statistic = mean, m = length(x),
    mat = matrix(1:2, 2), widths = rep(1, ncol(mat)),
    heights = rep(1, nrow(mat)),
    col = c("black", "red", "bisque", "red", "gray"),
    cex = c(1.5, 0.8),
    main = c("Bootstrapping the i.i.d data", "Density of bootstrap estimates"),
    ...)
}
\arguments{
  \item{x}{ a numerical vector (the original data). }
  \item{statistic}{ A function which returns a value of the statistic of interest when applied to the data x. }
  \item{m}{ the sample size for bootstrapping (\eqn{m}-out-of-\eqn{n} bootstrap) }
  \item{mat, widths, heights}{ arguments passed to \code{\link[graphics]{layout}} to set the layout of the two graphs }
  \item{col}{ a character vector of length 5 specifying the colors of: points of original data, points for the sunflowerplot, rectangles of the histogram, the density line, and the rug. }
  \item{cex}{ a numeric vector of length 2: magnification of original data points and the sunflowerplot points. }
  \item{main}{ a character vector of length 2: the main titles of the two graphs. }
  \item{\dots}{ other arguments passed to \code{\link[graphics]{sunflowerplot}} }
}
\details{
 This is actually a very naive version of bootstrapping but may be useful for novices. By default, the circles denote the original dataset, while the red sunflowers (probably) with leaves denote the points being resampled; the number of leaves just means how many times these points are resampled, as bootstrap samples \emph{with} replacement.
 
 The whole process has illustrated the steps of resampling, computing the statistic and plotting its distribution based on bootstrapping.
}
\value{
  A list containing
  \item{t0 }{ The observed value of 'statistic' applied to 'x'.}
  \item{tstar }{Bootstrap versions of the 'statistic'.}
}
\references{ 
There are many references explaining the bootstrap and its variations. For a relatively complete one, you may just refer to:

Efron, B. and Tibshirani, R. (1993) \emph{An Introduction to the Bootstrap}. Chapman \& Hall.

\url{http://animation.yihui.name/dmml:bootstrap_i.i.d}

}
\author{ Yihui Xie }
\seealso{ \code{\link[graphics]{sunflowerplot}} }
\examples{
# bootstrap for 20 random numbers from U(0, 1)
opar = par(mar = c(1.5, 3, 1, 0.1), cex.lab = 0.8, cex.axis = 0.8,
    mgp = c(2, 0.5, 0), tcl = -0.3)
oopt = ani.options(interval = 0.5, nmax = 40)
# don't want the titles
boot.iid(main = c("", ""))

# for the median of 15 points from chi-square(5) 
boot.iid(x = rchisq(15, 5), statistic = median, main = c("", ""))

# change the layout; or you may try 'mat = matrix(1:2, 1)'
par(mar = c(1.5, 3, 2.5, 0.1), cex.main = 1)
boot.iid(heights = c(1, 2))

par(opar)

\dontrun{
 
# save the animation in HTML pages
ani.options(ani.height = 500, ani.width = 600, outdir = getwd(),
    title = "Bootstrapping the i.i.d data",
    description = "This is a naive version of bootstrapping but
    may be useful for novices.")
ani.start()
par(mar = c(2.5, 4, 0.5, 0.5))
boot.iid(main = c("", ""), heights = c(1, 2))
ani.stop()

}

ani.options(oopt)
}
\keyword{ nonparametric }
\keyword{ dynamic }
\keyword{ dplot }

