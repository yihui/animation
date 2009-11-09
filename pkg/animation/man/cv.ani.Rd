\name{cv.ani}
\alias{cv.ani}
\title{ Demonstration for the process of cross-validation }
\description{
  This function uses rectangles to illustrate the \eqn{k} folds and mark the test set \& the training set with different colors. 
}
\usage{
cv.ani(x = runif(150), k = 10, col = c("green", "red", "blue"),
    pch = c(4, 1), ...)
}
\arguments{
  \item{x}{ a numerical vector which stands for the sample points.}
  \item{k}{ an integer: how many parts should we split the data into? (comes from the \eqn{k}-fold cross-validation.) }
  \item{col}{ a character vector of length 3 specifying the colors of: the rectangle representing the test set, the points of the test set, and points of the training set. }
  \item{pch}{ a numeric vector of length 2 specifying the symbols of the test set and training set respectively. }
  \item{\dots}{ other arguments passed to \code{\link[graphics:plot.default]{plot}} }
}
\details{
Briefly speaking, the process of cross-validation is just to split the whole data set into several parts and select one part as the test set and the rest parts as the training set. 

  The computation of sample sizes is base on \code{\link{kfcv}}. 
}
\value{
None (invisible `\code{NULL}').
}

\author{ Yihui Xie <\url{http://yihui.name}> }
\note{ 
For the `leave-one-out' cross-validation, just specify \code{k} as \code{length(x)}, then the rectangles will `shrink' into single lines.

The final number of animation frames is the smaller one of \code{nmax} and \code{k}.

This function has nothing to do with specific models used in cross-validation.
}
\seealso{ \code{\link{kfcv}} }
\references{
\url{http://animation.yihui.name/dmml:k-fold_cross-validation}
}
\examples{
oopt = ani.options(interval = 2, nmax = 10)
cv.ani(main = "Demonstration of the k-fold Cross Validation", bty = "l")

# leave-one-out CV 
cv.ani(x = runif(15), k = 15) 

\dontrun{ 
# save the animation in HTML pages
ani.options(ani.height = 400, ani.width = 600, interval = 2,
    nmax = 10, title = "Demonstration of the k-fold Cross Validation",
    description = "This is a naive demonstration for the k-fold cross
    validation. The k rectangles in the plot denote the k folds of data.
    Each time a fold will be used as the test set and the rest parts
    as the training set.")
ani.start()
par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
cv.ani(bty = "l")
ani.stop()
}

ani.options(oopt)
}
\keyword{ hplot }
\keyword{ dynamic }
\keyword{ classif }