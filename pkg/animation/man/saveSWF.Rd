\name{saveSWF}
\alias{saveSWF}
\title{ Convert Images to Flash Animations }
\description{
  This function opens a graphical device first to generate a sequence of images based on \code{expr}, then makes use of the commands in `SWF Tools' (\code{png2swf}, \code{jpeg2swf}, \code{pdf2swf}) to convert these images to a single Flash animation.
}
\usage{
saveSWF(expr, interval = 1, swfname = "movie.swf",
    dev = c("png", "jpeg", "pdf"), filename = "Rplot", fmt = "\%03d",
    outdir = tempdir(), swftools = NULL, para = par(no.readonly = TRUE), ...)
}
\arguments{
 \item{expr}{ an expression to generate animations; use either the animation functions (e.g. \code{brownian.motion()}) in this package or a custom expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}). }
  \item{interval}{ duration between animation frames (unit in seconds) }
  \item{swfname}{ file name of the Flash file }
  \item{dev}{ character: the graphics device to be used. Three choices are available: \code{\link[grDevices:png]{png}}, \code{\link[grDevices:png]{jpeg}} and \code{\link[grDevices]{pdf}}, etc. }
  \item{filename}{ file name of the sequence of images (`pure' name; without any format or extension) }
  \item{fmt}{ a C-style string formatting command, such as `\code{\%3d}'  }
  \item{outdir}{ the directory for the animation frames and the Flash file }
  \item{swftools}{ the path of `SWF Tools', e.g. \file{C:/swftools}. This argument is to make sure that \code{png2swf}, \code{jpeg2swf} and \code{pdf2swf} can be executed correctly. If it is \code{NULL}, it should be guaranteed that these commands can be executed without the path. }
  \item{para}{ a list: the graphics parameters to be set before plotting; passed to \code{\link[graphics]{par}} }
  \item{\dots}{ other arguments passed to the graphical device, such as \code{height} and \code{width}, ... }
}
\value{
An integer indicating failure (-1) or success (0) of the converting (refer to \code{\link[base]{system}}).
}
\references{
\url{http://animation.yihui.name/animation:start\#create_flash_animations}
}
\author{ Yihui Xie }
\note{
Please download the SWF Tools before using this function: \url{http://www.swftools.org}
}
\seealso{ \code{\link{saveMovie}}, \code{\link[base]{system}}, \code{\link[grDevices:png]{png}}, \code{\link[grDevices:png]{jpeg}}, \code{\link[grDevices]{pdf}} }
\examples{
\dontrun{
oopt = ani.options(nmax = 50)
# from png
saveSWF(knn.ani(test = matrix(rnorm(16), ncol = 2),
    cl.pch = c(16, 2)), 1.5, dev = "png", para = list(mar = c(3,
    3, 1, 1.5), mgp = c(1.5, 0.5, 0)), swfname = "kNN.swf")

# from pdf (vector plot!)
ani.options(nmax = 50)
saveSWF(brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow"),
    0.2, "brownian.swf", "pdf", fmt = "")

ani.options(oopt)
}
}
\keyword{ dynamic }
\keyword{ device }
\keyword{ utilities }
