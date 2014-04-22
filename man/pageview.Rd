\docType{data}
\name{pageview}
\alias{pageview}
\title{Page views from Sep 21, 2007 to Dec 2, 2007 of Yihui's website}
\format{A data frame with 73 observations on the following 5 variables.
  \describe{ \item{day}{Date starts from Sep 21, 2007 to Dec 2, 2007.}
  \item{visits}{number of visits: a new visit is defined as each new
  \emph{incoming visitor} (viewing or browsing a page) who was not connected
  to the site during last \emph{60 min}.}  \item{pages}{number of times a
  \emph{page} of the site is viewed (sum for all visitors for all visits).
  This piece of data differs from ``files'' in that it counts only HTML pages
  and excludes images and other files.} \item{files}{number of times a
  \emph{page, image, file} of the site is viewed or downloaded by someone.}
  \item{bandwidth}{amount of data downloaded by all \emph{pages},
  \emph{images} and \emph{files} within the site (units in MegaBytes).} }}
\source{
\url{http://yihui.name}
}
\description{
The data is collected by Awstats for the website
\url{http://yihui.name}.
}
\examples{
plot(pageview[,1:2], type = 'b', col = 'red',
  main = "Number of Visits in Yihui's Web")
## partial auto-correlation
pacf(pageview$visits)
}

