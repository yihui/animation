##' Insert animations into a LaTeX document and compile it.
##' Record animation frames and insert them into a LaTeX document with the
##' \code{animate} package. Compile the document if an appropriate LaTeX
##' command is provided.
##'
##' This is actually a wrapper to generate a LaTeX document using R. The
##' document uses the LaTeX package called \code{animate} to insert animations
##' into PDF's. When we pass an R expression to this function, the expression
##' will be evaluated and recorded by a grahpics device (typically
##' \code{\link[grDevices]{png}} and \code{\link[grDevices]{pdf}}). At last, a
##' LaTeX document will be created and compiled if an appropriate LaTeX command
##' is provided. And the final PDF output will be opened with the PDF viewer
##' set in \code{getOption("pdfviewer")} if \code{ani.options("autobrowse") ==
##' TRUE}.
##'
##' @param expr an expression to generate animations; use either the animation
##'   functions (e.g. \code{brownian.motion()}) in this package or a custom
##'   expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}).
##' @param nmax maximum number of animation frames (if missing and the graphics
##' device is a bitmap device, this number will be automatically calculated);
##' note that we do not have to specify \code{nmax} when using PDF devices.
##' @param img.name basename of file names of animation frames; see the Note
##' section for a possible adjustment on \code{img.name}
##' @param ani.opts options to control the behavior of the animation (passed to
##'   the LaTeX macro \code{"\\animategraphics"}; default to be
##' \code{"controls,width=\\linewidth"})
##' @param centering logical: whether to center the graph using the LaTeX
##' environment \verb{\begin{center}} and \verb{\end{center}}
##' @param caption,label caption and label for the graphics in the figure
##'   environment
##' @param pkg.opts global options for the \code{animate} package
##' @param documentclass LaTeX document class; if \code{NULL}, the output
##' will not be a complete LaTeX document (only the code to generate the
##' PDF animation will be printed in the console)
##' @param latex.filename file name of the LaTeX document; if an empty string
##'   \code{""}, the LaTeX code will be printed in the console and hence not
##'   compiled
##' @param pdflatex the command for pdfLaTeX (set to \code{NULL} to ignore the
##'   compiling)
##' @param install.animate copy the LaTeX style files \file{animate.sty} and
##' \file{animfp.sty} to \code{ani.options('outdir')}? If you have not installed
##' the LaTeX package \code{animate}, it suffices just to copy these to files.
##' @param overwrite whether to overwrite the existing image frames
##' @param \dots other arguments passed to the graphics device \code{ani.dev},
##'   e.g. height and width
##' @return Invisible \code{NULL}
##' @note
##' This function will detect if it was called in a Sweave environment --
##' if so, \code{img.name} will be automatically adjusted to
##' \code{prefix.string-label}, and the LaTeX output will not be a complete
##' document, but rather a single line like
##' \verb{\animategraphics[ani.opts]{1/interval}{img.name}{}{}}
##'
##' This automatic feature can be useful to Sweave users (but remember to
##' set the Sweave option \code{results=tex}).
##'
##' PDF devices are recommended because of their high quality and usually they
##' are more friendly to LaTeX. But sometimes the size of PDF files is much
##' larger. Use \code{ani.options(ani.dev = 'pdf', ani.type = 'pdf')} to
##' set the PDF device.
##'
##' So far animations created by the LaTeX package \pkg{animate} can only be
##'   viewed with Acrobat Reader (Windows) or \command{acroread} (Linux).
##' Other PDF viewers may not support JavaScript (in fact the PDF animation is
##' driven by JavaScript). Linux users may need to install \command{acroread}
##' and set \code{options(pdfviewer = 'acroread')}.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link{saveMovie}} to convert image frames to a single
##'   GIF/MPEG file; \code{\link{saveSWF}} to convert images to Flash;
##'   \code{\link{saveHTML}} to create an HTML page containing the animation
##' @references To know more about the \code{animate} package, please refer to
##'   \url{http://www.ctan.org/tex-archive/macros/latex/contrib/animate/}.
##'   There are a lot of options can be set in \code{ani.opts} and
##'   \code{pkg.opts}.
##' @keywords dynamic device utilities
##' @examples
##'
##' ## brownian motion: note the 'loop' option in ani.opts
##' saveLatex({
##'     par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0),
##'         tcl = -0.3, cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
##'     brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
##'         main = "Demonstration of Brownian Motion")
##' }, img.name = "BM", ani.opts = "controls,loop,width=0.8\\\\textwidth",
##'     latex.filename = ifelse(interactive(), "brownian_motion.tex", ""),
##'     interval = 0.1, nmax = 10,
##'     ani.dev = 'pdf', ani.type = 'pdf', ani.width = 7, ani.height = 7)
##'
saveLatex = function(expr, nmax, img.name = "Rplot", ani.opts,
    centering = TRUE, caption = NULL, label = NULL,
    pkg.opts = NULL, documentclass = "article", latex.filename = "animation.tex",
    pdflatex = "pdflatex", install.animate = TRUE, overwrite = TRUE, ...) {
    oopt = ani.options(...)
    if (!missing(nmax)) ani.options(nmax = nmax)
    on.exit(ani.options(oopt))
    outdir = ani.options('outdir')
    ## detect if I'm in a Sweave environment
    in.sweave = FALSE
    if (length(sys.parents()) >= 3) {
        if ('chunkopts' %in% ls(envir = sys.frame(2))) {
            chunkopts = get('chunkopts', envir = sys.frame(2))
            if (all(c('prefix.string', 'label') %in% names(chunkopts))) {
                ## yes, I'm in Sweave w.p. 95%
                img.name = paste(chunkopts$prefix.string, chunkopts$label, sep = '-')
                outdir = '.'
                in.sweave = TRUE
            }
        }
    }

    interval = ani.options('interval')
    ## generate the image frames
    owd = setwd(outdir)
    on.exit(setwd(owd), add = TRUE)
    ani.dev = ani.options('ani.dev')
    ani.ext = ani.options('ani.type')
    num = ifelse(ani.ext == "pdf", "", "%d")
    if (is.character(ani.dev))
        ani.dev = get(ani.dev)
    ani.files.len = length(list.files(path = dirname(img.name), pattern =
                           sprintf('^%s.*\\.%s$', img.name, ani.ext)))
    if (overwrite || !ani.files.len) {
        ani.dev(sprintf("%s%s.%s", img.name, num, ani.ext),
                width = ani.options('ani.width'), height = ani.options('ani.height'))
        owd1 = setwd(owd)
        expr
        setwd(owd1)
        dev.off()
    }
    ani.files.len = length(list.files(path = dirname(img.name), pattern =
                           sprintf('^%s.*\\.%s$', img.name, ani.ext)))

    if (missing(nmax)) {
        ## count the number of images generated
        start.num = ifelse(ani.ext == 'pdf', '', 1)
        end.num = ifelse(ani.ext == 'pdf', '', ani.files.len)
    } else {
        ## PDF animations should start from 0 to nmax-1
        start.num = ifelse(ani.ext == 'pdf', 0, 1)
        end.num = ifelse(ani.ext == 'pdf', nmax - 1, nmax)
    }

    if (missing(ani.opts)) ani.opts = "controls,width=\\linewidth"

    if (install.animate && !in.sweave && length(documentclass)) {
        file.copy(system.file("misc", "animate", "animate.sty", package = "animation"),
                  "animate.sty", overwrite = TRUE)
        file.copy(system.file("misc", "animate", "animfp.sty", package = "animation"),
                  "animfp.sty", overwrite = TRUE)
    }

    if (!in.sweave && length(documentclass)) {
        cat(sprintf("
\\documentclass{%s}
\\usepackage%s{animate}
\\begin{document}
\\begin{figure}
%s
\\animategraphics[%s]{%s}{%s}{%s}{%s}%s%s
%s
\\end{figure}
\\end{document}
", documentclass,
                    ifelse(is.null(pkg.opts), "", sprintf("[%s]", pkg.opts)),
                    ifelse(centering, '\\begin{center}', ''),
                    ani.opts,
                    1/interval, img.name, start.num, end.num,
                    ifelse(is.null(caption), "", sprintf("\\caption{%s}", caption)),
                    ifelse(is.null(label), "", sprintf("\\label{%s}", label)),
                    ifelse(centering, '\\end{center}', '')),
            "\n", file = latex.filename)
        if ((latex.filename != "") & !is.null(pdflatex)) {
            message("LaTeX document created at: ", file.path(getwd(),
                                                             latex.filename))
            if (system(sprintf("%s %s", pdflatex, latex.filename),
                       show.output.on.console = FALSE) == 0) {
                message(sprintf("successfully compiled: %s %s", pdflatex,
                                latex.filename))
                if (ani.options("autobrowse"))
                    system(sprintf("%s %s", shQuote(normalizePath(getOption("pdfviewer"))),
                                   sprintf("%s.pdf", sub("([^.]+)\\.[[:alnum:]]+$",
                                                         "\\1", latex.filename))))
            }
            else {
                message("An error occurred while compiling the LaTeX document; \nyou should probably take a look at the log file: ",
                        sprintf("%s.log", sub("([^.]+)\\.[[:alnum:]]+$",
                                              "\\1", latex.filename)), " under ", getwd())
                if (Sys.info()["sysname"] == "Darwin")
                    message("Mac OS users may also consider saveLatex(..., pdflatex = '/usr/texbin/pdflatex') if pdflatex is not in your PATH variable.")
            }
        }
    } else {
        cat(sprintf("
%s
\\animategraphics[%s]{%s}{%s}{%s}{%s}
%s
", ifelse(centering, '\\begin{center}', ''),
                    ani.opts,
                    1/interval, img.name, start.num, end.num,
                    ifelse(centering, '\\end{center}', '')))
    }
    invisible(NULL)
}
