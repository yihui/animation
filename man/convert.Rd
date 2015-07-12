% Please edit documentation in R/im.convert.R
\name{im.convert}
\alias{gm.convert}
\alias{im.convert}
\title{A wrapper for the `convert' utility of ImageMagick or GraphicsMagick}
\usage{
im.convert(files, output = "animation.gif", convert = c("convert", "gm convert"), 
    cmd.fun = if (.Platform$OS.type == "windows") shell else system, extra.opts = "", 
    clean = FALSE)

gm.convert(..., convert = "gm convert")
}
\arguments{
\item{files}{either a character vector of file names, or a single string
containing wildcards (e.g. \file{Rplot*.png})}

\item{output}{the file name of the output (with proper extensions, e.g.
\code{gif})}

\item{convert}{the \command{convert} command; it must be either
\code{'convert'} or \code{'gm convert'}; and it can be pre-specified as an
option in \code{\link{ani.options}('convert')}, e.g. (Windows users)
\code{ani.options(convert = 'c:/program
files/imagemagick/convert.exe')}, or (Mac users) \code{ani.options(convert
= '/opt/local/bin/convert')}; see the Note section for more details}

\item{cmd.fun}{a function to invoke the OS command; by default
\code{\link{system}}}

\item{extra.opts}{additional options to be passed to \command{convert} (or
\command{gm convert})}

\item{clean}{logical: delete the input \code{files} or not}

\item{...}{arguments to be passed to \code{\link{im.convert}}}
}
\value{
The command for the conversion.

  If \code{ani.options('autobrowse') == TRUE}, this function will also try to
  open the output automatically.
}
\description{
The main purpose of these two functions is to create GIF animations.
}
\details{
The function \code{im.convert} simply wraps the arguments of the
\command{convert} utility of ImageMagick to make it easier to call
ImageMagick in R;

The function \code{gm.convert} is a wrapper for the command
  \command{gm convert} of GraphicsMagick.
}
\note{
If \code{files} is a character vector, please make sure the order of
  filenames is correct! The first animation frame will be \code{files[1]},
  the second frame will be \code{files[2]}, ...

  Both ImageMagick and GraphicsMagick may have a limit on the number of
  images to be converted. It is a known issue that this function can fail
  with more than (approximately) 9000 images. The function
  \code{\link{saveVideo}} is a better alternative in such a case.

  Most Windows users do not have read the boring notes below after they have
  installed ImageMagick or GraphicsMagick. For the rest of Windows users:

  \describe{

  \item{\strong{ImageMagick users}}{Please install ImageMagick from
  \url{http://www.imagemagick.org}, and make sure the the path to
  \command{convert.exe} is in your \code{'PATH'} variable, in which case the
  command \command{convert} can be called without the full path.  Windows
  users are often very confused about the ImageMagick and \code{'PATH'}
  setting, so I'll try to search for ImageMagick in the Registry Hive by
  \code{readRegistry('SOFTWARE\ImageMagick\Current')$BinPath}, thus you might
  not really need to modify your \code{'PATH'} variable.

  For Windows users who have installed LyX, I will also try to find the
  \command{convert} utility in the LyX installation directory, so they do not
  really have to install ImageMagick if LyX exists in their system (of
  course, the LyX should be installed with ImageMagick).

  Once the \command{convert} utility is found, the animation option
  \code{'convert'} will be set (\code{ani.options(convert =
  'path/to/convert.exe')}); this can save time for searching for
  \command{convert} in the operating system next time.  }

  \item{\strong{GraphicsMagick users}}{During the installation of
  GraphicsMagick, you will be asked if you allow it to change the PATH
  variable; please do check the option.  }

  }

  A reported problem is \code{cmd.fun = shell} might not work under Windows
  but \code{cmd.fun = system} works fine. Try this option in case of
  failures.
}
\examples{
## generate some images
owd = setwd(tempdir())
oopt = ani.options(interval = 0.05, nmax = 20)
png("bm\%03d.png")
brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow", 
    main = "Demonstration of Brownian Motion")
dev.off()

## filenames with a wildcard *
im.convert("bm*.png", output = "bm-animation1.gif")
## use GraphicsMagick
gm.convert("bm*.png", output = "bm-animation2.gif")

## or a filename vector
bm.files = sprintf("bm\%03d.png", 1:20)
im.convert(files = bm.files, output = "bm-animation3.gif")

ani.options(oopt)
setwd(owd)
}
\author{
Yihui Xie
}
\references{
ImageMagick: \url{http://www.imagemagick.org/script/convert.php}
  GraphicsMagick: \url{http://www.graphicsmagick.org}
}
\seealso{
Other utilities: \code{\link{saveGIF}},
  \code{\link{saveMovie}}; \code{\link{saveHTML}};
  \code{\link{saveLatex}}; \code{\link{saveSWF}};
  \code{\link{saveVideo}}
}
