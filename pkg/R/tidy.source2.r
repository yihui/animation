`tidy.source2` = function(source = "clipboard", ...) {
    tidy.block <- function(block.text) {
        exprs = parse(text = block.text)
        n = length(exprs)
        res = character(n)
        for (i in 1:n) {
            dep = paste(deparse(exprs[i]), collapse = "\n")
            res[i] = substring(dep, 12, nchar(dep) - 1)
        }
        return(paste(res, collapse = "\n"))
    }
    text.lines = readLines(con = file(source), warn = FALSE)
    text.lines = gsub("^[[:space:]]+|[[:space:]]+$", "", text.lines)
    lines.head = substring(text.lines, 1, 1)
    text.lines[lines.head == "#"] = paste("headOfComment=\"", 
        text.lines[lines.head == "#"], "endOfComment\"", sep = "")
    text.tidy = tidy.block(text.lines)
    text.tidy = gsub("headOfComment = \"|endOfComment\"", "", 
        text.tidy)
    cat(text.tidy, "\n", ...)
}
