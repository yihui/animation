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
\author{
}
\note{
%%  ~~further notes~~
}

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(x, y, rho = 0, conf.level = 0.95, 
    ...) {
    n = length(x)
    r = cor(x, y, ...)
    estimate = 0.5 * log((1 + r)/(1 - r))
    rho0 = 0.5 * log((1 + rho)/(1 - rho))
    conf.int = sapply(exp(2 * (estimate + c(-1, 1) * qnorm(1 - 
        (1 - conf.level)/2) * sqrt(1/(n - 3)))), function(s) (s - 
        1)/(s + 1))
    names(conf.int) = c("lwr", "upr")
    list(estimate = estimate, p.value = 2 * pnorm(sqrt(n - 3) * 
        (estimate - rho0), lower.tail = FALSE), conf.int = conf.int)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
