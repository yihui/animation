\name{fisher.trans}
\Rdversion{1.1}
\alias{fisher.trans}
\title{Fisher's z-transformation}
\description{
Do Fisher's z-transformation on correlation coefficient of two vectors
}
\usage{
fisher.trans(x, y, rho = 0, conf.level = 0.95, ...)
}
\arguments{
  \item{x,y}{two (non-empty) numeric vectors of data values
}
 
  \item{rho}{ a number indicating the true value of the correlation coefficient
}
  \item{conf.level}{
confidence level of the interval
}
  \item{\dots}{
further arguments to be passed to \code{\link[stats]{cor}}
}
}
\details{
\eqn{Z_r=\frac{1}{2}log(\frac{1+r}{1-r})}
CI for \eqn{\frac{1}{2}log(\frac{1+r}{1-r})} is \eqn{Z_r\pm z_{1-\alpha/2}\sqrt{\frac{1}{n-3}}}
}
\value{
A list containing the following components:
\item{estimate}{\eqn{Z_r}}
\item{p.value}{the p-value for the test}
\item{conf.int}{a confidence interval for the correlation coefficient to specified alternative hypothesis}
}
\references{
}
\author{Hui Lin and Yihui Xie
}
\examples{
fisher.trans(longley[,1],longley[,2],rho=0.5)
}
\keyword{htest}