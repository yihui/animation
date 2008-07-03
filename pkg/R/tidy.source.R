`tidy.source` <- function(source = "clipboard", ...) {
    exprs = parse(source)
    n = length(exprs)
    res = character(n)
    for (i in 1:n) {
        dep = paste(deparse(exprs[i]), collapse = "\n")
        res[i] = substring(dep, 12, nchar(dep) - 1)
    }
    cat(paste(res, collapse = "\n"), "\n", ...)
} 
