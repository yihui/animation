\name{kfcv}
\alias{kfcv}
\title{Sample sizes for k-fold cross-validation}
\usage{
kfcv(k, N)
}
\arguments{
  \item{k}{number of groups.}

  \item{N}{total sample size.}
}
\value{
A vector of length \code{k} containing \eqn{k} sample
sizes.
}
\description{
Compute sample sizes for \eqn{k}-fold cross-validation.
}
\details{
If N/k is an integer, the sample sizes are k `N/k's (N/k,
N/k, ...), otherwise the remainder will be allocated to
each group as `uniformly' as possible, and at last these
sample sizes will be permuted randomly.
}
\examples{
## divisible
kfcv(5, 25)

## not divisible
kfcv(10,77)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{cv.ani}}
}

