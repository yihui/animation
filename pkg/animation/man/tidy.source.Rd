\name{tidy.source}
\alias{tidy.source}
\title{ `Tidy up' R Code and Partially Preserve Comments}
\description{
  Actually this function has nothing to do with code optimization; it just returns parsed source code, but some comments can be preserved, which is different with \code{\link[base]{parse}}. See `Details'.
}
\usage{
tidy.source(source = "clipboard", keep.comment = TRUE, 
    keep.blank.line = FALSE, begin.comment, end.comment, ...)
}
\arguments{
  \item{source}{ a string: location of the source code }
  \item{keep.comment}{ logical value: whether to keep comments or not? }
  \item{keep.blank.line}{ logical value: whether to keep blank lines or not? }
  \item{begin.comment, end.comment}{ identifiers to mark the comments }
  \item{output}{ output to the console or a file using \code{\link[base]{cat}}? }
  \item{\dots}{ other arguments passed to \code{\link[base]{cat}}, e.g. \code{file} }
}
\details{
  This function helps the users to tidy up their source code in a sense that necessary indents and spaces will be added, etc. See \code{\link[base]{parse}}. But comments which are in single lines will be preserved if \code{keep.comment = TRUE} (inline comments will be removed).
  
  The method to preserve comments is to protect them as strings in disguised assignments: combine \code{end.comment} to the end of a comment line and 'assign' the whole line to \code{begin.comment}, so the comment line will not be removed when parsed. At last, we remove the identifiers \code{begin.comment} and \code{end.comment}.
}
\value{
A list with components
  \item{text.tidy}{The parsed code as a character vector.}
  \item{text.mask}{The code containing comments, which are masked in assignments.}
  \item{begin.comment, end.comment}{ identifiers used to mark the comments }
  
Note that 'clean' code will be printed in the console unless the output is redirected by \code{\link[base]{sink}}, and we can also write the clean code to a file. 
}

\author{ Yihui Xie }
\references{\url{http://animation.yihui.name/animation:misc\#tidy_up_r_source}}
\seealso{ \code{\link[base]{parse}}, \code{\link[base]{cat}} }
\examples{
## tidy up the source code of image demo 
x = file.path(system.file(package = "graphics"), "demo", "image.R") 
# to console 
tidy.source(x)
# to a file
f = tempfile()
tidy.source(x, keep.blank.line = TRUE, file = f) 
## check the original code here and see the difference 
file.show(x)
file.show(f)
## if you've copied R code into the clipboard 
\dontrun{
tidy.source("clipboard")}
}

\keyword{ IO }

