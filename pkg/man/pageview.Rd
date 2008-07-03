\name{pageview}
\alias{pageview}
\docType{data}
\title{ Data of page view from Sep 21, 2007 for Yihui's website}
\description{
  Page view data for Yihui's website from Sep 21, 2007 to a recent date. 
}
\usage{data(pageview)}
\format{
  A data frame with 73 observations on the following 5 variables.
  \describe{
    \item{\code{day}}{Date starts from Sep 21, 2007 to a recent date.}
    \item{\code{visits}}{number of visits: a new visit is defined as each new \emph{incoming visitor} (viewing or browsing a page) who was not connected to the site during last \emph{60 min}.}
    \item{\code{pages}}{number of times a \emph{page} of the site is viewed (sum for all visitors for all visits).
    This piece of data differs from ``files'' in that it counts only HTML pages and excludes images and other files.}
    \item{\code{files}}{number of times a \emph{page, image, file} of the site is viewed or downloaded by someone.}
    \item{\code{bandwidth}}{amount of data downloaded by all \emph{pages}, \emph{images} and \emph{files} within the site (units in MegaBytes).}
  }
}
\details{
  The data is collected by Awstats for the website \url{http://www.yihui.name}. 
}
\source{
  \url{http://www.yihui.name/cgi-bin/awstats/awstats.pl?month=10&year=2007&output=main&config=yihuiname&framename=index} 
}
\examples{
data(pageview)
plot(pageview[,1:2], type = "b", col = "red", 
  main = "Number of Visits in Yihui's Web")
# partial auto-correlation 
pacf(pageview$visits) 
}
\keyword{datasets}
