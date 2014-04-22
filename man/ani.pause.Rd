\name{ani.pause}
\alias{ani.pause}
\title{Pause for a while and flush the current graphical device}
\usage{
ani.pause(interval = ani.options("interval"))
}
\arguments{
  \item{interval}{a time interval to pause (in seconds)}
}
\value{
Invisible \code{NULL}.
}
\description{
If this function is called in an interactive graphics
device, it will pause for a time interval (by default
specified in \code{\link{ani.options}('interval')}) and
flush the current device; otherwise it will do nothing.
}
\examples{
## pause for 2 seconds
oopt = ani.options(interval = 2)

for (i in 1:5) {
  plot(runif(10), ylim = c(0, 1))
  ani.pause()
}

ani.options(oopt)

## see demo('Xmas2', package = 'animation') for another example
}
\author{
Yihui Xie
}
\seealso{
\code{\link{dev.interactive}}, \code{\link{Sys.sleep}},
\code{\link{dev.flush}}
}

