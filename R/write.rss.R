

#' Create RSS feed from a CSV data file
#' An RSS feed is essentially just an XML file, thus the creation is easy just
#' with \code{\link{cat}} to write some tags into a text file.
#' 
#' The elments of an item in an RSS feed usually contains 'title', 'link',
#' 'author', 'description', 'pubDate', 'guid', and 'category', etc, which are
#' stored in the CSV data file \code{entry}.
#' 
#' The many arguments above are just for the channel information.
#' 
#' @param file the path of the output file (RSS feed); passed to
#'   \code{\link{cat}}
#' @param entry the input CSV file, containing elements for items in the RSS
#'   feed (with tag names in the header); \code{\link{read.csv}}
#' @param xmlver version of XML
#' @param rssver version of RSS
#' @param title The name of the channel. It's how people refer to your service.
#'   If you have an HTML website that contains the same information as your RSS
#'   file, the title of your channel should be the same as the title of your
#'   website.
#' @param link The URL to the HTML website corresponding to the channel.
#' @param description Phrase or sentence describing the channel.
#' @param language The language the channel is written in.
#' @param copyright Copyright notice for content in the channel.
#' @param pubDate The publication date for the content in the channel.
#' @param lastBuildDate The last time the content of the channel changed.
#' @param docs A URL that points to the documentation for the format used in
#'   the RSS file.
#' @param generator A string indicating the program used to generate the
#'   channel.
#' @param managingEditor Email address for person responsible for editorial
#'   content.
#' @param webMaster Email address for person responsible for technical issues
#'   relating to channel.
#' @param maxitem Maximum number of items to be written into the feed.
#' @param \dots other elements for the channel, e.g. image, cloud, etc.
#' @return None. Only a message indicating where the RSS was created.
#' @note As the argument \code{file} is passed to \code{\link{cat}}, you may
#'   specify it as an empty string \code{""} so that the result will be printed
#'   to the standard output connection, the console unless redirected by
#'   'sink'.
#' 
#' Note the order of items in the CSV file: newer items are added to the end of
#'   the file. But this order will be \emph{reversed} in the RSS file!
#' @author Yihui Xie <\url{http://yihui.name}>
#' @seealso \code{\link{cat}}, \code{\link{read.csv}}
#' @references Read \url{http://cyber.law.harvard.edu/rss/rss.html} for the
#'   specification of RSS.
#' @keywords IO misc
#' @examples
#' 
#' # create rss feed from a sample file in 'animation' 
#' # to getwd() 
#' write.rss(entry = system.file("js", "rss.csv", package = "animation")) 
#' 
#' \dontrun{
#' # Read entries from the internet 
#' write.rss(entry = "http://yihui.name/r/news/rss.csv")
#' } 
#' 
`write.rss` <- function(file = "feed.xml", entry = "rss.csv", 
    xmlver = "1.0", rssver = "2.0", title = "What's New?", link = "http://yihui.name", 
    description = "A Website", language = "en-us", 
    copyright = "Copyright 2009, Yihui Xie", pubDate = Sys.time(), 
    lastBuildDate = Sys.time(), docs = "http://yihui.name", 
    generator = "Function write.rss() in R package animation", 
    managingEditor = "xie@yihui.name", 
    webMaster = "xie@yihui.name", 
    maxitem = 10, ...) {
    x = read.csv(entry, stringsAsFactors = FALSE, colClasses = "character")
    if (nrow(x) > maxitem) 
        x = x[(nrow(x) - maxitem + 1):nrow(x), ]
    x = x[nrow(x):1, ] 
    lcl = Sys.getlocale("LC_TIME")
    Sys.setlocale("LC_TIME", "C")
    pubDate = format(pubDate, "%a, %d %b %Y %H:%M:%S GMT")
    lastBuildDate = format(lastBuildDate, "%a, %d %b %Y %H:%M:%S GMT")
    cat("<?xml version", "=\"", xmlver, "\"?>\n", "<rss version=\"", 
        rssver, "\">\n", "\t", "<channel>\n", "\t\t", "<title>", 
        title, "</title>\n", "\t\t", "<link>", link, "</link>\n", 
        "\t\t", "<description>", description, "</description>\n", 
        "\t\t", "<language>", language, "</language>\n", "\t\t", 
        "<pubDate>", pubDate, "</pubDate>\n", "\t\t", "<lastBuildDate>", 
        lastBuildDate, "</lastBuildDate>\n", "\t\t", "<docs>", 
        docs, "</docs>\n", "\t\t", "<generator>", generator, 
        "</generator>\n", "\t\t", "<managingEditor>", managingEditor, 
        "</managingEditor>\n", "\t\t", "<webMaster>", webMaster, 
        "</webMaster>\n", file = file, sep = "")
    extra = list(...)
    if (length(extra)) {
        tag1 = paste("\t\t<", names(extra), ">", sep = "")
        tag2 = paste("</", names(extra), ">", sep = "")
        cat(paste(tag1, extra, tag2, sep = "", collapse = "\n"), 
            "\n", file = file, append = TRUE)
    }
    x[, "description"] = paste("<![CDATA[", x[, "description"], 
        "]]>", sep = "")
    tag1 = paste("<", colnames(x), ">", sep = "")
    tag2 = paste("</", colnames(x), ">", sep = "")
    cat(paste("\t\t<item>", apply(x, 1, function(xx) paste("\t\t\t", 
        paste(tag1, xx, tag2, sep = "", collapse = "\n\t\t\t"), 
        sep = "")), "\t\t</item>", sep = "\n", collapse = "\n"), 
        file = file, append = TRUE)
    cat("\n\t", "</channel>", file = file, append = TRUE)
    cat("\n</rss>", file = file, append = TRUE)
    Sys.setlocale("LC_TIME", lcl)
    cat("RSS feed created at:", file, "\n")
}
