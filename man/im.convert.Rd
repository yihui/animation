\name{im.convert}
\alias{im.convert}
\title{A Wrapper for the `convert' Utility of ImageMagick}
\usage{im.convert(files, interval=ani.options("interval"), loop=0,
    output="animation.gif", extra.opts="", outdir=getwd(),
    convert="convert", cmd.fun, clean=FALSE)}
\description{A Wrapper for the `convert' Utility of ImageMagick}
\details{This function simply wraps the arguments of the \command{convert} utility of ImageMagick to make it easier to call \command{convert} in R.}
\value{The path of the output if the command was successfully executed; otherwise a failure message.

If \code{ani.options('autobrowse') == TRUE}, this function will also try to
open the output automatically.}
\note{If \code{files} is a character vector, please make sure the order of filenames is correct! The first animation frame will be \code{files[1]}, the second frame will be \code{files[2]}, ...

Most Windows users do not have read the boring notes below after they have installed ImageMagick. For the rest:

Please make sure ImageMagick has been installed in your system (go to \url{http://www.imagemagick.org} for details), and \command{convert} is in your \code{'PATH'} variable,
in which case the command \command{convert} can be called without the full path (otherwise you have to set \command{convert} to be, e.g., \file{C:/Programe Files/ImageMagick/convert.exe}).
Windows users are often very confused about the ImageMagick and \code{'PATH'} setting, so I'll try to search for ImageMagick in the Registry Hive by \code{readRegistry('SOFTWARE\\ImageMagick\\Current')$BinPath},
thus you might not really need to modify your \code{'PATH'} variable.
Anyway, the full path will work in most cases, but bear in mind that if your path contains spaces, you have to use \code{\link[base]{shQuote}} to quote your path string,
e.g. \code{convert = shQuote(normalizePath('C:/Programe Files/ImageMagick/convert.exe'))}.

For Windows users who have installed LyX, I will also try to find the \command{convert} utility in the LyX installation directory, so they do not really have to install ImageMagick if LyX exists in their system.

A (weird) reported problem is \code{cmd.fun = shell} might not work under Windows but \code{cmd.fun = system} works fine. Try this option if \code{im.convert()} fails.}
\author{Yihui Xie <\url{http://yihui.name}>}
\references{\url{http://www.imagemagick.org/script/convert.php}}
\arguments{\item{files}{either a character vector of file names, or a single
string containing wildcards (e.g. \file{Rplot*.png})}
\item{interval}{time to pause between image frames in seconds}
\item{loop}{iterations of the movie; set iterations to 0 to play
the animation for an infinite number of times, otherwise the
animation repeats itself up to \code{loop} times (N.B. for GIF
only!)}
\item{output}{the file name of the output (with proper extensions,
e.g. gif)}
\item{extra.opts}{additional options to be passed to
\command{convert}}
\item{outdir}{the output directory}
\item{convert}{the \command{convert} command; see Details}
\item{cmd.fun}{a function to invoke the OS command; by default,
\code{shell} under Windows and \code{\link[base]{system}} under
other OS}
\item{clean}{logical: delete the input \code{files} or not}}
\examples{\dontrun{
png(file.path(tempdir(), "bm\%03d.png"))
ani.options(interval = 0, nmax = 50)
brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
main = "Demonstration of Brownian Motion")
dev.off()

## filenames with a wildcard *
bm.files = paste(tempdir(), "bm*.png", sep = .Platform$file.sep)
im.convert(files = bm.files, interval = 0.05, output = "bm-animation1.gif",
outdir = getwd())

## or a filename vector
bm.files = file.path(tempdir(), sprintf("bm\%03d.png", 1:50))
im.convert(files = bm.files, interval = 0.05, output = "bm-animation2.gif",
outdir = getwd())
}}
