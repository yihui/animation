\name{g.brownian.motion}
\alias{g.brownian.motion}
\title{Brownian Motion using Google Visualization API}
\usage{
g.brownian.motion(p = 20, start = 1900, digits = 14, file = file.path(ani.options("outdir"), 
    ani.options("htmlfile")), width = 800, height = 600)
}
\arguments{
  \item{p}{number of points}

  \item{start}{start ``year''; it has no practical meaning
  in this animation but it's the required by the Google
  gadget}

  \item{digits}{the precision to round the numbers}

  \item{file}{the file name}

  \item{width,height}{width and height of the animation}
}
\value{
  \code{NULL}. An HTML page will be opened as the side
  effect.
}
\description{
  We can use R to generate random numbers from the Normal
  distribution and write them into an HTML document, then
  the Google Visualization gadget ``motionchart'' will
  prepare the animation for us (a Flash animation with
  several buttons).
}
\note{
  The number of frames is controlled by
  \code{ani.options("nmax")} as usual.

  Due to the ``security settings'' of Adobe Flash player,
  you might not be able to view the generated Flash
  animation locally, i.e. using an address like
  \url{file:///C:/Temp/index.html}. In this case, you can
  upload the HTML file to a webserver and use the http
  address to view the Flash file.
}
\examples{
oopt = ani.options(htmlfile = "BM-motion-chart.html")

g.brownian.motion(15, digits = 2, width = 600, height = 500)

unlink(file.path(ani.options("outdir"), ani.options("htmlfile")))

ani.options(oopt)
}
\author{
  Yihui Xie <\url{http://yihui.name}>
}
\references{
  \url{http://code.google.com/apis/visualization/}

  \url{http://yihui.name/en/2008/11/brownian-motion-using-google-visualization-api-and-r/}
}
\seealso{
  \code{\link{brownian.motion}}, \code{\link{BM.circle}},
  \code{\link[stats]{rnorm}}
}
\keyword{dynamic}
\keyword{IO}
