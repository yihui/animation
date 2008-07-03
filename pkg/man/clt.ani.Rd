\name{clt.ani}
\alias{clt.ani}
\title{ Demonstration of the Central Limit Theorem }
\description{
  First of all, a number of \code{obs} observations are generated from a certain distribution for each variable \eqn{X_j}, \eqn{j = 1, 2, \cdots, n}{j = 1, 2, ..., n}, and \eqn{n = 1, 2, \cdots, nmax}{n = 1, 2, ..., nmax}, then the sample means are computed, and at last the density of these sample means is plotted as the sample size \eqn{n} increases, besides, the p-values from the normality test \code{\link[stats]{shapiro.test}} are computed for each \eqn{n} and plotted at the same time.
}
\usage{
clt.ani(obs = 300, FUN = rexp, col = c("bisque", "red", "black"),
    mat = matrix(1:2, 2), widths = rep(1, ncol(mat)),
    heights = rep(1, nrow(mat)), ...)
}
\arguments{
  \item{obs}{ the number of sample points to be generated from the distribution }
  \item{FUN}{ the function to generate \code{n} random numbers from a certain distribution }
  \item{col}{ a vector of length 2 specifying the colors of the histogram and the density line }
  \item{mat, widths, heights}{ arguments passed to \code{\link[graphics]{layout}} to set the layout of the two graphs. }
  \item{\dots}{ other arguments passed to \code{\link[graphics]{hist}} }
}
\details{
  As long as the conditions of the Central Limit Theorem (CLT) are satisfied, the distribution of the sample mean will be approximate to the Normal distribution when the sample size \code{n} is large enough, no matter what is the original distribution. The largest sample size is defined by \code{nmax} in \code{\link{ani.options}}.
}
\value{
None.
}
\references{ 
E. L. Lehmann, \emph{Elements of Large-Sample Theory}. Springer-Verlag, New York, 1999.

\url{http://animation.yihui.name/prob:central_limit_theorem}
}
\author{ Yihui Xie }
\seealso{ \code{\link[graphics]{hist}}, \code{\link[stats]{density}} }
\examples{

oopt = ani.options(interval = 0.1, nmax = 150)
op = par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
clt.ani(type = "s")
par(op)

\dontrun{
 
# HTML animation page
ani.options(ani.height = 500, ani.width = 600, outdir = getwd(), nmax = 100,
    interval = 0.1, title = "Demonstration of the Central Limit Theorem",
    description = "This animation shows the distribution of the sample
    mean as the sample size grows.")
ani.start()
par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
clt.ani(type = "h")
ani.stop()
}
ani.options(oopt)

# other distributions: Chi-square with df = 5 
f = function(n) rchisq(n, 5) 
clt.ani(FUN = f) 
}
\keyword{ dynamic }
\keyword{ distribution }
\keyword{ dplot }