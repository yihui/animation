##' A Wrapper for the `convert' Utility of ImageMagick
##'
##' This function simply wraps the arguments of the \command{convert} utility of ImageMagick to make it easier to call \command{convert} in R.
##' @title A Wrapper for the `convert' Utility of ImageMagick
##' @param files either a character vector of file names, or a single
##' string containing wildcards (e.g. \file{Rplot*.png})
##' @param interval time to pause between image frames in seconds
##' @param loop iterations of the movie; set iterations to 0 to play
##' the animation for an infinite number of times, otherwise the
##' animation repeats itself up to \code{loop} times (N.B. for GIF
##' only!)
##' @param output the file name of the output (with proper extensions,
##' e.g. gif)
##' @param extra.opts additional options to be passed to
##' \command{convert}
##' @param outdir the output directory
##' @param convert the \command{convert} command; see Details
##' @param cmd.fun a function to invoke the OS command; by default,
##' \code{shell} under Windows and \code{\link[base]{system}} under
##' other OS
##' @param clean logical: delete the input \code{files} or not
##' @return the path of the output if the command was successfully executed; otherwise a failure message
##' @note If \code{files} is a character vector, please make sure the order of filenames is correct! The first animation frame will be \code{files[1]}, the second frame will be \code{files[2]}, ...
##'
##' Most Windows users do not have read the boring notes below after they have installed ImageMagick. For the rest:
##'
##' Please make sure ImageMagick has been installed in your system (go to \url{http://www.imagemagick.org} for details), and \command{convert} is in your \code{'PATH'} variable,
##' in which case the command \command{convert} can be called without the full path (otherwise you have to set \command{convert} to be, e.g., \file{C:/Programe Files/ImageMagick/convert.exe}).
##' Windows users are often very confused about the ImageMagick and \code{'PATH'} setting, so I'll try to search for ImageMagick in the Registry Hive by \code{readRegistry('SOFTWARE\\ImageMagick\\Current')$BinPath},
##' thus you might not really need to modify your \code{'PATH'} variable.
##' Anyway, the full path will work in most cases, but bear in mind that if your path contains spaces, you have to use \code{\link[base]{shQuote}} to quote your path string,
##' e.g. \code{convert = shQuote(normalizePath('C:/Programe Files/ImageMagick/convert.exe'))}.
##'
##' For Windows users who have installed LyX, I will also try to find the \command{convert} utility in the LyX installation directory, so they do not really have to install ImageMagick if LyX exists in their system.
##'
##' A (weird) reported problem is \code{cmd.fun = shell} might not work under Windows but \code{cmd.fun = system} works fine. Try this option if \code{im.convert()} fails.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @references
##' \url{http://www.imagemagick.org/script/convert.php}
##' @examples
##' \dontrun{
##' png(file.path(tempdir(), "bm\%03d.png"))
##' ani.options(interval = 0, nmax = 50)
##' brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
##'     main = "Demonstration of Brownian Motion")
##' dev.off()
##'
##' ## filenames with a wildcard *
##' bm.files = paste(tempdir(), "bm*.png", sep = .Platform$file.sep)
##' im.convert(files = bm.files, interval = 0.05, output = "bm-animation1.gif",
##'     outdir = getwd())
##'
##' ## or a filename vector
##' bm.files = file.path(tempdir(), sprintf("bm\%03d.png", 1:50))
##' im.convert(files = bm.files, interval = 0.05, output = "bm-animation2.gif",
##'     outdir = getwd())
##' }
im.convert = function(files, interval = ani.options("interval"),
    loop = 0, output = "animation.gif", extra.opts = "", outdir = getwd(),
    convert = "convert", cmd.fun, clean = FALSE) {
    output.path = file.path(outdir, output)
    if (missing(cmd.fun))
        cmd.fun = if (.Platform$OS.type == "windows")
            shell
        else system
    version = cmd.fun(sprintf("%s --version", convert), intern = TRUE)
    # try to look for ImageMagick in the Windows Registry Hive,
    # the Program Files directory and the LyX installation
    if (!length(grep("ImageMagick", version))) {
        message("I cannot find ImageMagick with convert = ",
            shQuote(convert))
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
                magick.path = readRegistry("LyX.Document\\Shell\\open\\command",
                  "HCR")
            }, silent = TRUE), "try-error")) {
                convert = shQuote(normalizePath(file.path(dirname(gsub("(^\"|\" \"%1\"$)",
                  "", magick.path[[1]])), "..", "imagemagick",
                  "convert.exe")))
                message("but I can find it from the LyX installation: ",
                  dirname(convert))
            }
            else stop("ImageMagick not installed yet!")
        }
        else {
            stop("Please install ImageMagick first or give the full path of the 'convert' command \n(e.g. 'C:\\Program Files\\ImageMagick\\convert.exe')")
        }
    }
    input = paste(files, collapse = " ")
    convert = sprintf("%s -delay %s -loop %s %s %s %s", convert,
        interval * 100, loop, extra.opts, input, output.path)
    message("Executing: ", convert)
	flush.console()
    cmd = cmd.fun(convert)
    if (cmd == 0) {
        message("Output at: ", output.path)
        if (clean)
            unlink(files)
        if (.Platform$OS.type == "windows" & interactive())
            try(shell.exec(output.path))
        return(invisible(output.path))
    }
    else {
        message("There seems to be an error in the conversion...")
    }
}
