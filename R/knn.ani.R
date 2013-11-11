#' Demonstration of the k-Nearest Neighbour classification
#'
#' Demonstrate the process of k-Nearest Neighbour classification on the 2D
#' plane.
#'
#' For each row of the test set, the \eqn{k} nearest (in Euclidean distance)
#' training set vectors are found, and the classification is decided by majority
#' vote, with ties broken at random. For a single test sample point, the basic
#' steps are:
#'
#' \enumerate{ \item locate the test point \item compute the distances between
#' the test point and all points in the training set \item find \eqn{k} shortest
#' distances and the corresponding training set points \item vote for the result
#' (find the maximum in the table for the true classifications) }
#'
#' As there are four steps in an iteration, the total number of animation frames
#' should be \code{4 * min(nrow(test), ani.options('nmax'))} at last.
#'
#' @param train matrix or data frame of training set cases containing only 2
#'   columns
#' @param test matrix or data frame of test set cases. A vector will be
#'   interpreted as a row vector for a single case. It should also contain only
#'   2 columns. This data set will be \emph{ignored} if \code{interact = TRUE};
#'   see \code{interact} below.
#' @param cl factor of true classifications of training set
#' @param k number of neighbours considered.
#' @param interact logical. If \code{TRUE}, the user will have to choose a test
#'   set for himself using mouse click on the screen; otherwise compute kNN
#'   classification based on argument \code{test}.
#' @param tt.col a vector of length 2 specifying the colors for the training
#'   data and test data.
#' @param cl.pch a vector specifying symbols for each class
#' @param dist.lty,dist.col the line type and color to annotate the distances
#' @param knn.col the color to annotate the k-nearest neighbour points using a
#'   polygon
#' @param ... additional arguments to create the empty frame for the animation
#'   (passed to \code{\link{plot.default}})
#' @return A vector of class labels for the test set.
#' @note There is a special restriction (only two columns) on the training and
#'   test data set just for sake of the convenience for making a scatterplot.
#'   This is only a rough demonstration; for practical applications, please
#'   refer to existing kNN functions such as \code{\link[class]{knn}} in
#'   \pkg{class}, etc.
#'
#'   If either one of \code{train} and \code{test} is missing, there'll be
#'   random matrices prepared for them. (It's the same for \code{cl}.)
#' @author Yihui Xie
#' @seealso \code{\link[class]{knn}}
#' @references Venables, W. N. and Ripley, B. D. (2002) \emph{Modern Applied
#'   Statistics with S}. Fourth edition. Springer.
#'
#' @export
#' @example inst/examples/knn.ani-ex.R
knn.ani = function(
  train, test, cl, k = 10, interact = FALSE, tt.col = c('blue', 'red'),
  cl.pch = seq_along(unique(cl)), dist.lty = 2, dist.col = 'gray', knn.col = 'green', ...
) {
  nmax = ani.options('nmax')
  if (missing(train)) {
    train = matrix(c(rnorm(40, mean = -1), rnorm(40, mean = 1)), ncol = 2, byrow = TRUE)
    cl = rep(c('first class', 'second class'), each = 20)
  }
  if (missing(test))
    test = matrix(rnorm(20, mean = 0, sd = 1.2), ncol = 2)
  train <- as.matrix(train)
  if (interact) {
    plot(train, main = 'Choose test set points', pch = unclass(as.factor(cl)),
         col = tt.col[1])
    lct = locator(n = nmax, type = 'p', pch = '?', col = tt.col[2])
    test = cbind(lct$x, lct$y)
  }
  if (is.null(dim(test)))
    dim(test) <- c(1, length(test))
  test <- as.matrix(test)
  if (any(is.na(train)) || any(is.na(test)) || any(is.na(cl)))
    stop('no missing values are allowed')
  if (ncol(test) != 2 | ncol(train) != 2)
    stop("both column numbers of 'train' and 'test' must be 2!")
  ntr <- nrow(train)
  if (length(cl) != ntr)
    stop("'train' and 'class' have different lengths")
  if (ntr < k) {
    warning(gettextf('k = %d exceeds number %d of patterns', k, ntr), domain = NA)
    k <- ntr
  }
  if (k < 1)
    stop(gettextf('k = %d must be at least 1', k), domain = NA)
  nte = nrow(test)
  clf = as.factor(cl)
  res = NULL
  pre.plot = function(j, pf = NULL, i.point = TRUE, ...) {
    plot(rbind(train, test), type = 'n', xlab = expression(italic(X)[1]),
         ylab = expression(italic(X)[2]), panel.first = pf, ...)
    points(train, col = tt.col[1], pch = cl.pch[unclass(clf)])
    if (j < nte)
      points(test[(j + 1):nte, 1], test[(j + 1):nte, 2], col = tt.col[2], pch = '?')
    if (j > 1)
      points(test[1:(j - 1), 1], test[1:(j - 1), 2], col = tt.col[2],
             pch = cl.pch[unclass(res)], cex = 2)
    if (i.point)
      points(test[j, 1], test[j, 2], col = tt.col[2], pch = '?', cex = 2)
    legend('topleft', legend = levels(clf), pch = cl.pch[seq_along(levels(clf))],
           bty = 'n', y.intersp = 1.3)
    legend('bottomleft', legend = c('training set', 'test set'),
           fill = tt.col, bty = 'n', y.intersp = 1.3, )
  }
  nmax = min(nmax, nrow(test))
  for (i in 1:nmax) {
    dev.hold()
    pre.plot(i, ...)
    ani.pause()
    idx = rank(apply(train, 1, function(x) sqrt(sum((x - test[i, ])^2))),
               ties.method = 'random') %in% seq(k)
    vote = cl[idx]
    res = c(res, factor(names(which.max(table(vote))), levels = levels(clf), labels = levels(clf)))
    pre.plot(
      i, segments(train[, 1], train[, 2], test[i, 1], test[i, 2], lty = dist.lty, col = dist.col), ...
    )
    ani.pause()
    bd = train[idx, 1:2]
    pre.plot(
      i, {
        segments(train[, 1], train[, 2], test[i, 1], test[i,2], lty = dist.lty, col = dist.col)
        if (k > 1) polygon(bd[chull(bd), ], density = 10, col = knn.col) else
          points(bd[1], bd[2], col = knn.col, pch = cl.pch[unclass(clf)[idx]], cex = 2, lwd = 2)
      }, ...)
    ani.pause()
    pre.plot(
      i, {
        segments(train[, 1], train[, 2], test[i, 1], test[i, 2], lty = dist.lty, col = dist.col)
        if (k > 1) polygon(bd[chull(bd), ], density = 10, col = knn.col) else
          points(bd[1], bd[2], col = knn.col, pch = cl.pch[unclass(clf)[idx]], cex = 2, lwd = 2)
        points(test[i, 1], test[i, 2], col = tt.col[2], pch = cl.pch[unclass(res)[i]], cex = 3, lwd = 2)
      }, FALSE, ...)
    ani.pause()
  }
  invisible(levels(clf)[res])
}
