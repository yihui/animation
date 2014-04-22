\name{clt.ani}
\alias{clt.ani}
\title{Demonstration of the Central Limit Theorem}
\usage{
clt.ani(obs = 300, FUN = rexp, mean = 1, sd = 1, col = c("bisque",
  "red", "blue", "black"), mat = matrix(1:2, 2), widths = rep(1, ncol(mat)),
  heights = rep(1, nrow(mat)), xlim, ...)
}
\arguments{
  \item{obs}{the number of sample means to be generated
  from the distribution based on a given sample size
  \eqn{n}; these sample mean values will be used to create
  the histogram}

  \item{FUN}{the function to generate \code{n} random
  numbers from a certain distribution}

  \item{mean,sd}{the expectation and standard deviation of
  the population distribution (they will be used to plot
  the density curve of the theoretical Normal distribution
  with mean equal to \code{mean} and sd equal to
  \eqn{sd/\sqrt{n}}; if any of them is \code{NA}, the
  density curve will be suppressed)}

  \item{col}{a vector of length 4 specifying the colors of
  the histogram, the density curve of the sample mean, the
  theoretical density cuve and P-values.}

  \item{mat,widths,heights}{arguments passed to
  \code{\link{layout}} to set the layout of the two
  graphs.}

  \item{xlim}{the x-axis limit for the histogram (it has a
  default value if not specified)}

  \item{\dots}{other arguments passed to
  \code{\link{plot.default}} to plot the P-values}
}
\value{
A data frame of P-values.
}
\description{
First of all, a number of \code{obs} observations are
generated from a certain distribution for each variable
\eqn{X_j}, \eqn{j = 1, 2, \cdots, n}{j = 1, 2, ..., n}, and
\eqn{n = 1, 2, \cdots, nmax}{n = 1, 2, ..., nmax}, then the
sample means are computed, and at last the density of these
sample means is plotted as the sample size \eqn{n}
increases (the theoretical limiting distribution is denoted
by the dashed line), besides, the P-values from the
normality test \code{\link{shapiro.test}} are computed for
each \eqn{n} and plotted at the same time.
}
\details{
As long as the conditions of the Central Limit Theorem
(CLT) are satisfied, the distribution of the sample mean
will be approximate to the Normal distribution when the
sample size \code{n} is large enough, no matter what is the
original distribution. The largest sample size is defined
by \code{nmax} in \code{\link{ani.options}}.
}
\examples{
oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 150, 2))
op = par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
clt.ani(type = 's')
par(op)

## HTML animation page
saveHTML({
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
  ani.options(interval = 0.1, nmax = ifelse(interactive(), 150, 10))
  clt.ani(type = 'h')
}, img.name='clt.ani', htmlfile='clt.ani.html',
         ani.height = 500, ani.width = 600,
         title = 'Demonstration of the Central Limit Theorem',
         description = c('This animation shows the distribution of the sample',
                         'mean as the sample size grows.'))

## other distributions: Chi-square with df = 5 (mean = df, var = 2*df)
f = function(n) rchisq(n, 5)
clt.ani(FUN = f, mean = 5, sd = sqrt(2*5))

ani.options(oopt)

}
\author{
Yihui Xie
}
\references{
\url{http://vis.supstat.com/2013/04/central-limit-theorem}
}
\seealso{
\code{\link{hist}}, \code{\link{density}}
}

