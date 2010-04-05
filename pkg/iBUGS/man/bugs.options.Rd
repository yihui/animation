\name{bugs.options}
\alias{bugs.options}
\title{
Set or Query Options to Run WinBUGS/OpenBUGS
}
\description{
Set or query options in the bugs function.
}
\usage{
bugs.options(...)
}
\arguments{
  \item{\dots}{
any options can be defined, using \sQuote{name = value} or by passing a list of such tagged values. See the examples below.
}
}
\value{
A list containing all the options when the query parameter was empty; or the option value when a single parameter was queried. The old option list will be returned if any new options were set.
}
\author{
Yihui Xie <\url{http://yihui.name}>
}
\note{
The only option that is not in \code{\link[R2WinBUGS]{bugs}} is \sQuote{model.name} which specifies the R object name to be used to store the returned values from \code{\link[R2WinBUGS]{bugs}}.
}
\seealso{
\code{\link[R2WinBUGS]{bugs}}
}
\examples{
\dontrun{
## list all the options
bugs.options()

## set options
bugs.options(n.chains = 1, n.iter = 10000)

## all these can be set via the GUI: iBUGS()

}
}
\keyword{ misc }

