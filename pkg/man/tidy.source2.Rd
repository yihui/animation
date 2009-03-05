\name{tidy.source2}
\alias{tidy.source2}
\title{ `Tidy up' R Code and Preserve Comments}
\description{
  This function differs with \code{\link{tidy.source}} merely in this aspect: it preserves comments in complete lines.
}
\usage{
tidy.source2(source = "clipboard", ...)
}
\arguments{
  \item{source}{ a string: location of the source code }
  \item{\dots}{ other arguments passed to \code{\link[base:cat]{cat}}, e.g. \code{file} }
}
\details{
  This function helps the user to tidy up his source code in a sense that necessary indents and spaces will be added, etc. See \code{\link[base:parse]{parse}}. Comments which occupy complete lines will be preserved, but those mixed with code lines will be deleted.
}
\value{
None (invisible `\code{NULL}'). `Clean' code will be returned to the console unless the output is redirected by \code{\link[base]{sink}}. 
}

\author{ Yixuan Qiu and Yihui Xie }
\references{\url{http://animation.yihui.name/animation:misc\#tidy_up_r_source}}
\seealso{ \code{\link[base:parse]{parse}}, \code{\link[base:cat]{cat}}, \code{\link{tidy.source}} }
\examples{
## tidy up the source code of image demo 
x = file.path(system.file(package = "graphics"), "demo", "image.R") 
# to console 
tidy.source2(x)
# try tidy.source(x) to see the difference
# to a file
tidy.source2(x, file = tempfile()) 
## check the original code here and see the difference 
file.show(x)

## if you've copied R code into the clipboard 
\dontrun{
tidy.source2("clipboard")}
}

\keyword{ IO }

