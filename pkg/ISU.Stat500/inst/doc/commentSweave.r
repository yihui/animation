library(animation)
parse2 = function(text, ...) {
    zz = tempfile()
    writeLines(text, zz)
    tidy.res = tidy.source(zz, out = FALSE)
    unlink(zz)
    options(begin.comment = tidy.res$begin.comment, end.comment = tidy.res$end.comment)
    base::parse(text = tidy.res$text.mask)
}
deparse2 = function(expr, ...) {
    gsub(sprintf("%s = \"|%s\"", getOption("begin.comment"), 
        getOption("end.comment")), "", base::deparse(expr, ...))
}

commentCodeRunner <- function(evalFunc = RweaveEvalWithOpt) {
    ## Return a function suitable as the 'runcode' element
    ## of an Sweave driver.  evalFunc will be used for the
    ## actual evaluation of chunk code.
    RweaveLatexRuncode <- function(object, chunk, options) {
        if (!(options$engine %in% c("R", "S"))) {
            return(object)
        }
        if (!object$quiet) {
            cat(formatC(options$chunknr, width = 2), ":")
            if (options$echo) 
                cat(" echo")
            if (options$keep.source) 
                cat(" keep.source")
            if (options$eval) {
                if (options$print) 
                  cat(" print")
                if (options$term) 
                  cat(" term")
                cat("", options$results)
                if (options$fig) {
                  if (options$eps) 
                    cat(" eps")
                  if (options$pdf) 
                    cat(" pdf")
                }
            }
            if (!is.null(options$label)) 
                cat(" (label=", options$label, ")", sep = "")
            cat("\n")
        }
        chunkprefix <- RweaveChunkPrefix(options)
        if (options$split) {
            ## [x][[1L]] avoids partial matching of x
            chunkout <- object$chunkout[chunkprefix][[1L]]
            if (is.null(chunkout)) {
                chunkout <- file(paste(chunkprefix, "tex", sep = "."), 
                  "w")
                if (!is.null(options$label)) 
                  object$chunkout[[chunkprefix]] <- chunkout
            }
        }
        else chunkout <- object$output
        saveopts <- options(keep.source = options$keep.source)
        on.exit(options(saveopts))
        SweaveHooks(options, run = TRUE)
        chunkexps <- try(parse2(text = chunk), silent = TRUE)
        RweaveTryStop(chunkexps, options)
        openSinput <- FALSE
        openSchunk <- FALSE
        if (length(chunkexps) == 0L) 
            return(object)
        srclines <- attr(chunk, "srclines")
        linesout <- integer(0L)
        srcline <- srclines[1L]
        srcrefs <- attr(chunkexps, "srcref")
        if (options$expand) 
            lastshown <- 0L
        else lastshown <- srcline - 1L
        thisline <- 0
        for (nce in seq_along(chunkexps)) {
            ce <- chunkexps[[nce]]
            if (nce <= length(srcrefs) && !is.null(srcref <- srcrefs[[nce]])) {
                if (options$expand) {
                  srcfile <- attr(srcref, "srcfile")
                  showfrom <- srcref[1L]
                  showto <- srcref[3L]
                }
                else {
                  srcfile <- object$srcfile
                  showfrom <- srclines[srcref[1L]]
                  showto <- srclines[srcref[3L]]
                }
                dce <- getSrcLines(srcfile, lastshown + 1, showto)
                leading <- showfrom - lastshown
                lastshown <- showto
                srcline <- srclines[srcref[3L]]
                while (length(dce) && length(grep("^[[:blank:]]*$", 
                  dce[1L]))) {
                  dce <- dce[-1L]
                  leading <- leading - 1L
                }
            }
            else {
                dce <- deparse2(ce, width.cutoff = 0.75 * getOption("width"))
                leading <- 1L
            }
            if (object$debug) 
                cat("\nRnw> ", paste(dce, collapse = "\n+  "), 
                  "\n")
            if (options$echo && length(dce)) {
                if (!openSinput) {
                  if (!openSchunk) {
                    cat("\\begin{Schunk}\n", file = chunkout, 
                      append = TRUE)
                    linesout[thisline + 1] <- srcline
                    thisline <- thisline + 1
                    openSchunk <- TRUE
                  }
                  cat("\\begin{Sinput}", file = chunkout, append = TRUE)
                  openSinput <- TRUE
                }
                cat("\n", paste(getOption("prompt"), dce[1L:leading], 
                  sep = "", collapse = "\n"), file = chunkout, 
                  append = TRUE, sep = "")
                if (length(dce) > leading) 
                  cat("\n", paste(getOption("continue"), dce[-(1L:leading)], 
                    sep = "", collapse = "\n"), file = chunkout, 
                    append = TRUE, sep = "")
                linesout[thisline + seq_along(dce)] <- srcline
                thisline <- thisline + length(dce)
            }
            # tmpcon <- textConnection('output', 'w')
            # avoid the limitations (and overhead) of output text connections
            tmpcon <- file()
            sink(file = tmpcon)
            err <- NULL
            if (options$eval) 
                err <- evalFunc(ce, options)
            cat("\n")
            sink()
            output <- readLines(tmpcon)
            close(tmpcon)
            ## delete empty output
            if (length(output) == 1L & output[1L] == "") 
                output <- NULL
            RweaveTryStop(err, options)
            if (object$debug) 
                cat(paste(output, collapse = "\n"))
            if (length(output) & (options$results != "hide")) {
                if (openSinput) {
                  cat("\n\\end{Sinput}\n", file = chunkout, append = TRUE)
                  linesout[thisline + 1L:2L] <- srcline
                  thisline <- thisline + 2L
                  openSinput <- FALSE
                }
                if (options$results == "verbatim") {
                  if (!openSchunk) {
                    cat("\\begin{Schunk}\n", file = chunkout, 
                      append = TRUE)
                    linesout[thisline + 1L] <- srcline
                    thisline <- thisline + 1L
                    openSchunk <- TRUE
                  }
                  cat("\\begin{Soutput}\n", file = chunkout, 
                    append = TRUE)
                  linesout[thisline + 1L] <- srcline
                  thisline <- thisline + 1L
                }
                output <- paste(output, collapse = "\n")
                if (options$strip.white %in% c("all", "true")) {
                  output <- sub("^[[:space:]]*\n", "", output)
                  output <- sub("\n[[:space:]]*$", "", output)
                  if (options$strip.white == "all") 
                    output <- sub("\n[[:space:]]*\n", "\n", output)
                }
                cat(output, file = chunkout, append = TRUE)
                count <- sum(strsplit(output, NULL)[[1L]] == 
                  "\n")
                if (count > 0L) {
                  linesout[thisline + 1L:count] <- srcline
                  thisline <- thisline + count
                }
                remove(output)
                if (options$results == "verbatim") {
                  cat("\n\\end{Soutput}\n", file = chunkout, 
                    append = TRUE)
                  linesout[thisline + 1L:2L] <- srcline
                  thisline <- thisline + 2L
                }
            }
        }
        if (openSinput) {
            cat("\n\\end{Sinput}\n", file = chunkout, append = TRUE)
            linesout[thisline + 1L:2L] <- srcline
            thisline <- thisline + 2L
        }
        if (openSchunk) {
            cat("\\end{Schunk}\n", file = chunkout, append = TRUE)
            linesout[thisline + 1L] <- srcline
            thisline <- thisline + 1L
        }
        if (is.null(options$label) & options$split) 
            close(chunkout)
        if (options$split & options$include) {
            cat("\\input{", chunkprefix, "}\n", sep = "", file = object$output, 
                append = TRUE)
            linesout[thisline + 1L] <- srcline
            thisline <- thisline + 1L
        }
        if (options$fig && options$eval) {
            if (options$eps) {
                grDevices::postscript(file = paste(chunkprefix, 
                  "eps", sep = "."), width = options$width, height = options$height, 
                  paper = "special", horizontal = FALSE)
                err <- try({
                  SweaveHooks(options, run = TRUE)
                  eval(chunkexps, envir = .GlobalEnv)
                })
                grDevices::dev.off()
                if (inherits(err, "try-error")) 
                  stop(err)
            }
            if (options$pdf) {
                grDevices::pdf(file = paste(chunkprefix, "pdf", 
                  sep = "."), width = options$width, height = options$height, 
                  version = options$pdf.version, encoding = options$pdf.encoding)
                err <- try({
                  SweaveHooks(options, run = TRUE)
                  eval(chunkexps, envir = .GlobalEnv)
                })
                grDevices::dev.off()
                if (inherits(err, "try-error")) 
                  stop(err)
            }
            if (options$include) {
                cat("\\begin{center}\\includegraphics{", chunkprefix, "}\\end{center}\n", 
                  sep = "", file = object$output, append = TRUE)
                linesout[thisline + 1L] <- srcline
                thisline <- thisline + 1L
            }
        }
        object$linesout <- c(object$linesout, linesout)
        return(object)
    }
    RweaveLatexRuncode
}

env <- as.environment("package:utils")
unlockBinding("makeRweaveLatexCodeRunner", env)
assignInNamespace("makeRweaveLatexCodeRunner", commentCodeRunner, 
    ns = "utils")
lockBinding("makeRweaveLatexCodeRunner", env)
newCodeRunner <- utils:::makeRweaveLatexCodeRunner()
env <- grep("driver", lapply(sys.frames(), function(frame) {
    ls(envir = frame)
}))
env <- sys.frames()[[env]]
evalq(driver$runcode <- newCodeRunner, envir = env) 
