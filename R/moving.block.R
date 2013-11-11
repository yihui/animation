#' Cycle through an R object and plot each subset of elements
#'
#' For a long numeric vector or matrix (or data frame), we can plot only a
#' subset of its elements to take a closer look at its structure. With a moving
#' ``block'' from the beginning to the end of a vector or matrix or any R
#' objects to which we can apply \code{subset}, all elements inside the block
#' are plotted as a line or scatter plot or any customized plots.
#'
#' For a vector, the elments from \code{i + 1} to \code{i + block} will be
#' plotted in the i-th step; similarly for a matrix or data frame, a (scatter)
#' plot will be created from the \code{i + 1}-th row to \code{i + block}-th row.
#'
#' However, this function is not limited to scatter plots or lines -- we can
#' customize the function \code{FUN} as we wish.
#'
#' @param dat a numeric vector or two-column matrix
#' @param block block length (i.e. how many elements are to be plotted in each
#'   step)
#' @param FUN a plot function to be applied to the subset of data
#' @param \dots other arguments passed to \code{FUN}
#' @return \code{NULL}
#' @note There will be \code{ani.options('nmax')} image frames created in the
#'   end. Ideally the relationship between \code{ani.options('nmax')} and
#'   \code{block} should follow this equality: \code{block = length(x) -
#'   ani.options('nmax') + 1} (replace \code{length(x)} with \code{nrow(x)} when
#'   \code{x} is a matrix). The function will compute \code{block} according to
#'   the equality by default if no block length is specified.
#'
#'   The three arguments \code{dat}, \code{i} and \code{block} are passed to
#'   \code{FUN} in case we want to customize the plotting function, e.g. we may
#'   want to annonate the x-axis label with \code{i}, or we want to compute the
#'   mean value of \code{dat[i + 1:block]}, etc. See the examples below to learn
#'   more about how to make use of these three arguments.
#' @author Yihui Xie
#' @export
#' @example inst/examples/moving.block-ex.R
moving.block = function(dat = runif(100), block, FUN, ...) {
  nmax = ani.options('nmax')
  n = ifelse(is.null(dim(dat)), length(dat), nrow(dat))
  if (missing(block))
    block = n - ani.options('nmax') + 1
  if (block < 1)
    stop("block length less than 1; please set smaller ani.options('nmax') or larger 'block'")
  if (block != n - nmax + 1) {
    warning(sprintf("block length is too %s; try to adjust 'block' or ani.options('nmax')",
                    ifelse(block > n - nmax + 1, 'long', 'short')))
  }
  if (missing(FUN))
    FUN = function(..., dat = dat, i = i, block = block) {
      plot(...)
    }
  for (i in seq_len(nmax) - 1) {
    dev.hold()
    FUN(subset(dat, seq_len(n) %in% (i + 1:block)), dat = dat,
        i = i, block = block, ...)
    ani.pause()
  }
}



