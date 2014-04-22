\docType{data}
\name{vanke1127}
\alias{vanke1127}
\title{Stock prices of Vanke Co., Ltd on 2009/11/27}
\format{A data frame with 2831 observations on the following 2 variables.
  \describe{ \item{time}{POSIXt: the time corresponding to stock prices}
  \item{price}{a numeric vector: stock prices} }}
\source{
This data can be obtained from most stock websites.
}
\description{
This is a sample of stock prices of the Vanke Co., Ltd on
2009/11/27.
}
\examples{
tab.price = table(vanke1127$price)
plot(as.numeric(names(tab.price)), as.numeric(tab.price), type = 'h',
     xlab = 'price', ylab = 'frequency')

oopt = ani.options(interval = 0.5, loop = FALSE, title='Stock price of Vanke')

## a series of HTML animations with different time spans
saveHTML({
  price.ani(vanke1127$price, vanke1127$time, lwd = 2)
}, img.name = 'vanke_a', description = 'Prices changing along with time interval 15 min')

saveHTML({
  price.ani(vanke1127$price, vanke1127$time, span = 30 * 60, lwd = 3)
}, img.name='vanke_b', description = 'Prices changing along with time interval 30 min')

saveHTML({
  price.ani(vanke1127$price, vanke1127$time, span = 5 * 60, lwd = 2)
}, img.name='vanke_c', description = 'Prices changing along with time interval 5 min')

## GIF animation
saveGIF(price.ani(vanke1127$price, vanke1127$time, lwd = 2),
        movie.name = 'price.gif', loop = 1)

ani.options(oopt)
}

