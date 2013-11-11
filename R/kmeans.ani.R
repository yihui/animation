#' Demonstration of the k-Means clustering algorithm
#'
#' This function provides a demo of the k-Means cluster algorithm for data
#' containing only two variables (columns).
#'
#' The k-Means cluster algorithm may be regarded as a series of iterations of:
#' finding cluster centers, computing distances between sample points, and
#' redefining cluster membership.
#'
#' The data given by \code{x} is clustered by the \eqn{k}-means method, which
#' aims to partition the points into \eqn{k} groups such that the sum of squares
#' from points to the assigned cluster centers is minimized. At the minimum, all
#' cluster centres are at the mean of their Voronoi sets (the set of data points
#' which are nearest to the cluster centre).
#' @param x A numercal matrix or an object that can be coerced to such a matrix
#'   (such as a numeric vector or a data frame with all numeric columns)
#'   containing \emph{only} 2 columns.
#' @param centers Either the number of clusters or a set of initial (distinct)
#'   cluster centres.  If a number, a random set of (distinct) rows in \code{x}
#'   is chosen as the initial centres.
#' @param pch,col Symbols and colors for different clusters; the length of these
#'   two arguments should be equal to the number of clusters, or they will be
#'   recycled.
#' @param hints Two text strings indicating the steps of k-means clustering:
#'   move the center or find the cluster membership?
#' @return A list with components \item{cluster }{A vector of integers
#'   indicating the cluster to which each point is allocated.} \item{centers }{A
#'   matrix of cluster centers.}
#' @note This function is only for demonstration purpose. For practical
#'   applications please refer to \code{\link{kmeans}}.
#'
#'   Note that \code{ani.options('nmax')} is defined as the maximum number of
#'   iterations in such a sense: an iteration includes the process of computing
#'   distances, redefining membership and finding centers. Thus there should be
#'   \code{2 * ani.options('nmax')} animation frames in the output if the other
#'   condition for stopping the iteration has not yet been met (i.e. the cluster
#'   membership will not change any longer).
#' @author Yihui Xie
#' @seealso \code{\link{kmeans}}
#' @export
#' @example inst/examples/kmeans.ani-ex.R
kmeans.ani = function(
  x = cbind(X1 = runif(50), X2 = runif(50)), centers = 3, hints = c('Move centers!', 'Find cluster?'),
  pch = 1:3, col = 1:3
) {
  x = as.matrix(x)
  ocluster = sample(centers, nrow(x), replace = TRUE)
  if (length(centers) == 1) centers = x[sample(nrow(x), centers), ] else
    centers = as.matrix(centers)
  numcent = nrow(centers)
  dst = matrix(nrow = nrow(x), ncol = numcent)
  j = 1
  pch = rep(pch, length = numcent)
  col = rep(col, length = numcent)
  for (j in 1:ani.options('nmax')) {
    dev.hold()
    plot(x, pch = pch[ocluster], col = col[ocluster], panel.first = grid())
    mtext(hints[1], 4)
    points(centers, pch = pch[1:numcent], cex = 3, lwd = 2, col = col[1:numcent])
    ani.pause()
    for (i in 1:numcent) {
      dst[, i] = sqrt(apply((t(t(x) - unlist(centers[i, ])))^2, 1, sum))
    }
    ncluster = apply(dst, 1, which.min)
    plot(x, type = 'n')
    mtext(hints[2], 4)
    grid()
    ocenters = centers
    for (i in 1:numcent) {
      xx = subset(x, ncluster == i)
      polygon(xx[chull(xx), ], density = 10, col = col[i], lty = 2)
      points(xx, pch = pch[i], col = col[i])
      centers[i, ] = apply(xx, 2, mean)
    }
    points(ocenters, cex = 3, col = col[1:numcent], pch = pch[1:numcent], lwd = 2)
    ani.pause()
    if (all(ncluster == ocluster)) break
    ocluster = ncluster
  }
  invisible(list(cluster = ncluster, centers = centers))
}
