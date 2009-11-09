\name{highlight.def}
\alias{highlight.def}
\title{ Create R definition file for the software Highlight }
\description{
  The default definition file for R in Highlight is incomplete, and this function is to dynamically generate such a file according to packages in the search path. 
}
\usage{
highlight.def(file = "r.lang")
}
\arguments{
  \item{file}{ the path of the output definition file. }
}
\details{
  First all the functions are listed out by \code{\link[base]{ls}}; then some constants and operators are removed from this long list; at last these characters are written into the \file{file}. 
}
\value{
None. 
}
\references{ Highlight by Andre Simon: \url{http://www.andre-simon.de/} }
\author{ Yihui Xie <\url{http://yihui.name}> }

\seealso{ \code{\link[base]{ls}}, \code{\link[base]{cat}} }
\examples{
# generate the definition file in getwd() 
highlight.def()

# include functions in package 'animation'
library(animation) 
highlight.def()
 
}
\keyword{ IO }

