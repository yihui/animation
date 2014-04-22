\name{sample.ratio}
\alias{sample.ratio}
\title{Demonstrate the ratio estimation in sampling survey}
\usage{
sample.ratio(X = runif(50, 0, 5), R = 1, Y = R * X + rnorm(X),
  size = length(X)/2, p.col = c("blue", "red"), p.cex = c(1, 3),
  p.pch = c(20, 21), m.col = c("black", "gray"), legend.loc = "topleft",
  ...)
}
\arguments{
  \item{X}{the X variable (ancillary)}

  \item{R}{the population ratio Y/X}

  \item{Y}{the Y variable (whose mean we what to estimate)}

  \item{size}{sample size}

  \item{p.col,p.cex,p.pch}{point colors, magnification and
  symbols for the population and sample respectively}

  \item{m.col}{color for the horizontal line to denote the
  sample mean of Y}

  \item{legend.loc}{legend location: topleft, topright,
  bottomleft, bottomright, ... (see \code{\link{legend}})}

  \item{\dots}{other arguments passed to
  \code{\link{plot.default}}}
}
\value{
A list containing \item{X}{X population} \item{Y}{Y
population} \item{R}{population ratio} \item{r}{ratio
calculated from samples} \item{Ybar}{population mean of Y}
\item{ybar.simple}{simple sample mean of Y}
\item{ybar.ratio}{sample mean of Y via ratio estimation}
}
\description{
This function demonstrates the advantage of ratio
estimation when further information (ratio) about x and y
is available.
}
\details{
From this demonstration we can clearly see that the ratio
estimation is generally better than the simple sample
average when the ratio \bold{R} really exists, otherwise
ratio estimation may not help.
}
\examples{
oopt = ani.options(interval = 2, nmax = ifelse(interactive(), 50, 2))

## observe the location of the red line (closer to the population mean)
res = sample.ratio()

## absolute difference with the true mean
matplot(abs(cbind(res$ybar.ratio, res$ybar.simple) - res$Ybar), type = 'l')
legend('topleft', c('Ratio Estimation', 'Sample Average'),
       lty = 1:2, col = 1:2)

## if the ratio does not actually exist:
sample.ratio(X = rnorm(50), Y = rnorm(50))
## ratio estimation may not be better than the simple average


## HTML animation page
saveHTML({
  par(mar = c(4, 4, 1, 0.5), mgp = c(2, 1, 0))
  ani.options(interval = 2, nmax = ifelse(interactive(), 50, 2))
  sample.ratio()
}, img.name='sample.ratio',htmlfile='sample.ratio.html',
         ani.height = 400, ani.width = 500,
         title = 'Demonstration of the Ratio Estimation',
         description = c('Estimate the mean of Y, making use of the ratio',
                         'Y/X which will generally improve the estimation.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{sample}}, \code{\link{sample.simple}},
\code{\link{sample.cluster}}, \code{\link{sample.strat}},
\code{\link{sample.system}}
}

