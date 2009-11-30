\name{price.ani}
\alias{price.ani}
\title{
Demonstrate Stock Prices in Animation
}
\description{
This function can display the frequencies of stock prices in a certain time span with the span changing.
}
\usage{
price.ani(price, time, time.begin = min(time), span = 15 * 60, 
    ..., xlab = "price", ylab = "frequency", xlim, ylim, main)
}
\arguments{
  \item{price}{
stock prices
}
  \item{time}{
time corresponding to prices
}
  \item{time.begin}{
the time for the animation to begin (default to be the minimum \code{time})
}
  \item{span}{
time span (unit in seconds; default to be 15 minutes)
}
  \item{\dots}{
other arguments passed to \code{\link[graphics]{plot}}
}
  \item{xlab,ylab,xlim,ylim,main}{
they are passed to \code{\link[graphics]{plot}} with reasonable default values
}
}
\value{
invisible \code{NULL}
}
\author{
Yihui Xie <\url{http://yihui.name}>
}
\examples{
## see more examples in ?vanke1127
data(vanke1127)
with(vanke1127, {
    price.ani(price, time, lwd = 2)
})
}
\keyword{ dynamic }
\keyword{ hplot }
