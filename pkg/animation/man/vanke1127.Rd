\name{vanke1127}
\alias{vanke1127}
\docType{data}
\title{
Stock prices of Vanke Co., Ltd on 2009/11/27
}
\description{
This is a sample of stock prices of the Vanke Co., Ltd on 2009/11/27.
}
\usage{data(vanke1127)}
\format{
  A data frame with 2831 observations on the following 2 variables.
  \describe{
    \item{\code{time}}{POSIXt: the time corresponding to stock prices}
    \item{\code{price}}{a numeric vector: stock prices}
  }
}
\source{
This data can be obtained from most stock websites.
}
\examples{
data(vanke1127)
with(vanke1127, {
    tab.price = table(price)
    plot(as.numeric(names(tab.price)), tab.price, type = "h", 
        xlab = "price", ylab = "frequency")
}) 

\dontrun{
ani.options(interval = 0.5, loop = FALSE)

with(vanke1127, {
    ## a series of HTML animations with different time spans
    ani.start(title = "Prices changing along with time interval 15 min")
    price.ani(price, time, lwd = 2)
    ani.stop()
    
    ani.start(title = "Prices changing along with time interval 30 min")
    price.ani(price, time, span = 30 * 60, lwd = 3)
    ani.stop()
    
    ani.start(title = "Prices changing along with time interval 5 min")
    price.ani(price, time, span = 5 * 60, lwd = 2)
    ani.stop()
    
    ## GIF animation
    saveMovie(price.ani(price, time, lwd = 2), interval = 1, 
        moviename = "price", loop = 1)
}) 
}
}
\keyword{datasets}
