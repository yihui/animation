#' Cross-validation to find the optimum number of features (variables) in LDA
#'
#' This function provids an illustration of the process of finding out the
#' optimum number of variables using k-fold cross-validation in a linear
#' discriminant analysis (LDA).
#'
#' For a classification problem, usually we wish to use as less variables as
#' possible because of difficulties brought by the high dimension.
#'
#' The selection procedure is like this:
#'
#' \itemize{
#'   \item Split the whole data randomly into \eqn{k} folds:
#'     \itemize{
#'       \item For the number of features \eqn{g = 1, 2, \cdots, g_{max}}{g = 1, 2,
#' ..., gmax}, choose \eqn{g} features that have the largest discriminatory
#' power (measured by the F-statistic in ANOVA):
#'         \itemize{
#'           \item For the fold \eqn{i} (\eqn{i = 1, 2, \cdots, k}{i = 1, 2, ..., k}):
#'            \itemize{
#'              \item
#' Train a LDA model without the \eqn{i}-th fold data, and predict with the
#' \eqn{i}-th fold for a proportion of correct predictions
#' \eqn{p_{gi}}{p[gi]};
#'            }
#'          }
#'       \item Average the \eqn{k} proportions to get the correct rate \eqn{p_g}{p[g]};
#'     }
#'   \item Determine the optimum number of features with the largest \eqn{p}.
#' }
#'
#' Note that \eqn{g_{max}} is set by \code{ani.options('nmax')} (i.e. the
#' maximum number of features we want to choose).
#'
#' @param data a data matrix containg the predictors in columns
#' @param cl a factor indicating the classification of the rows of \code{data}
#' @param k the number of folds
#' @param cex.rg the range of the magnification to be used to the points in the
#'   plot
#' @param col.av the two colors used to respectively denote rates of correct
#'   predictions in the i-th fold and the average rates for all k folds
#' @param ... arguments passed to \code{\link[graphics]{points}} to draw the
#'   points which denote the correct rate
#' @return A list containing \item{accuracy }{a matrix in which the element in
#'   the i-th row and j-th column is the rate of correct predictions based on
#'   LDA, i.e. build a LDA model with j variables and predict with data in the
#'   i-th fold (the test set) } \item{optimum }{the optimum number of features
#'   based on the cross-validation}
#' @author Yihui Xie <\url{http://yihui.name}>
#' @seealso \code{\link{kfcv}}, \code{\link{cv.ani}}, \code{\link[MASS]{lda}}
#' @references Maindonald J, Braun J (2007). \emph{Data Analysis and Graphics
#'   Using R - An Example-Based Approach}. Cambridge University Press, 2nd
#'   edition. pp. 400
#' @export
#' @example inst/examples/cv.nfeaturesLDA-ex.R
cv.nfeaturesLDA = function(
  data = matrix(rnorm(600), 60), cl = gl(3, 20), k = 5, cex.rg = c(0.5, 3),
  col.av = c('blue', 'red'), ...
) {
  requireNamespace('MASS')
  nmax = min(ncol(data), ani.options('nmax'))
  cl = as.factor(cl)
  dat = data.frame(data, cl)
  N = nrow(dat)
  n = sample(N)
  dat = dat[n, ]
  kf = cumsum(c(1, kfcv(k, N)))
  aovF = function(x, cl) {
    qr.obj <- qr(model.matrix(~cl))
    qty.obj <- qr.qty(qr.obj, x)
    tab <- table(factor(cl))
    dfb <- length(tab) - 1
    dfw <- sum(tab) - dfb - 1
    ms.between <- apply(qty.obj[2:(dfb + 1), , drop = FALSE]^2, 2, sum)/dfb
    ms.within <- apply(qty.obj[-(1:(dfb + 1)), , drop = FALSE]^2, 2, sum)/dfw
    Fstat <- ms.between/ms.within
  }
  acc = matrix(nrow = k, ncol = nmax)
  loc = cbind(rep(1:nmax, each = k), rep(1:k, nmax))
  op = par(mfrow = c(1, 2))
  for (j in 1:nmax) {
    for (i in 2:(k + 1)) {
      dev.hold()
      idx = kf[i - 1]:(kf[i] - 1)
      trdat = dat[-idx, ]
      slct = order(aovF(
        as.matrix(trdat[, -ncol(trdat)]), trdat[, ncol(trdat)]
      ), decreasing = TRUE) <= j
      fit = MASS::lda(as.formula(paste(
        colnames(dat)[ncol(dat)], '~', paste(colnames(dat)[-ncol(dat)][slct], collapse = '+')
      )), data = dat)
      pred = predict(fit, dat[idx, ], dimen = 2)
      acc[i - 1, j] = mean(dat[idx, ncol(dat)] == pred$class)
      plot(
        1, xlim = c(1, nmax), ylim = c(0, k), type = 'n', ylab = 'Fold',
        xlab = 'Number of Features', yaxt = 'n', panel.first = grid()
      )
      axis(2, 1:k)
      axis(2, 0, expression(bar(p)))
      if ((j - 1) * k + i - 1 < nmax * k)
        text(matrix(loc[-(1:((j - 1) * k + i - 1)), ], ncol = 2), '?')
      points(matrix(loc[1:((j - 1) * k + i - 1), ], ncol = 2),
             cex = c(acc)^2 * diff(cex.rg) + min(cex.rg), col = col.av[1], ...)
      points(
        1:nmax, rep(0, nmax), col = col.av[2], ...,
        cex = apply(acc, 2, mean, na.rm = TRUE) * diff(cex.rg) + min(cex.rg)
      )
      styl.pch = as.integer(dat[idx, ncol(dat)])
      styl.col = 2 - as.integer(dat[idx, ncol(dat)] == pred$class)
      plot(pred$x, pch = styl.pch, col = styl.col)
      legend('topright', legend = c('correct', 'wrong'), fill = 1:2, bty = 'n', cex = 0.8)
      legend('bottomleft', legend = levels(dat[idx, ncol(dat)])[unique(styl.pch)],
             pch = unique(styl.pch), bty = 'n', cex = 0.8)
      ani.pause()
    }
  }
  par(op)
  rownames(acc) = paste('Fold', 1:k, sep = '')
  colnames(acc) = 1:nmax
  nf = which.max(apply(acc, 2, mean))
  names(nf) = NULL
  invisible(list(accuracy = acc, optimum = nf))
}
