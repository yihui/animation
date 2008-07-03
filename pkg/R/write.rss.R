`write.rss` <- function(file = "feed.xml", entry = "rss.csv", 
    xmlver = "1.0", rssver = "2.0", title = "What's New?", link = "http://R.yihui.name", 
    description = "Animated Statistics Using R", language = "en-us", 
    copyright = "Copyright 2007, Yihui Xie", pubDate = Sys.time(), 
    lastBuildDate = Sys.time(), docs = "http://R.yihui.name", 
    generator = "Function write.rss() in R package animation", 
    managingEditor = "xieyihui[at]gmail.com", 
    webMaster = "xieyihui[at]gmail.com", 
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