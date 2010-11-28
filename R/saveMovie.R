

##' Convert Images to A Single Animated Movie
##' This function opens a graphical device first to generate a sequence of
##' images based on \code{expr}, then makes use of the command \code{convert}
##' in `ImageMagick' to convert these images to a single animated movie (in
##' formats such as GIF and MPG, etc).
##' 
##' This function calls \code{\link{im.convert}} to convert images to a single
##' animation.
##' 
##' The convenience of this function is that it can create a single movie file,
##' however, two drawbacks are obvious too: (1) we need a special (free)
##' software ImageMagick; (2) the speed of the animation cannot be conveniently
##' controlled, as we have specified a fixed \code{interval}. Other approaches
##' in this package may have greater flexibilities, e.g. the HTML approach (see
##' \code{\link{ani.start}}).
##' 
##' @param expr an expression to generate animations; use either the animation
##'   functions (e.g. \code{brownian.motion()}) in this package or a custom
##'   expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}).
##' @param interval duration between animation frames (unit in seconds)
##' @param moviename file name of the movie (with the extension)
##' @param loop iterations of the movie; set iterations to zero to repeat the
##'   animation an infinite number of times, otherwise the animation repeats
##'   itself up to \code{loop} times (N.B. for GIF only!)
##' @param dev a function for a graphical device such as
##'   \code{\link[grDevices:png]{png}}, \code{\link[grDevices:png]{jpeg}} and
##'   \code{\link[grDevices:png]{bmp}}, etc.
##' @param filename file name of the sequence of images (`pure' name; without
##'   any format or extension)
##' @param fmt a C-style string formatting command, such as \code{\%3d}
##' @param fileext the file extensions of the image frames
##' @param outdir the directory for the movie frames
##' @param convert the ImageMagick command to convert images (default to be
##'   \code{convert}, but might be \code{imconvert} under some Windows
##'   platforms); see the 'Note' section for details
##' @param cmd.fun a function to invoke the OS command; by default,
##'   \code{shell} under Windows and \code{\link[base]{system}} under other OS
##' @param clean whether to delete the individual image frames
##' @param ani.first an expression to be evaluated before plotting (this will
##'   be useful to set graphical parameters in advance, e.g. \code{ani.first =
##'   par(pch = 20)}
##' @param para a list: the graphics parameters to be set before plotting;
##'   passed to \code{\link[graphics]{par}}; note \code{ani.first} can override
##'   this argument
##' @param \dots other arguments passed to the graphical device, such as
##'   \code{height} and \code{width}, ...
##' @return An integer indicating failure (-1) or success (0) of the converting
##'   (refer to \code{\link[base]{system}} and \code{\link{im.convert}}).
##' @note See \code{\link{im.convert}} for details on the configuration of
##'   ImageMagick (typically for Windows users).
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link{im.convert}}, \code{\link{saveSWF}},
##'   \code{\link[base]{system}}, \code{\link[grDevices]{png}},
##'   \code{\link[grDevices]{jpeg}}
##' @references \url{http://www.imagemagick.org/script/convert.php}
##' 
##' \url{http://animation.yihui.name/animation:start}
##' @keywords dynamic device utilities
##' @examples
##' 
##' ## make sure ImageMagick has been installed in your system 
##' \dontrun{
##' saveMovie(for(i in 1:10) plot(runif(10), ylim = 0:1), loop = 1)
##' oopt = ani.options(nmax = 100)
##' saveMovie(brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow"),
##'     interval = 0.1, width = 600, height = 600)
##' ani.options(oopt)
##' }
##' 
saveMovie <-
    function(expr, interval = 1, moviename = "animation.gif",
             loop = 0, dev = png, filename = "Rplot",
             fmt = "%03d", fileext = "png", outdir = getwd(),
             convert = "convert", cmd.fun, clean = TRUE,
             ani.first = NULL, para = par(no.readonly = TRUE),
             ...) {
        force(outdir)
		## create images in the temp dir
        tmpdir = setwd(tempdir())
        on.exit(setwd(tmpdir))

        wildcard = paste(filename, "*.", fileext, sep = "")

        ## clean up the files first
        unlink(wildcard)

        ## draw the plots and record them in image files
        oopt = ani.options(interval = 0)
        dev(paste(filename, fmt, ".", fileext, sep = ""), ...)
        par(para)
        eval(ani.first)
        eval(expr)
        dev.off()
        ani.options(oopt)

        if (missing(cmd.fun))
            cmd.fun = if (.Platform$OS.type == "windows")
                shell
            else system

        ## convert to animations
        im.convert(wildcard, interval = interval, loop = loop,
                   output = moviename, outdir = outdir, convert = convert,
                   cmd.fun = cmd.fun, clean = clean)
    }
