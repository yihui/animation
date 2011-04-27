##' Convert images to Flash animations.
##' This function opens a graphical device first to generate a
##' sequence of images based on \code{expr}, then makes use of the
##' commands in `SWF Tools' (\command{png2swf}, \command{jpeg2swf},
##' \command{pdf2swf}) to convert these images to a single Flash
##' animation.
##'
##' @param expr an expression to generate animations; use either the
##' animation functions (e.g. \code{brownian.motion()}) in this
##' package or a custom expression (e.g. \code{for(i in 1:10)
##' plot(runif(10), ylim = 0:1)}).
##' @param img.name file name of the sequence of images (`pure' name;
##' without any format or extension)
##' @param swf.name file name of the Flash file
##' @param swftools the path of `SWF Tools',
##' e.g. \file{C:/swftools}. This argument is to make sure that
##' \code{png2swf}, \code{jpeg2swf} and \code{pdf2swf} can be executed
##' correctly. If it is \code{NULL}, it should be guaranteed that
##' these commands can be executed without the path; anyway, this
##' function will try to find SWF Tools from Windows registry even if
##' it is not in the PATH variable.
##' @param ... other arguments passed to \code{\link{ani.options}},
##' e.g.  \code{ani.height} and \code{ani.width}, ...
##' @return An integer indicating failure (-1) or success (0) of the
##' converting (refer to \code{\link[base]{system}}).
##' @note Please download and install the SWF Tools before using this
##' function: \url{http://www.swftools.org}
##'
##' We can also set the path to SWF Tools by
##' \code{ani.options(swftools = 'path/to/swftools')}.
##'
##' \code{ani.options('ani.type')} can only be one of \code{png},
##' \code{pdf} and \code{jpeg}.
##'
##' Also note that PDF graphics can be compressed using qpdf or Pdftk
##' (if either one is installed and \code{ani.options('qpdf')} or
##' \code{ani.options('pdftk')} has been set); see \code{\link{qpdf}}
##' or \code{\link{pdftk}}.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link{saveGIF}}, \code{\link{saveLatex}},
##' \code{\link{saveHTML}}, \code{\link{saveVideo}},
##' \code{\link[base]{system}}, \code{\link[grDevices]{png}},
##' \code{\link[grDevices]{jpeg}}, \code{\link[grDevices]{pdf}},
##' \code{\link{qpdf}}, \code{\link{pdftk}}
##' @references
##'   \url{http://animation.yihui.name/animation:start#create_flash_animations}
##' @keywords dynamic device utilities
##' @examples
##' ## from png to swf
##' saveSWF({
##' par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
##' knn.ani(test = matrix(rnorm(16), ncol = 2),
##'     cl.pch = c(16, 2))}, swf.name = "kNN.swf", interval = 1.5,
##' nmax=ifelse(interactive(), 40, 2))
##'
##' ## from pdf (vector plot) to swf; can set the option 'pdftk' to compress PDF
##' saveSWF({brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")},
##'     swf.name = "brownian.swf", interval = 0.2,
##' nmax = 30, ani.dev = "pdf", ani.type = "pdf",
##' ani.height = 6, ani.width=6)
##'
saveSWF = function(expr, swf.name = "animation.swf", img.name = "Rplot",
    swftools = NULL, ...) {
    oopt = ani.options(...)
    on.exit(ani.options(oopt))
    outdir = ani.options('outdir')
    owd = setwd(outdir)
    on.exit(setwd(owd), add = TRUE)

    ani.dev = ani.options('ani.dev')
    file.ext = ani.options('ani.type')
    if (!(file.ext %in% c('pdf', 'png', 'jpeg'))) {
        warning("ani.options('ani.type') has to be one of 'pdf', 'png' and 'jpeg'")
        return()
    }
    interval = ani.options('interval')
    if (is.character(ani.dev)) ani.dev = get(ani.dev)
    digits = ceiling(log10(ani.options("nmax"))) + 2
    num = ifelse(ani.options("ani.type") == "pdf", "", paste("%0", digits, "d", sep = ""))
    img.fmt = paste(img.name, num, ".", file.ext, sep = "")
    img.fmt = file.path(tempdir(), img.fmt)
    ## remove existing image files first
    unlink(file.path(tempdir(), paste(img.name, '*.', file.ext, sep = '')))
    ani.options(img.fmt = img.fmt)
    if ((use.dev <- ani.options('use.dev')))
        ani.dev(img.fmt, width = ani.options('ani.width'),
                height = ani.options('ani.height'))
    owd1 = setwd(owd)
    eval(expr)
    setwd(owd1)
    if (use.dev) dev.off()

    ## compress PDF files
    if (file.ext == 'pdf' &&
        ((use.pdftk <- !is.null(ani.options('pdftk'))) ||
         (use.qpdf <- !is.null(ani.options('qpdf'))))) {
        for (f in list.files(path = dirname(img.name), pattern =
                             sprintf('^%s[0-9]*\\.pdf$', img.name), full.names = TRUE))
            if (use.qpdf) qpdf(f) else if (use.pdftk) pdftk(f)
    }

    if (!is.null(ani.options('swftools'))) {
        swftools = ani.options('swftools')
    } else {
        if (.Platform$OS.type == 'windows' && !inherits(try({
            swftools = utils::readRegistry("SOFTWARE\\quiss.org\\SWFTools\\InstallPath")[[1]]
        }, silent = TRUE), "try-error")) {
            ani.options(swftools = swftools)
        }
    }
    tool = paste(ifelse(is.null(swftools), '', paste(swftools, .Platform$file.sep, sep = '')),
                 paste(file.ext, "2swf", sep = ""), sep = "")
    if (.Platform$OS.type == 'windows') {
        tool = paste(tool, '.exe', sep = '')
        if (file.exists(tool)) tool = normalizePath(tool) else {
            warning('the executable', tool, 'does not exist!')
            return()
        }
    }
    tool = shQuote(tool)
    version = try(system(paste(tool, '--version'), intern = TRUE,
                         ignore.stdout = !interactive(), ignore.stderr = !interactive()))
    if (inherits(version, 'try-error') || !length(grep('swftools', version))) {
        warning('The command ', tool, ' is not available. Please install: http://www.swftools.org')
        return()
    }
    wildcard = paste(shQuote(list.files(tempdir(), paste(img.name, ".*\\.", file.ext, sep = ""),
                                        full.names = TRUE)), collapse = ' ')
    convert = paste(tool, wildcard, "-o", swf.name)
    cmd = -1
    if (file.ext == "png" || file.ext == "jpeg") {
        convert = paste(convert, "-r", 1/interval)
        message("Executing: ", convert)
        cmd = system(convert, ignore.stdout = !interactive(), ignore.stderr = !interactive())
    } else {
        convert = paste(convert, " -s framerate=", 1/interval, sep = "")
        message("Executing: ", convert)
        cmd = system(convert, ignore.stdout = !interactive(), ignore.stderr = !interactive())
    }
    if (cmd == 0) {
        message("\n\nFlash has been created at: ",
                output.path <- normalizePath(file.path(outdir, swf.name)))
        if (ani.options('autobrowse')) {
            if (.Platform$OS.type == 'windows')
                try(shell.exec(output.path)) else if (Sys.info()["sysname"] == "Darwin")
                    try(system(paste('open ', shQuote(output.path))), TRUE) else
            try(system(paste('xdg-open ', shQuote(output.path))), TRUE)
        }
    }
    invisible(cmd)
}
