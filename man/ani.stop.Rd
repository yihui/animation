\name{ani.stop}
\alias{ani.stop}
\title{Write the HTML animation page}
\usage{
ani.stop()
}
\value{
  None (invisible \code{NULL}); a string will be printed in
  the console indicating where is the HTML file.
}
\description{
  Write the HTML animation page and restore previous
  options such as \code{prompt}; then close the graphical
  device opened in \code{\link{ani.start}}.
}
\note{
  The content of the HTML file completely depends on the
  parameters set in \code{\link{ani.options}}.
}
\examples{
## see help(ani.start)
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
  \code{\link{ani.start}}
}
\keyword{utilities}
