

##' `Tidy up' R Code and Partially Preserve Comments
##' Actually this function has nothing to do with code optimization; it just
##' returns parsed source code, but some comments can be preserved, which is
##' different with \code{\link{parse}}. See `Details'.
##' 
##' This function helps the users to tidy up their source code in a sense that
##' necessary indents and spaces will be added, etc. See \code{\link{parse}}.
##' But comments which are in single lines will be preserved if
##' \code{keep.comment = TRUE} (inline comments will be removed).
##' 
##' The method to preserve comments is to protect them as strings in disguised
##' assignments: combine \code{end.comment} to the end of a comment line and
##' 'assign' the whole line to \code{begin.comment}, so the comment line will
##' not be removed when parsed. At last, we remove the identifiers
##' \code{begin.comment} and \code{end.comment}.
##' 
##' @param source a string: location of the source code (default to be the
##'   clipboard; this means we can copy the code to clipboard and use
##'   \code{tidy.souce()} without specifying the argument \code{source})
##' @param keep.comment logical value: whether to keep comments or not?
##' @param keep.blank.line logical value: whether to keep blank lines or not?
##' @param begin.comment, end.comment identifiers to mark the comments
##' @param output output to the console or a file using \code{\link{cat}}?
##' @param width.cutoff passed to \code{\link{deparse}}: integer in [20, 500]
##'   determining the cutoff at which line-breaking is tried
##' @param \dots other arguments passed to \code{\link{cat}}, e.g. \code{file}
##' @return A list with components \item{text.tidyThe parsed code as a
##'   character vector.} \item{text.maskThe code containing comments, which are
##'   masked in assignments.} \item{begin.comment, end.comment identifiers used
##'   to mark the comments }
##' 
##' Note that 'clean' code will be printed in the console unless the output is
##'   redirected by \code{\link{sink}}, and we can also write the clean code to
##'   a file.
##' @note For Mac users, this function will automatically set \code{source} to
##'   be \code{pipe("pbpaste")} so that we still don't need to specify this
##'   argument if we want to rea the code form the clipboard.
##' @author Yihui Xie <\url{http://yihui.name}> with substantial contribution
##'   from Yixuan Qiu <\url{http://yixuan.cos.name}>
##' @seealso \code{\link{parse}}, \code{\link{deparse}}, \code{\link{cat}}
##' @references
##'   \url{http://animation.yihui.name/animation:misc#tidy_up_r_source}
##' @keywords IO
##' @examples
##' 
##' ## tidy up the source code of image demo 
##' x = file.path(system.file(package = "graphics"), "demo", "image.R") 
##' # to console 
##' tidy.source(x)
##' # to a file
##' f = tempfile()
##' tidy.source(x, keep.blank.line = TRUE, file = f) 
##' ## check the original code here and see the difference 
##' file.show(x)
##' file.show(f)
##' ## if you've copied R code into the clipboard 
##' \dontrun{
##' tidy.source("clipboard")
##' ## write into clipboard again
##' tidy.source("clipboard", file = "clipboard")
##' }
##' 
`tidy.source` <- function(source = "clipboard", keep.comment = TRUE, 
    keep.blank.line = TRUE, begin.comment, end.comment, output = TRUE, 
    width.cutoff = 60L, ...) {
    if (source == "clipboard" && Sys.info()["sysname"] == "Darwin") {
        source = pipe("pbpaste")
    }
    tidy.block = function(block.text) {
        exprs = base::parse(text = block.text)
        n = length(exprs)
        res = character(n)
        for (i in 1:n) {
            dep = paste(base::deparse(exprs[i], width.cutoff), collapse = "\n")
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
        text.mask = tidy.block(text.lines)
        text.tidy = gsub(sprintf("%s = \"|%s\"", begin.comment, 
            end.comment), "", text.mask)
    }
    else {
        text.tidy = text.mask = tidy.block(text.lines)
        begin.comment = end.comment = ""
    }
    if (output) cat(paste(text.tidy, collapse = "\n"), "\n", ...)
    invisible(list(text.tidy = text.tidy, text.mask = text.mask, 
        begin.comment = begin.comment, end.comment = end.comment))
} 
