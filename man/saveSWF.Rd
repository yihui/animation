\name{saveSWF}
\alias{saveSWF}
\title{Convert images to Flash animations}
\usage{
saveSWF(expr, swf.name = "animation.swf", img.name = "Rplot", swftools = NULL, 
    ...)
}
\arguments{
  \item{expr}{an expression to generate animations; use
  either the animation functions (e.g.
  \code{brownian.motion()}) in this package or a custom
  expression (e.g. \code{for(i in 1:10) plot(runif(10),
  ylim = 0:1)}).}

  \item{img.name}{file name of the sequence of images
  (`pure' name; without any format or extension)}

  \item{swf.name}{file name of the Flash file}

  \item{swftools}{the path of `SWF Tools', e.g.
  \file{C:/swftools}. This argument is to make sure that
  \code{png2swf}, \code{jpeg2swf} and \code{pdf2swf} can be
  executed correctly. If it is \code{NULL}, it should be
  guaranteed that these commands can be executed without
  the path; anyway, this function will try to find SWF
  Tools from Windows registry even if it is not in the PATH
  variable.}

  \item{...}{other arguments passed to
  \code{\link{ani.options}}, e.g.  \code{ani.height} and
  \code{ani.width}, ...}
}
\value{
  An integer indicating failure (-1) or success (0) of the
  converting (refer to \code{\link[base]{system}}).
}
\description{
  This function opens a graphical device first to generate
  a sequence of images based on \code{expr}, then makes use
  of the commands in `SWF Tools' (\command{png2swf},
  \command{jpeg2swf}, \command{pdf2swf}) to convert these
  images to a single Flash animation.
}
\note{
  Please download and install the SWF Tools before using
  this function: \url{http://www.swftools.org}

  We can also set the path to SWF Tools by
  \code{ani.options(swftools = 'path/to/swftools')}.

  \code{ani.options('ani.type')} can only be one of
  \code{png}, \code{pdf} and \code{jpeg}.

  Also note that PDF graphics can be compressed using qpdf
  or Pdftk (if either one is installed and
  \code{ani.options('qpdf')} or \code{ani.options('pdftk')}
  has been set); see \code{\link{qpdf}} or
  \code{\link{pdftk}}.
}
\examples{
## from png to swf
saveSWF({
    par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
    knn.ani(test = matrix(rnorm(16), ncol = 2), cl.pch = c(16, 2))
}, swf.name = "kNN.swf", interval = 1.5, nmax = ifelse(interactive(), 40, 2))

## from pdf (vector plot) to swf; can set the option 'pdftk' to compress PDF
saveSWF({
    brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
}, swf.name = "brownian.swf", interval = 0.2, nmax = 30, ani.dev = "pdf", ani.type = "pdf", 
    ani.height = 6, ani.width = 6)

}
\author{
  Yihui Xie <\url{http://yihui.name}>
}
\references{
  \url{http://animation.yihui.name/animation:start#create_flash_animations}
}
\seealso{
  \code{\link{saveGIF}}, \code{\link{saveLatex}},
  \code{\link{saveHTML}}, \code{\link{saveVideo}},
  \code{\link[base]{system}}, \code{\link[grDevices]{png}},
  \code{\link[grDevices]{jpeg}},
  \code{\link[grDevices]{pdf}}, \code{\link{qpdf}},
  \code{\link{pdftk}}
}
\keyword{device}
\keyword{dynamic}
\keyword{utilities}
