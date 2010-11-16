\name{ani.news}
\alias{ani.news}
\title{ Read news of package `animation' }
\description{
  Read news and changes in the package `animation'. 
}
\usage{
ani.news(...)
}
\arguments{
  \item{\dots}{ arguments passed to \code{\link[base]{file.show}}. }
}
\details{
  This function just makes use of \code{\link[base]{file.show}} to display a file \file{NEWS} in this package. 
}
\value{
None (invisible `\code{NULL}').
}
\author{ Yihui Xie }
\seealso{ \code{\link[base]{file.show}} }
\examples{
ani.news() 
}
\keyword{ IO }

