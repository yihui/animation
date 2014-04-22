\name{moving.block}
\alias{moving.block}
\title{Cycle through an R object and plot each subset of elements}
\usage{
moving.block(dat = runif(100), block, FUN, ...)
}
\arguments{
  \item{dat}{a numeric vector or two-column matrix}

  \item{block}{block length (i.e. how many elements are to
  be plotted in each step)}

  \item{FUN}{a plot function to be applied to the subset of
  data}

  \item{\dots}{other arguments passed to \code{FUN}}
}
\value{
\code{NULL}
}
\description{
For a long numeric vector or matrix (or data frame), we can
plot only a subset of its elements to take a closer look at
its structure. With a moving ``block'' from the beginning
to the end of a vector or matrix or any R objects to which
we can apply \code{subset}, all elements inside the block
are plotted as a line or scatter plot or any customized
plots.
}
\details{
For a vector, the elments from \code{i + 1} to \code{i +
block} will be plotted in the i-th step; similarly for a
matrix or data frame, a (scatter) plot will be created from
the \code{i + 1}-th row to \code{i + block}-th row.

However, this function is not limited to scatter plots or
lines -- we can customize the function \code{FUN} as we
wish.
}
\note{
There will be \code{ani.options('nmax')} image frames
created in the end. Ideally the relationship between
\code{ani.options('nmax')} and \code{block} should follow
this equality: \code{block = length(x) -
ani.options('nmax') + 1} (replace \code{length(x)} with
\code{nrow(x)} when \code{x} is a matrix). The function
will compute \code{block} according to the equality by
default if no block length is specified.

The three arguments \code{dat}, \code{i} and \code{block}
are passed to \code{FUN} in case we want to customize the
plotting function, e.g. we may want to annonate the x-axis
label with \code{i}, or we want to compute the mean value
of \code{dat[i + 1:block]}, etc. See the examples below to
learn more about how to make use of these three arguments.
}
\examples{
## (1) Brownian motion
#  block length: 101 (i.e. 300-200+1)
oopt = ani.options(nmax = ifelse(interactive(), 200, 2), interval = 0.1)
#  plot y = dat against x = i + 1:block
#  customize xlab and ylab with 'i' and 'block'
#  restrict ylim using the range of 'dat'
moving.block(
  dat = cumsum(rnorm(300)),
  FUN = function(..., dat = dat, i = i, block = block) {
    plot(..., x = i + 1:block, xlab = sprintf('block length = \%d', block),
         ylim = range(dat), ylab = sprintf('x[\%s:\%s]', i + 1, i + block))
  }, type = 'o', pch = 20)


## (2) Word counts of Hu's speech (block = 10; length(HuSpeech) = 75)
#  see any pattern in the President's speech?
ani.options(nmax = ifelse(interactive(), 66, 2), interval = 0.5)
moving.block(
  dat = HuSpeech,
  FUN = function(..., dat = dat, i = i, block = block) {
    plot(..., x = i + 1:block, xlab = 'paragraph index', ylim = range(dat),
         ylab = sprintf('HuSpeech[\%s:\%s]', i + 1, i + block))
  }, type = 'o', pch = 20)


## (3) sunspot data: observe the 11-year cycles
#  block = 11 years x 12 months/year = 132
#  set interval greater than 0 if your computer really rocks!
ani.options(nmax = ifelse(interactive(), 2857, 2), interval = 0)
spt.att = tsp(sunspot.month)
#  the time index (we need it to correctly draw the ticks of x-axis)
ts.idx = seq(spt.att[1], spt.att[2], 1/spt.att[3])
moving.block(
  dat = sunspot.month, block = 132,
  FUN = function(..., dat = dat, i = i, block = block) {
    plot(..., x = ts.idx[i + 1:block], xlab = sprintf('block length = \%d', block),
         ylim = range(dat), ylab = sprintf('sunspot.month[\%s:\%s]', i + 1, i + block))
  }, type = 'o', pch = 20)


## (4) earth quake: order the data by 'depth' first
#  see how the locations change as 'depth' increases
ani.options(nmax = ifelse(interactive(), 900, 2), interval = 0.01)
#  compute the mean depth for each block of data
moving.block(
  quakes[order(quakes$depth), c('long', 'lat')],
  FUN = function(..., dat = dat, i = i, block = block) {
    plot(..., xlab = sprintf('\%s[\%s:\%s]', colnames(dat)[1], i + 1, i + block),
         ylab = sprintf('\%s[\%s:\%s]', colnames(dat)[2], i + 1, i + block),
         xlim = range(dat[, 1]), ylim = range(dat[, 2]),
         main = sprintf('Mean Depth = \%.3f', mean(sort(quakes$depth)[i + 1:block])))
  }, pch = 20, col = rgb(0, 0, 0, 0.5))

ani.options(oopt)

}
\author{
Yihui Xie
}

