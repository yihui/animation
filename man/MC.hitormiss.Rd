\name{MC.hitormiss}
\alias{MC.hitormiss}
\title{Hit or Miss Monte Carlo integration}
\usage{
MC.hitormiss(FUN = function(x) x - x^2, n = ani.options("nmax"), from = 0,
  to = 1, col.points = c("black", "red"), pch.points = c(20, 4), ...)
}
\arguments{
  \item{FUN}{the function to be integrated}

  \item{n}{number of points to be sampled from the
  Uniform(0, 1) distribution}

  \item{from,to}{the limits of integration}

  \item{col.points,pch.points}{colors and point characters
  for points which ``hit'' or ``miss'' the area under the
  curve}

  \item{\dots}{other arguments passed to
  \code{\link{points}}}
}
\value{
A list containing \item{x1}{ the Uniform random numbers
generated on x-axis} \item{x2}{ the Uniform random numbers
generated on y-axis} \item{y}{ function values evaluated at
\code{x1} } \item{n}{ number of points drawn from the
Uniform distribtion } \item{est}{ the estimated value of
the integral }
}
\description{
Integrate a function using the Hit-or-Miss Monte Carlo
algorithm.
}
\details{
We compute the proportion of points hitting the area under
the curve, and the integral can be estimated by the
proportion multiplied by the total area of the rectangle
(from xmin to xmax, ymin to ymax).
}
\note{
This function is for demonstration purpose only; the
integral might be very inaccurate when \code{n} is small.

\code{ani.options('nmax')} specifies the maximum number of
trials.
}
\examples{
oopt = ani.options(interval = 0.2, nmax = ifelse(interactive(), 100, 2))

## should be close to 1/6
MC.hitormiss()$est

## should be close to 1/12
MC.hitormiss(from = 0.5, to = 1)$est

## HTML animation page
saveHTML({
  ani.options(interval = 0.5, nmax = ifelse(interactive(), 100, 2))
  MC.hitormiss()
}, img.name='MC.hitormiss',htmlfile='MC.hitormiss.html',
         title = 'Hit or Miss Monte Carlo Integration',
         description = c('','Generate Uniform random numbers', 'and compute the proportion',
                         'of points under the curve.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\seealso{
\code{\link{integrate}}, \code{\link{MC.samplemean}}
}

