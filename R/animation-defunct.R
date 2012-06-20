#' Defunct functions in the animation package
#'
#' Some functions which were included in old versions of this package
#' but irrelevant to animations.
#'
#' \code{highlight.def} is irrelevant to animations and hence it is no longer
#' in this package; the source code was moved to
#' \url{http://yihui.name/en/2007/09/r-language-definition-file-for-highlight/}.
#'
#' \code{write.rss} is irrelevant either; the source code can be found at
#' \url{https://github.com/yihui/animation/raw/1650902e43fe283d4fd0cea8f559e4e5187d60fe/R/write.rss.R}.
#'
#' \code{ani.news} is no longer necessary since R has got a function
#' \code{\link[utils]{news}} in the \pkg{utils} package
#' @name animation-defunct
#' @aliases animation-defunct highlight.def write.rss ani.news
#' @author Yihui Xie <\url{http://yihui.name}>
#' @seealso \code{\link[base]{Defunct}}
#' @keywords internal
#'
NULL

highlight.def = function(file = "r.lang") {
    .Defunct('http://yihui.name/en/2007/09/r-language-definition-file-for-highlight/', 'animation')
}

write.rss = function(file = "feed.xml", entry = "rss.csv",
    xmlver = "1.0", rssver = "2.0", title = "What's New?",
    link = "http://yihui.name",
    description = "A Website", language = "en-us",
    copyright = "Copyright 2009, Yihui Xie", pubDate = Sys.time(),
    lastBuildDate = Sys.time(), docs = "http://yihui.name",
    generator = "Function write.rss() in R package animation",
    managingEditor = "xie@yihui.name",
    webMaster = "xie@yihui.name",
    maxitem = 10, ...) {
    .Defunct('https://github.com/yihui/animation/raw/1650902e43fe283d4fd0cea8f559e4e5187d60fe/R/write.rss.R', 'animation')
}

ani.news = function(...){
    .Defunct('utils::news', 'animation')
}
