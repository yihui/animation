\name{least.squares}
\alias{least.squares}
\title{Demonstrate the least squares method}
\usage{
least.squares(x, y, n = 15, ani.type = c("slope", "intercept"), a, b,
  a.range, b.range, ab.col = c("gray", "black"), est.pch = 19,
  v.col = "red", v.lty = 2, rss.pch = 19, rss.type = "o", mfrow = c(1,
  2), ...)
}
\arguments{
  \item{x}{a numeric vector: the independent variable}

  \item{y}{a numeric vector: the dependent variable}

  \item{n}{the sample size: when x and y are missing, we
  use simulated values of y (\code{x = 1:n} and \code{y = a
  + b * x + rnorm(n)})}

  \item{ani.type}{\code{'slope'}: the slope is changing
  with the intercept fixed; \code{'intercept'}: intercept
  changing and slope fixed}

  \item{a,b}{the fixed intercept and slope; depending on
  \code{ani.type}, we only need to specify one of them;
  e.g. when \code{ani.type == 'slope'}, we need to specify
  the value of \code{a}}

  \item{a.range,b.range}{a vector of length 2 to define the
  range of the intercept and the slope; only one of them
  need to be specified; see above}

  \item{ab.col}{the colors of two lines: the real
  regression line and the moving line with either intercept
  or slope changing}

  \item{est.pch}{the point character of the 'estimated'
  values given \code{x}}

  \item{v.col,v.lty}{the color and line type of the vetical
  lines which demonstrate the residuals}

  \item{rss.pch,rss.type}{the point character and plot type
  of the residual plot}

  \item{mfrow}{defines the layout of the graph; see
  \code{\link{par}}}

  \item{...}{other parameters passed to \code{\link{plot}}
  to define the appearance of the scatterplot}
}
\value{
The value returned depends on the animation type.

If it is a slope animation, the value will be a list
containing \item{lmfit}{ the estimates of the intercept and
slope with \code{\link{lm}} } \item{anifit}{ the estimate
of the slope in the animation } If it is an intercept
animation, the second component of the above list will be
the estimate of the intercept.

Note the estimate will not be precise generally.
}
\description{
This is a simple demonstration of the meaning of least
squares in univariate linear regression.
}
\details{
With either the intercept or the slope changing, the lines
will be moving in the graph and corresponding residuals
will be plotted. We can finally see the best estimate of
the intercept and the slope from the residual plot.
}
\note{
\code{ani.options('nmax')} specifies the maximum number of
steps for the slope or intercept to move.
}
\examples{
par(mar = c(5, 4, 0.5, 0.1))
oopt = ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))

## default animation: with slope changing
least.squares()

## intercept changing
least.squares(ani.type = 'intercept')

## save the animation in HTML pages
saveHTML({
  ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))
  par(mar = c(4, 4, 0.5, 0.1), mgp = c(2, 0.5, 0), tcl = -0.3)
  least.squares()
}, img.name='least.squares',htmlfile='least.squares.html',
         ani.height = 450, ani.width = 600,
         title = 'Demonstration of Least Squares',
         description = c('We want to find an estimate for the slope',
                         'in 50 candidate slopes, so we just compute the RSS one by one. '))

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{lm}}
}

