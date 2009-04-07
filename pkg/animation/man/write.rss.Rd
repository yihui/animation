\name{write.rss}
\alias{write.rss}
\title{ Create RSS feed from a CSV data file }
\description{
  An RSS feed is essentially just an XML file, thus the creation is easy just with \code{\link[base:cat]{cat}} to write some tags into a text file. The elments of an item in an RSS feed usually contains 'title', 'link', 'author', 'description', 'pubDate', 'guid', and 'category', etc, which are stored in the CSV data file.
}
\usage{
write.rss(file = "feed.xml", entry = "rss.csv", xmlver = "1.0", 
    rssver = "2.0", title = "What's New?", 
    link = "http://R.yihui.name", 
    description = "Animated Statistics Using R", 
    language = "en-us", copyright = "Copyright 2007, Yihui Xie", 
    pubDate = Sys.time(), lastBuildDate = Sys.time(), 
    docs = "http://R.yihui.name", 
    generator = "Function write.rss() in R package animation", 
    managingEditor = "xieyihui[at]gmail.com", 
    webMaster = "xieyihui[at]gmail.com", 
    maxitem = 10, ...)
}
\arguments{
  \item{file}{ the path of the output file (RSS feed); passed to \code{\link[base:cat]{cat}} }
  \item{entry}{ the input CSV file, containing elements for items in the RSS feed (with tag names in the header); \code{\link[utils:read.table]{read.csv}} }
  \item{xmlver}{ version of XML }
  \item{rssver}{ version of RSS }
  \item{title}{ The name of the channel. It's how people refer to your service. If you have an HTML website that contains the same information as your RSS file, the title of your channel should be the same as the title of your website. }
  \item{link}{ The URL to the HTML website corresponding to the channel. }
  \item{description}{ Phrase or sentence describing the channel. }
  \item{language}{ The language the channel is written in. }
  \item{copyright}{ Copyright notice for content in the channel. }
  \item{pubDate}{ The publication date for the content in the channel. }
  \item{lastBuildDate}{ The last time the content of the channel changed. }
  \item{docs}{ A URL that points to the documentation for the format used in the RSS file. }
  \item{generator}{ A string indicating the program used to generate the channel. }
  \item{managingEditor}{ Email address for person responsible for editorial content. }
  \item{webMaster}{ Email address for person responsible for technical issues relating to channel. }
  \item{maxitem}{ Maximum number of items to be written into the feed. }
  \item{\dots}{ other elements for the channel, e.g. image, cloud, etc. }
}
\details{
  The items of the RSS feed are stored in the file \file{entry}, and the many arguments above are just for the channel information. 
}
\value{
None. Only a message indicating where the RSS was created. 
}
\references{ Read \url{http://cyber.law.harvard.edu/rss/rss.html} for the specification of RSS. }
\author{ Yihui Xie }
\note{ 
As the argument \code{file} is passed to \code{\link[base:cat]{cat}}, you may specify it as an empty string \code{""} so that the result will be printed to the standard output connection, the console unless redirected by 'sink'. 

Note the order of items in the CSV file: newer items are added to the end of the file. But this order will be \emph{reversed} in the RSS file!
}
\seealso{ \code{\link[base:cat]{cat}}, \code{\link[utils:read.table]{read.csv}} }
\examples{
# create rss feed from a sample file in 'animation' 
# to getwd() 
write.rss(entry = system.file("js", "rss.csv", package = "animation")) 

\dontrun{

# Read entries from the internet 
write.rss(entry = "http://www.yihui.name/r/news/rss.csv")

} 
}
\keyword{ IO }
\keyword{ misc }