\name{binom.norm.approx}
\alias{binom.norm.approx}
\title{
Approximation to Normal distribution from Binomial distribution
}
\description{
The sample mean for random variables from Bernoulli distribution will approximate to the Normal distribution under certain conditions, and this function demonstrates how the sample size \eqn{n} and \eqn{p} affects the approximation.
}
\usage{
binom.norm.approx(n = seq(1, 100, 2), p = seq(0, 1, 0.02), 
    nrep = 100, levels = c(0, 0.01, 0.05, 0.1, 0.2, 1), ...)
}
\arguments{
  \item{n}{
different sample sizes
}
  \item{p}{
different population probabilities of success
}
  \item{nrep}{
the number of sample means to compute in order to test the normality
}
  \item{levels}{
passed to \code{\link[graphics]{filled.contour}} to define the levels of p-values in the contour plot
}
  \item{\dots}{
other arguments passed to \code{\link[graphics]{filled.contour}}
}
}
\details{
For each combination of \eqn{n} and \eqn{p}, we generate \eqn{n} random numbers from Bernoulli(p) and compute the sample mean. Repeat this process for \code{nrep} times and we can get \code{nrep} sample means. Then we test the normality of sample means with the KS test. In the contour plot, different levels of p-values are visualized corresponding to different combinations of \eqn{n} and \eqn{p}.
}
\value{
A list containing
  \item{n}{sample sizes}
  \item{p}{population probabilities}
  \item{p.value}{p-values returned by KS test}
}
\author{
Yihui Xie <\url{http://yihui.name}>
}
\note{
This function is computer-intensive and might be slow. Use less \code{n}'s and \code{p}'s to get faster computation.
}
\seealso{
\code{\link[stats]{ks.test}}, \code{\link[graphics]{filled.contour}}
}
\examples{
## to be reproducible
set.seed(123)

par(mar = c(4, 4, 0.5, 1.5))
pval <- binom.norm.approx(seq(1, 50, 2), seq(0, 1, 
    0.05), xlab = "n (number of trials)", ylab = expression(pi ~ 
    "(probability of success)"))

## relationship between p-values and n*p
par(mar = c(4, 4, 0.1, 0.1))
np = c(outer(pval$n, pval$p, "*"))
n1p = c(outer(pval$n, 1 - pval$p, "*"))
cond = (np >= 5) & (n1p >= 5)
plot(np, c(pval$p.value), pch = 20, col = ifelse(cond, 
    rgb(0, 1, 0, 0.5), rgb(1, 0, 0, 0.5)), xlab = expression("n *" ~ 
    pi), ylab = "P-value") 
}
\keyword{ distribution }
\keyword{ htest }
