\name{saveMovie}
\alias{saveMovie}
\title{ Convert Images to A Single Animated Movie }
\description{
  This function opens a graphical device first to generate a sequence of images based on \code{expr}, then makes use of the command \code{convert} in `ImageMagick' to convert these images to a single animated movie (in formats such as GIF and MPG, etc).
}
\usage{
saveMovie(expr, interval = 1, moviename = "movie", movietype = "gif", 
    loop = 0, dev = png, filename = "Rplot", fmt = "\%03d", 
    outdir = tempdir(), para = par(no.readonly = TRUE), ...)
}
\arguments{
  \item{expr}{ an expression to generate animations; use either the animation functions (e.g. \code{brownian.motion()}) in this package or a custom expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}). }
  \item{interval}{ duration between animation frames (unit in seconds) }
  \item{moviename}{ file name of the movie (base only, without extension) }
  \item{movietype}{ format of the movie ('gif', 'mpg', ...; as long as it's supported by ImageMagick) }
  \item{loop}{ iterations of the movie; set iterations to zero to repeat the animation an infinite number of times, otherwise the animation repeats itself up to \code{loop} times (N.B. for GIF only!) } 
  \item{dev}{ a function for a graphical device such as \code{\link[grDevices:png]{png}}, \code{\link[grDevices:png]{jpeg}} and \code{\link[grDevices:png]{bmp}}, etc. }
  \item{filename}{ file name of the sequence of images (`pure' name; without any format or extension) }
  \item{fmt}{ a C-style string formatting command, such as \code{\%3d}  }
  \item{outdir}{ the directory for the movie frames and the movie itself }
  \item{para}{ a list: the graphics parameters to be set before plotting; passed to \code{\link[graphics]{par}} }
  \item{\dots}{ other arguments passed to the graphical device, such as \code{height} and \code{width}, ... }
}
\details{
  The convenience of this function is that it can create a single movie file, however, two drawbacks are obvious too: (1) we need a special (free) software ImageMagick; (2) the speed of the animation cannot be conveniently controlled, as we have specified a fixed \code{interval}. So just go ahead with this function to create your movies if you don't mind these two points. 
}
\value{
An integer indicating failure (-1) or success (0) of the converting (refer to \code{\link[base]{system}}). 
}
\references{
\url{http://www.imagemagick.org/script/convert.php} 

\url{http://animation.yihui.name/animation:start}
}
\author{ Yihui Xie <\url{http://yihui.name}> }
\note{ 
Please make sure ImageMagick has been installed in your system (go to \url{http://www.imagemagick.org} for details), and \code{convert} is in your \code{'PATH'} variable. If ImageMagick is not found, the function will try to install it automatically (for Windows and Mac users only; I have not tested the installer yet!).
}
\seealso{ \code{\link{saveSWF}}, \code{\link[base]{system}}, \code{\link[grDevices]{png}}, \code{\link[grDevices]{jpeg}} and \code{\link[grDevices]{bmp}} }
\examples{
## make sure ImageMagick has been installed in your system 

\dontrun{
saveMovie(for(i in 1:10) plot(runif(10), ylim = 0:1), loop = 1)
oopt = ani.options(nmax = 100)
saveMovie(brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow"),
    width = 600, height = 600)
ani.options(oopt)
}
}
\keyword{ dynamic }
\keyword{ device }
\keyword{ utilities }
