\name{kmeans.ani}
\alias{kmeans.ani}
\title{Demonstration of the k-Means clustering algorithm}
\usage{
kmeans.ani(x = cbind(X1 = runif(50), X2 = runif(50)), centers = 3,
  hints = c("Move centers!", "Find cluster?"), pch = 1:3, col = 1:3)
}
\arguments{
  \item{x}{A numercal matrix or an object that can be
  coerced to such a matrix (such as a numeric vector or a
  data frame with all numeric columns) containing
  \emph{only} 2 columns.}

  \item{centers}{Either the number of clusters or a set of
  initial (distinct) cluster centres.  If a number, a
  random set of (distinct) rows in \code{x} is chosen as
  the initial centres.}

  \item{pch,col}{Symbols and colors for different clusters;
  the length of these two arguments should be equal to the
  number of clusters, or they will be recycled.}

  \item{hints}{Two text strings indicating the steps of
  k-means clustering: move the center or find the cluster
  membership?}
}
\value{
A list with components \item{cluster }{A vector of integers
indicating the cluster to which each point is allocated.}
\item{centers }{A matrix of cluster centers.}
}
\description{
This function provides a demo of the k-Means cluster
algorithm for data containing only two variables (columns).
}
\details{
The k-Means cluster algorithm may be regarded as a series
of iterations of: finding cluster centers, computing
distances between sample points, and redefining cluster
membership.

The data given by \code{x} is clustered by the
\eqn{k}-means method, which aims to partition the points
into \eqn{k} groups such that the sum of squares from
points to the assigned cluster centers is minimized. At the
minimum, all cluster centres are at the mean of their
Voronoi sets (the set of data points which are nearest to
the cluster centre).
}
\note{
This function is only for demonstration purpose. For
practical applications please refer to
\code{\link{kmeans}}.

Note that \code{ani.options('nmax')} is defined as the
maximum number of iterations in such a sense: an iteration
includes the process of computing distances, redefining
membership and finding centers. Thus there should be
\code{2 * ani.options('nmax')} animation frames in the
output if the other condition for stopping the iteration
has not yet been met (i.e. the cluster membership will not
change any longer).
}
\examples{
## set larger 'interval' if the speed is too fast
oopt = ani.options(interval = 2)
par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
kmeans.ani()

## the kmeans() example; very fast to converge!
x = rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
          matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
colnames(x) = c('x', 'y')
kmeans.ani(x, centers = 2)

## what if we cluster them into 3 groups?
kmeans.ani(x, centers = 3)

## create an HTML animation page
saveHTML({
  ani.options(interval = 2)
  par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
  
  cent = 1.5 * c(1, 1, -1, -1, 1, -1, 1, -1); x = NULL
  for (i in 1:8) x = c(x, rnorm(25, mean = cent[i]))
  x = matrix(x, ncol = 2)
  colnames(x) = c('X1', 'X2')
  
  kmeans.ani(x, centers = 4, pch = 1:4, col = 1:4)
  
}, img.name='kmeans.ani',htmlfile='kmeans.ani.html',
         ani.height = 480, ani.width = 480,
         title = 'Demonstration of the K-means Cluster Algorithm',
         description = 'Move! Average! Cluster! Move! Average! Cluster! ...')

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{kmeans}}
}

