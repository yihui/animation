`tidy.source` <- function(source = "clipboard", keep.comment = TRUE, 
    keep.blank.line = FALSE, begin.comment, end.comment, ...) {
    tidy.block = function(block.text) {
        exprs = parse(text = block.text)
        n = length(exprs)
        res = character(n)
        for (i in 1:n) {
            dep = paste(deparse(exprs[i]), collapse = "\n")
            res[i] = substring(dep, 12, nchar(dep) - 1)
        }
        return(res)
    }
    text.lines = readLines(source, warn = FALSE)
    if (keep.comment) {
        identifier = function() paste(sample(LETTERS), collapse = "")
        if (missing(begin.comment)) 
            begin.comment = identifier()
        if (missing(end.comment)) 
            end.comment = identifier()
        text.lines = gsub("^[[:space:]]+|[[:space:]]+$", "", 
            text.lines)
        while (length(grep(sprintf("%s|%s", begin.comment, end.comment), 
            text.lines))) {
            begin.comment = identifier()
            end.comment = identifier()
        }
        head.comment = substring(text.lines, 1, 1) == "#"
        if (any(head.comment)) {
            text.lines[head.comment] = gsub("\"", "'", text.lines[head.comment])
            text.lines[head.comment] = sprintf("%s=\"%s%s\"", 
                begin.comment, text.lines[head.comment], end.comment)
        }
        blank.line = text.lines == ""
        if (any(blank.line) & keep.blank.line) 
            text.lines[blank.line] = sprintf("%s=\"%s\"", begin.comment, 
                end.comment)
        text.tidy = tidy.block(text.lines)
        text.tidy = gsub(sprintf("%s = \"|%s\"", begin.comment, 
            end.comment), "", text.tidy)
    }
    else {
        text.tidy = tidy.block(text.lines)
    }
    cat(paste(text.tidy, collapse = "\n"), "\n", ...)
    invisible(text.tidy)
} 