\name{iBUGS}
\alias{iBUGS}
\title{
An Intelligent Interface to WinBUGS/OpenBUGS
}
\description{
Create a GUI by \pkg{gWidgetsRGtk2} and all options for \pkg{R2WinBUGS} can be set in the GUI. The letter \sQuote{i} can be interpreted as \sQuote{\bold{i}ntelligent} or \sQuote{\bold{i}nterface} -- depends on what you think.
}
\usage{
iBUGS()
}
\details{
\pkg{iBUGS} will try to find the directories of WinBUGS/OpenBUGS in your system and use them when calling \code{\link[R2WinBUGS]{bugs}} in \pkg{R2WinBUGS}. For most Windows users, this search will succeed, unless WinBUGS/OpenBUGS were not installed in the default directory.

\pkg{iBUGS} will also try to get the data object names from the current R session and guess the parameter names in a BUGS model. Click the \dQuote{Preference} button and you will see the lists of names. If it failed to figure out all the parameter names, you may also double-click the list box and manually add names to the list.

More intelligence to be added...
}
\value{
Invisible \code{NULL}.
}
\author{
Yihui Xie <\url{http://yihui.name}>
}
\seealso{
\code{\link[R2WinBUGS]{bugs}}, \code{\link{bugs.options}}
}
\examples{
\dontrun{
iBUGS()

}
}
\keyword{ utilities }
