\name{knn.ani}
\alias{knn.ani}
\title{Demonstration of the k-Nearest Neighbour classification}
\usage{
knn.ani(train, test, cl, k = 10, interact = FALSE, tt.col = c("blue",
  "red"), cl.pch = seq_along(unique(cl)), dist.lty = 2, dist.col = "gray",
  knn.col = "green", ...)
}
\arguments{
  \item{train}{matrix or data frame of training set cases
  containing only 2 columns}

  \item{test}{matrix or data frame of test set cases. A
  vector will be interpreted as a row vector for a single
  case. It should also contain only 2 columns. This data
  set will be \emph{ignored} if \code{interact = TRUE}; see
  \code{interact} below.}

  \item{cl}{factor of true classifications of training set}

  \item{k}{number of neighbours considered.}

  \item{interact}{logical. If \code{TRUE}, the user will
  have to choose a test set for himself using mouse click
  on the screen; otherwise compute kNN classification based
  on argument \code{test}.}

  \item{tt.col}{a vector of length 2 specifying the colors
  for the training data and test data.}

  \item{cl.pch}{a vector specifying symbols for each class}

  \item{dist.lty,dist.col}{the line type and color to
  annotate the distances}

  \item{knn.col}{the color to annotate the k-nearest
  neighbour points using a polygon}

  \item{...}{additional arguments to create the empty frame
  for the animation (passed to \code{\link{plot.default}})}
}
\value{
A vector of class labels for the test set.
}
\description{
Demonstrate the process of k-Nearest Neighbour
classification on the 2D plane.
}
\details{
For each row of the test set, the \eqn{k} nearest (in
Euclidean distance) training set vectors are found, and the
classification is decided by majority vote, with ties
broken at random. For a single test sample point, the basic
steps are:

\enumerate{ \item locate the test point \item compute the
distances between the test point and all points in the
training set \item find \eqn{k} shortest distances and the
corresponding training set points \item vote for the result
(find the maximum in the table for the true
classifications) }

As there are four steps in an iteration, the total number
of animation frames should be \code{4 * min(nrow(test),
ani.options('nmax'))} at last.
}
\note{
There is a special restriction (only two columns) on the
training and test data set just for sake of the convenience
for making a scatterplot.  This is only a rough
demonstration; for practical applications, please refer to
existing kNN functions such as \code{\link[class]{knn}} in
\pkg{class}, etc.

If either one of \code{train} and \code{test} is missing,
there'll be random matrices prepared for them. (It's the
same for \code{cl}.)
}
\examples{
## a binary classification problem
oopt = ani.options(interval = 2, nmax = ifelse(interactive(), 10, 2))
x = matrix(c(rnorm(80, mean = -1), rnorm(80, mean = 1)),
           ncol = 2, byrow = TRUE)
y = matrix(rnorm(20, mean = 0, sd = 1.2), ncol = 2)
knn.ani(train = x, test = y, cl = rep(c('first class', 'second class'),
                                      each = 40), k = 30)

x = matrix(c(rnorm(30, mean = -2), rnorm(30, mean = 2),
             rnorm(30, mean = 0)), ncol = 2, byrow = TRUE)
y = matrix(rnorm(20, sd = 2), ncol = 2)
knn.ani(train = x, test = y, 
        cl = rep(c('first', 'second', 'third'), each = 15),
        k = 25, cl.pch = c(2, 3, 19), dist.lty = 3)

## an interactive demo: choose the test set by mouse-clicking
if (interactive()) {
  ani.options(nmax = 5)
  knn.ani(interact = TRUE)
}

## HTML page
saveHTML({
  ani.options(nmax = ifelse(interactive(), 10, 2),interval = 2)
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
  knn.ani(cl.pch = c(3, 19), asp = 1)
}, img.name='knn_ani',htmlfile='knn.ani.html',ani.height = 500, ani.width = 600,
         title = 'Demonstration for kNN Classification',
         description = c('For each row of the test set', 'the k nearest (in Euclidean',
                         'distance) training set vectors are found, and the classification is',
                         'decided by majority vote, with ties broken at random.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
Venables, W. N. and Ripley, B. D. (2002) \emph{Modern
Applied Statistics with S}. Fourth edition. Springer.
}
\seealso{
\code{\link[class]{knn}}
}

