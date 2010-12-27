##' Convert images to Flash animations.
##' This function opens a graphical device first to generate a sequence of
##' images based on \code{expr}, then makes use of the commands in `SWF Tools'
##' (\code{png2swf}, \code{jpeg2swf}, \code{pdf2swf}) to convert these images
##' to a single Flash animation.
##'
##' @param expr an expression to generate animations; use either the animation
##'   functions (e.g. \code{brownian.motion()}) in this package or a custom
##'   expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}).
##' @param interval duration between animation frames (unit in seconds)
##' @param swfname file name of the Flash file
##' @param dev character: the graphics device to be used. Three choices are
##'   available: \code{\link[grDevices]{png}},
##'   \code{\link[grDevices]{jpeg}} and \code{\link[grDevices]{pdf}}, etc.
##' @param filename file name of the sequence of images (`pure' name; without
##'   any format or extension)
##' @param fmt a C-style string formatting command, such as `\code{%3d}'
##' @param outdir the directory for the animation frames and the Flash file
##' @param swftools the path of `SWF Tools', e.g. \file{C:/swftools}. This
##'   argument is to make sure that \code{png2swf}, \code{jpeg2swf} and
##'   \code{pdf2swf} can be executed correctly. If it is \code{NULL}, it should
##'   be guaranteed that these commands can be executed without the path.
##' @param ani.first an expression to be evaluated before plotting (this will
##'   be useful to set graphical parameters in advance, e.g. \code{ani.first =
##'   par(pch = 20)}
##' @param \dots other arguments passed to the graphical device, such as
##'   \code{height} and \code{width}, ...
##' @return An integer indicating failure (-1) or success (0) of the converting
##'   (refer to \code{\link[base]{system}}).
##' @note Please download the SWF Tools before using this function:
##'   \url{http://www.swftools.org}
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link{saveMovie}}, \code{\link[base]{system}},
##'   \code{\link[grDevices]{png}}, \code{\link[grDevices]{jpeg}},
##'   \code{\link[grDevices]{pdf}}
##' @references
##'   \url{http://animation.yihui.name/animation:start#create_flash_animations}
##' @keywords dynamic device utilities
##' @examples
##'
##' \dontrun{
##' oopt = ani.options(nmax = 50)
##' # from png
##' saveSWF(knn.ani(test = matrix(rnorm(16), ncol = 2),
##'     cl.pch = c(16, 2)), 1.5, dev = "png", ani.first = par(mar = c(3,
##'     3, 1, 1.5), mgp = c(1.5, 0.5, 0)), swfname = "kNN.swf")
##'
##' # from pdf (vector plot!)
##' ani.options(nmax = 50)
##' saveSWF(brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow"),
##'     0.2, "brownian.swf", "pdf", fmt = "")
##'
##' ani.options(oopt)
##' }
##'
saveSWF = function(expr, interval = 1, swfname = "movie.swf",
    dev = c("png", "jpeg", "pdf"), filename = "Rplot", fmt = "%03d",
    outdir = tempdir(), swftools = NULL, ani.first = NULL,
    ...) {
    olddir = setwd(outdir)
    on.exit(setwd(olddir))
    anidev = switch(dev, png = png, jpeg = jpeg, pdf = pdf)
    anidev(paste(filename, fmt, ".", dev, sep = ""), ...)
    ani.first
    expr
    dev.off()
    tool = ifelse(is.null(swftools), paste(dev, "2swf", sep = ""),
        shQuote(file.path(swftools, paste(dev, "2swf", sep = ""))))
    version = system(tool, intern = TRUE)
    if (length(version) < 10)
        stop("swftools not found; please install swftools first: http://www.swftools.org")
    wildcard = paste(filename, "*.", dev, sep = "")
    convert = paste(tool, wildcard, "-o", swfname)
    cmd = -1
    if (dev == "png" | dev == "jpeg") {
        convert = paste(convert, "-r", 1/interval)
        message("Executing: ", convert)
        cmd = system(convert)
    }
    else {
        convert = paste(convert, " -s framerate=", 1/interval, sep = "")
        message("Executing: ", convert)
        cmd = system(convert)
    }
    if (cmd == 0) message("\n\nFlash has been created at: ", normalizePath(file.path(outdir,
        swfname)))
    invisible(cmd)
}
