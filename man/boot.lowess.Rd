\name{boot.lowess}
\alias{boot.lowess}
\title{Bootstrapping with LOWESS}
\usage{
boot.lowess(x, y = NULL, f = 2/3, iter = 3, line.col = "#FF000033", ...)
}
\arguments{
  \item{x,y,f,iter}{passed to \code{\link{lowess}}}

  \item{line.col}{the color of the LOWESS lines}

  \item{...}{other arguments passed to the scatterplot by
  \code{\link{plot}}}
}
\description{
Sample the original data with replacement and fit LOWESS
curves accordingly.
}
\details{
We keep on resampling the data and finally we will see
several bootstrapped LOWESS curves, which may give us a
rough idea about a ``confidence interval'' of the LOWESS
fit.
}
\examples{
oopt = ani.options(nmax = if (interactive()) 100 else 2, interval = .02)

boot.lowess(cars, pch = 20, xlab = 'speed', ylab = 'dist')

boot.lowess(cars, f = 1/3, pch = 20)

## save in HTML pages
saveHTML({
  par(mar = c(4.5,4,.5,.5))
  boot.lowess(cars, f = 1/3, pch = 20, xlab='speed', ylab='dist')
}, img.name='boot_lowess', imgdir='boot_lowess', interval=.1,
         title='Bootstrapping with LOWESS',
         description='Fit LOWESS curves repeatedly via bootstrapping.')

ani.options(oopt)
}
\author{
Yihui Xie
}

