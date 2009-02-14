\name{g.brownian.motion}
\alias{g.brownian.motion}
\title{ Brownian Motion Using Google Visualization API }
\description{
  We can use R to generate random numbers from the Normal distribution and write them into an HTML document, then the Google Visualization gadget ``motionchart'' will prepare the animation for us (a Flash animation with several buttons).
}
\usage{
g.brownian.motion(p = 20, start = 1900, digits = 14, 
    file = "brownian.motion.html", width = 800, height = 600)
}
\arguments{
  \item{p}{ number of points }
  \item{start}{ start "year"; it has no practical meaning in this animation but it's the required by the Google gadget }
  \item{digits}{ the precision to round the numbers }
  \item{file}{ the file name }
  \item{width, height}{ width and height of the animation }
}
\value{
  \code{NULL}. An HTML page will be opened as the side effect.
}
\references{ 
\url{http://code.google.com/apis/visualization/}

\url{http://www.yihui.name/en/post/57.htm}
}
\author{ Yihui Xie }
\note{
  The number of frames is controlled by \code{ani.options("nmax")} as usual. 
}
\seealso{ \code{\link{brownian.motion}}, \code{\link{BM.circle}}, \code{\link[stats:Normal]{rnorm}} }
\examples{
\dontrun{
g.brownian.motion(15, digits = 2, width = 600, 
    height = 500) 
}
}
\keyword{ dynamic }
\keyword{ IO }
