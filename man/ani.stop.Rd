\name{ani.stop}
\alias{ani.stop}
\title{ Write the HTML animation page}
\description{
  Write the HTML animation page, restore previous options such as \code{prompt} and close the graphical device opened in \code{\link{ani.start}}.
}
\usage{
ani.stop()
}
\value{
None (invisible `\code{NULL}'); a string will be printed in the console indicating where is the HTML file.
}
\author{ Yihui Xie  <\url{http://yihui.name}>}
\note{
The content of the HTML file completely depends on the parameters set in \code{\link{ani.options}}.
}
\seealso{ \code{\link{ani.options}}, \code{\link{ani.start}} }
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