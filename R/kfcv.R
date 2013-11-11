#' Sample sizes for k-fold cross-validation
#'
#' Compute sample sizes for \eqn{k}-fold cross-validation.
#'
#' If N/k is an integer, the sample sizes are k `N/k's (N/k, N/k, ...),
#' otherwise the remainder will be allocated to each group as `uniformly' as
#' possible, and at last these sample sizes will be permuted randomly.
#' @param k number of groups.
#' @param N total sample size.
#' @return A vector of length \code{k} containing \eqn{k} sample sizes.
#' @author Yihui Xie
#' @seealso \code{\link{cv.ani}}
#' @export
#' @examples
#' ## divisible
#' kfcv(5, 25)
#'
#' ## not divisible
#' kfcv(10,77)
kfcv <- function(k, N) {
  if (k > N) {
    warning("'k' is larger than 'N'!")
    return(rep(1, N))
  } else {
    if (N%%k == 0) rep(N%/%k, k) else
      sample(c(rep(1, N%%k), rep(0, k - N%%k)) + rep(N%/%k, k))
  }
}
