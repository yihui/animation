\name{ani.start}
\alias{ani.start}
\title{ Start the generation of an HTML animation page }
\description{
  Copy JavaScript file \file{FUN.js} and CSS file \file{ANI.css} to the same directory as the HTML animation page, create a directory \file{images} and open a graphics device in this directory (the device is specified as \code{ani.dev} in \code{\link{ani.options}}). The prompt of the current R session is modified (by default \code{ANI> }).
}
\usage{
ani.start(...)
}
\arguments{
  \item{\dots}{ arguments passed to \code{\link{ani.options}} to set animation parameters }
}
\value{
None (invisible `\code{NULL}').
}
\author{Yihui Xie}
\note{ 
After calling \code{\link{ani.start}}, either animation functions in this package or R script of your own can be used to generate \& save animated pictures using proper graphics devices (specified as \code{ani.dev} in \code{\link{ani.options}}), then watch your animation by \code{\link{ani.stop}()}.

Note that former image files in the directory \file{images} will be removed.
}
\seealso{ \code{\link{ani.options}}, \code{\link{ani.stop}} }
\references{
\url{http://animation.yihui.name/animation:create_html_animation_page}
}
\examples{
\dontrun{
 
# save the animation in HTML pages and auto-browse it 
ani.options(ani.width = 600, ani.height = 500, interval = 0.2)
ani.start()
boot.iid()
ani.stop()

}
}
\keyword{ utilities }

