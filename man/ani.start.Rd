\name{ani.start}
\alias{ani.start}
\title{Start the generation of an HTML animation page}
\usage{
ani.start(...)
}
\arguments{
  \item{\dots}{arguments passed to
  \code{\link{ani.options}} to set animation parameters}
}
\value{
  None (invisible \code{NULL}).
}
\description{
  This function copies JavaScript file \file{FUN.js} and
  CSS file \file{ANI.css} to the same directory as the HTML
  animation page, create a directory \file{images} and open
  a graphics device in this directory (the device is
  specified as \code{ani.dev} in
  \code{\link{ani.options}}). The prompt of the current R
  session is modified (by default \code{ANI> }).
}
\note{
  After calling \code{\link{ani.start}}, either animation
  functions in this package or R script of your own can be
  used to generate & save animated pictures using proper
  graphics devices (specified as \code{ani.dev} in
  \code{\link{ani.options}}), then watch your animation by
  \code{\link{ani.stop}()}.

  Note that existing image files in the directory
  \code{ani.options('imgdir')} will be removed.
}
\examples{
## save the animation in HTML pages and auto-browse it
oopt = ani.options(nmax = 20, ani.width = 600, ani.height = 500, interval = 0.2)
ani.start()
boot.iid()
ani.stop()
ani.options(oopt)
}
\author{
  Yihui Xie <\url{http://yihui.name}>
}
\references{
  \url{http://animation.yihui.name/animation:create_html_animation_page}
}
\seealso{
  \code{\link{saveHTML}} (the recommended way to create
  HTML pages), \code{\link{ani.options}},
  \code{\link{ani.stop}}
}
\keyword{utilities}
