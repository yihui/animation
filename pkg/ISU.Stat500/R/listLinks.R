listLinks <-
function(URL, pattern = "", relative = FALSE) {
    doc = htmlParse(URL)
    if (is.null(grep("/$", URL))) URL = dirname(URL)
    nodes = getNodeSet(doc, "//a[@href]")
    hrefs = sapply(nodes, function(x) xmlGetAttr(x, "href"))
    paste(if (relative) 
        ""
    else URL, hrefs[grep(pattern, hrefs)], sep = "")
}

