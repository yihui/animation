\name{price.ani}
\alias{price.ani}
\title{Demonstrate stock prices in animations}
\usage{
price.ani(price, time, time.begin = min(time), span = 15 * 60, ...,
  xlab = "price", ylab = "frequency", xlim, ylim, main)
}
\arguments{
  \item{price}{stock prices}

  \item{time}{time corresponding to prices}

  \item{time.begin}{the time for the animation to begin
  (default to be the minimum \code{time})}

  \item{span}{time span (unit in seconds; default to be 15
  minutes)}

  \item{\dots}{other arguments passed to
  \code{\link{plot}}}

  \item{xlab,ylab,xlim,ylim,main}{they are passed to
  \code{\link{plot}} with reasonable default values}
}
\value{
invisible \code{NULL}
}
\description{
This function can display the frequencies of stock prices
in a certain time span with the span changing.
}
\examples{
## see more examples in ?vanke1127
saveHTML({
  price.ani(vanke1127$price, vanke1127$time, lwd = 2)
}, img.name='vanke1127', htmlfile='vanke1127.html',
         title='Stock prices of Vanke',
         description=c('Barplots', 'of the stock prices of Vanke Co. Ltd', 'on 2009/11/27'))
}
\author{
Yihui Xie
}

