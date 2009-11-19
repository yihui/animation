\name{listLinks}
\alias{listLinks}
\title{
List All Links Under A Web Directory
}
\description{
Parse the HTML code and extract the links from a web directory.
}
\usage{
listLinks(URL, pattern = "", relative = FALSE)
}
\arguments{
  \item{URL}{
the URL of the web directory (e.g. the directory for program code, datasets)
}
  \item{pattern}{
character string (regular expression) to be matched; this is useful when there are multiple types of files in the directory (e.g. use \code{"\\\\.r$"} to extract links ended with code{".r"}, or \code{"\\\\.lst$|\\\\.sas$"} to match SAS output and programs)
}
  \item{relative}{
logical: return the links as relative URLs (only filenames) or absolute URLs (full path, e.g. \code{"http://.../abc.r"})?
}
}
\details{
Course materials (slides, code and data, etc) are usually put under certain directories which can be browsed as a list of files in our browsers. As the materials will be updated now and then, we need to check and recheck the course webpage to see the changes and probably download the files manually. This function can list all the links under a directory, therefore we can use R to ``checkout'' the files automatically from the webpages. See the examples below.
}
\value{
a character vector with file names or absolute URLs which can be used to access the files.
}
\author{
Yihui Xie <\url{http://yihui.name}>
}
\note{
This function can be a general-purpose utility to extract links in a page, but note the links might be wrong when \code{relative = FALSE} because we assume the relative links are under the same path of the webpage.
}

\seealso{
\code{\link[XML]{htmlParse}}, \code{\link[XML]{getNodeSet}}, \code{\link[base]{grep}}
}
\examples{
\dontrun{
## Download R code from Dr Hofmann's webpage into a temporary dir
Stat579.URL.R = "http://hofmann.public.iastate.edu/stat579/code/"
R.files = listLinks(Stat579.URL.R, "\\\\.[Rr]$", relative = TRUE)
destDir = tempdir()
for (i in R.files) download.file(paste(Stat579.URL.R, 
    i, sep = ""), file.path(destDir, i))
#  see file.path(destDir, R.files) for their locations
## Or equivalently, relative = FALSE and use basename()
#  to extract base file names
R.files = listLinks(Stat579.URL.R, "\\\\.[Rr]$", relative = FALSE)
destDir = tempdir()
for (i in R.files) download.file(i, file.path(destDir, basename(i)))

## Download SAS code and output from Dr Dixon's webpage
Stat500.URL.SAS = "http://pdixon.public.iastate.edu/stat500/sas/"
SAS.files = listLinks(Stat500.URL.SAS, "\\\\.lst$|\\.sas$", relative = FALSE)
destDir = tempdir()
for (i in SAS.files) download.file(i, file.path(destDir, basename(i)))

## compare the files in the webpage to the ones in your local drive
#  first list the local file names (in the directory tempdir())
local.files = list.files(tempdir(), "\\\\.sas$")
#  then read the list on the server
Stat500.URL.SAS = "http://pdixon.public.iastate.edu/stat500/sas/"
server.files = listLinks(Stat500.URL.SAS, "\\\\.sas$", relative = TRUE)
#  see their differences
#  these files were removed from the server
setdiff(local.files, server.files)
#  and these were newly added
setdiff(server.files, local.files)
}
}
\keyword{ manip }
\keyword{ utilities }
