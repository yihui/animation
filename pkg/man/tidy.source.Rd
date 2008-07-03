\name{tidy.source}
\alias{tidy.source}
\title{ `Tidy up' R code }
\description{
  Actually this function has nothing to do with code optimization; it just returns parsed source code. 
}
\usage{
tidy.source(source = "clipboard", ...)
}
\arguments{
  \item{source}{ a string: location of the source code }
  \item{\dots}{ other arguments passed to \code{\link[base:cat]{cat}}, e.g. \code{file} }
}
\details{
  This function helps the user to tidy up his source code in a sense that necessary indents and spaces will be added, etc. See \code{\link[base:parse]{parse}}.
}
\value{
None (invisible `\code{NULL}'). `Clean' code will be returned to the console unless the output is redirected by `sink'. 
}

\author{ Yihui Xie }
\references{\url{http://animation.yihui.name/animation:misc\#tidy_up_r_source}}
\seealso{ \code{\link[base:parse]{parse}}, \code{\link[base:cat]{cat}} }
\examples{
## tidy up the source code of image demo 
x = file.path(system.file(package = "graphics"), "demo", "image.R") 
# to console 
tidy.source(x)
# to a file
tidy.source(x, file = tempfile()) 
## check the original code here and see the difference 
file.show(x)

## if you've copied R code into the clipboard 
\dontrun{
tidy.source("clipboard")}
}

\keyword{ IO }

