##' A wrapper for the `convert' utility of ImageMagick or GraphicsMagick.
##'
##' The function \code{im.convert} simply wraps the arguments of the
##' \command{convert} utility of ImageMagick to make it easier to call
##' ImageMagick in R; similarly, the function \code{gm.convert} is a wrapper for
##' the command \command{gm convert} of GraphicsMagick. These two functions are
##' nearly identical -- the only difference is the default value for the \code{convert}
##' argument (\code{'convert'} for \code{im.convert}, and \code{'gm convert'} for
##' \code{gm.convert}). The main purpose of this function is to create GIF animations.
##'
##' @aliases im.convert gm.convert
##' @rdname convert
##' @param files either a character vector of file names, or a single string
##'   containing wildcards (e.g. \file{Rplot*.png})
##' @param interval time to pause between image frames in seconds (can be
##' a vector, which specifies the time intervals between successive frames)
##' @param loop iterations of the movie; set iterations to 0 to play the
##'   animation for an infinite number of times, otherwise the animation
##'   repeats itself up to \code{loop} times (N.B. for GIF only!)
##' @param output the file name of the output (with proper extensions, e.g.
##'   gif)
##' @param extra.opts additional options to be passed to \command{convert}
##' @param outdir the output directory
##' @param convert the \command{convert} command; see Details
##' @param cmd.fun a function to invoke the OS command; by default
##' \code{\link[base]{system}}
##' @param clean logical: delete the input \code{files} or not
##' @return The path of the output if the command was successfully executed;
##'   otherwise a failure message.
##'
##' If \code{ani.options('autobrowse') == TRUE}, this function will also try to
##'   open the output automatically.
##' @note If \code{files} is a character vector, please make sure the order of
##'   filenames is correct! The first animation frame will be \code{files[1]},
##'   the second frame will be \code{files[2]}, ...
##'
##' Most Windows users do not have read the boring notes below after they have
##'   installed ImageMagick or GraphicsMagick. For the rest:
##'
##' ImageMagick users -- please install ImageMagick from
##'   \url{http://www.imagemagick.org}, and make sure the the path to \command{convert.exe}
##' is in your \code{'PATH'} variable, in which case the command
##'   \command{convert} can be called without the full path.
##'   Windows users are often very confused
##'   about the ImageMagick and \code{'PATH'} setting, so I'll try to search
##'   for ImageMagick in the Registry Hive by
##'   \code{readRegistry('SOFTWARE\ImageMagick\Current')$BinPath}, thus you
##'   might not really need to modify your \code{'PATH'} variable.
##'
##' For Windows users who have installed LyX, I will also try to find the
##'   \command{convert} utility in the LyX installation directory, so they do
##'   not really have to install ImageMagick if LyX exists in their system
##' (of course, the LyX should be installed with ImageMagick).
##'
##' GraphicsMagick users -- during the installation of GraphicsMagick, you will
##' be asked if you allow it to change the PATH variable; please do check the option.
##'
##' A reported problem is \code{cmd.fun = shell} might not work under
##'   Windows but \code{cmd.fun = system} works fine. Try this option in case of failures.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @references
##' ImageMagick: \url{http://www.imagemagick.org/script/convert.php}
##'
##' GraphicsMagick: \url{http://www.graphicsmagick.org}
##' @examples
##' \dontrun{
##' png(file.path(tempdir(), "bm%03d.png"))
##' ani.options(interval = 0, nmax = 50)
##' brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
##' main = "Demonstration of Brownian Motion")
##' dev.off()
##'
##' ## filenames with a wildcard *
##' bm.files = paste(tempdir(), "bm*.png", sep = .Platform$file.sep)
##' im.convert(files = bm.files, interval = 0.05, output = "bm-animation1.gif")
##' ## use GraphicsMagick
##' gm.convert(files = bm.files, interval = 0.05, output = "bm-animation2.gif")
##'
##' ## or a filename vector
##' bm.files = file.path(tempdir(), sprintf("bm%03d.png", 1:50))
##' im.convert(files = bm.files, interval = 0.05, output = "bm-animation3.gif")
##' }
im.convert = function(files, interval = ani.options("interval"),
    loop = 0, output = "animation.gif", extra.opts = "", outdir = getwd(),
    convert = c("convert", "gm convert"), cmd.fun, clean = FALSE) {
    output.path = file.path(outdir, output)
    if (missing(cmd.fun)) cmd.fun = system
    interval = head(interval, length(files))
    convert = match.arg(convert)
    if (convert == 'convert') {
        version = cmd.fun(sprintf("%s --version", convert), intern = TRUE)
        ## try to look for ImageMagick in the Windows Registry Hive,
        ## the Program Files directory and the LyX installation
        if (!length(grep("ImageMagick", version))) {
            message("I cannot find ImageMagick with convert = ", shQuote(convert))
            if (.Platform$OS.type == "windows") {
                if (!inherits(try({
                    magick.path = readRegistry("SOFTWARE\\ImageMagick\\Current")$BinPath
                }, silent = TRUE), "try-error")) {
                    if (nzchar(magick.path)) {
                        convert = shQuote(normalizePath(file.path(magick.path,
                        "convert.exe")))
                        message("but I can find it from the Registry Hive: ",
                                magick.path)
                    }
                }
                else if (nzchar(prog <- Sys.getenv("ProgramFiles")) &&
                         length(magick.dir <- list.files(prog, "^ImageMagick.*")) &&
                         length(magick.path <- list.files(file.path(prog,
                                                                    magick.dir), pattern = "^convert\\.exe$", full.names = TRUE,
                                                          recursive = TRUE))) {
                    convert = shQuote(normalizePath(magick.path[1]))
                    message("but I can find it from the 'Program Files' directory: ",
                            magick.path)
                }
                else if (!inherits(try({
                    magick.path = readRegistry("LyX.Document\\Shell\\open\\command", "HCR")
                }, silent = TRUE), "try-error")) {
                    convert = file.path(dirname(gsub("(^\"|\" \"%1\"$)", "", magick.path[[1]])), c("..", "../etc"), "imagemagick", "convert.exe")
                    convert = convert[file.exists(convert)]
                    if (length(convert)) {
                        convert = shQuote(normalizePath(convert))
                        message("but I can find it from the LyX installation: ", dirname(convert))
                    } else stop("No way to find ImageMagick!")
                }
                else stop("ImageMagick not installed yet!")
                Sys.setenv(PATH = paste(unique(c(dirname(gsub('(^[\"\']|[\"\']$)', '', convert)), strsplit(Sys.getenv('PATH'), ';')[[1]])), sep = ';'))
            }
            else {
                stop("Please install ImageMagick first or put its bin path into the system PATH variable")
            }
        }
    } else {
        ## GraphicsMagick
        version = cmd.fun(sprintf("%s -version", convert), intern = TRUE)
        if (!length(grep("GraphicsMagick", version))) {
            stop("I cannot find GraphicsMagick with convert = ", shQuote(convert),
                 "; you may have to put the path of GraphicsMagick in the PATH variable.")
        }
    }
    input = paste(files, collapse = " ")
    convert = sprintf("%s -loop %s %s %s %s", convert, loop, extra.opts, paste('-delay', interval * 100, files, collapse = ' '), shQuote(output.path))

    message("Executing: ", convert)
    flush.console()
    cmd = cmd.fun(convert)
    ## if fails on Windows using shell(), try system() instead of shell()
    if (cmd == 0 && .Platform$OS.type == "windows" && identical(cmd.fun, shell)) {
        cmd = system(convert)
    }
    if (cmd == 0) {
        message("Output at: ", output.path)
        if (clean)
            unlink(files)
        if (interactive() && ani.options('autobrowse')) {
            switch(.Platform$OS.type,
                   windows = try(shell.exec(output.path)),
                   unix = try(system(paste('xdg-open ', output.path)), TRUE))
            if (Sys.info()["sysname"] == "Darwin")
                try(system(paste('open ', output.path)), TRUE)
        }
        return(invisible(output.path))
    }
    else {
        message("There seems to be an error in the conversion...")
    }
}

##' @rdname convert
##' @param ... arguments to be passed to \code{\link{im.convert}}
gm.convert = function(..., convert = "gm convert") {
    im.convert(..., convert = convert)
}
