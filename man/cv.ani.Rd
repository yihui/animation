\name{cv.ani}
\alias{cv.ani}
\title{Demonstration for the process of cross-validation}
\usage{
cv.ani(x = runif(150), k = 10, col = c("green", "red", "blue"),
  pch = c(4, 1), ...)
}
\arguments{
  \item{x}{a numerical vector which stands for the sample
  points.}

  \item{k}{an integer: how many parts should we split the
  data into? (comes from the \eqn{k}-fold
  cross-validation.)}

  \item{col}{a character vector of length 3 specifying the
  colors of: the rectangle representing the test set, the
  points of the test set, and points of the training set.}

  \item{pch}{a numeric vector of length 2 specifying the
  symbols of the test set and training set respectively.}

  \item{\dots}{other arguments passed to
  \code{\link{plot.default}}}
}
\value{
None (invisible \code{NULL}).
}
\description{
This function uses rectangles to illustrate the \eqn{k}
folds and mark the test set and the training set with
different colors.
}
\details{
Briefly speaking, the process of cross-validation is just
to split the whole data set into several parts and select
one part as the test set and the rest parts as the training
set.

The computation of sample sizes is base on
\code{\link{kfcv}}.
}
\note{
For the `leave-one-out' cross-validation, just specify
\code{k} as \code{length(x)}, then the rectangles will
`shrink' into single lines.

The final number of animation frames is the smaller one of
\code{ani.options('nmax')} and \code{k}.

This function has nothing to do with specific models used
in cross-validation.
}
\examples{
oopt = ani.options(interval = 2, nmax = 15)
cv.ani(main = 'Demonstration of the k-fold Cross Validation', bty = 'l')

## leave-one-out CV
cv.ani(x = runif(15), k = 15)

## save the animation in HTML pages
saveHTML({
  ani.options(interval = 2)
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
  cv.ani(bty = 'l')
}, img.name='cv.ani',htmlfile='cv.ani.html',
         ani.height = 400, ani.width = 600,
         title = 'Demonstration of the k-fold Cross Validation',
         description = c('This is a naive demonstration for the k-fold cross',
                         'validation. The k rectangles in the plot denote the k folds of data.',
                         'Each time a fold will be used as the test set and the rest parts',
                         'as the training set.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{kfcv}}
}

