`tidy.source2` = function(source = "clipboard", ...) {
    tidy.block = function(block.text) {
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
    flag = FALSE
    if (lines.head[1] == "#") {
        lines.head = c("f", lines.head)
        text.lines = c("first=NULL", text.lines)
        flag = TRUE
    }
    sharp.index = (lines.head == "#")
    if (all(sharp.index == FALSE) == TRUE) {
        content = tidy.block(paste(text.lines, collapse = "\n"))
        return(cat(content))
    }
    index.diff = diff(sharp.index)
    if (min(index.diff) > -1) {
        pos.n = 1
        neg.n = 0
        block.n = 2
        posneg = 1
    }
    else {
        index.neg = which(index.diff == -1)
        neg.n = length(index.neg)
        index.pos = which(index.diff == 1)
        pos.n = length(index.pos)
        block.n = pos.n + neg.n + 1
        posneg = rep(index.pos, rep(2, length(index.pos)))
        posneg[2 * 1:neg.n] = index.neg
        posneg = posneg[1:(pos.n + neg.n)]
    }
    block.begin = c(1, posneg + 1)
    block.end = c(posneg, length(sharp.index))
    block.iscomment = rep(c(0, 1), pos.n + 1, length.out = block.n)
    block = data.frame(begin = block.begin, end = block.end, 
        iscomment = block.iscomment)
    content = NULL
    for (i in 1:block.n) {
        content[i] = paste(text.lines[block[i, 1]:block[i, 2]], 
            collapse = "\n")
        if (block[i, 3] == 0) {
            content[i] = tidy.block(content[i])
        }
    }
    if (flag) {
        content = content[-1]
    }
    content = ifelse(content == "NULL", "", content)
    text.content = paste(content, collapse = "\n")
    cat(text.content, "\n", ...)
}
