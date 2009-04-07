\name{ani.options}
\alias{ani.options}
\title{ Set or Query Animation Parameters}
\description{
  Set or query various parameters that control the behaviour of the animation, such as time interval, maximum frames, height and width, etc. This function is based on \code{\link[base]{options}} to set an option \code{ani} which is a list containing the animation parameters.
}
\usage{
ani.options(...)
}
\arguments{
  \item{\dots}{ arguments in \code{tag = value} form, or a list of tagged values. 
          The tags must come from the animation parameters described
          below. }
}

\value{
a list containing the options.

When parameters are set, their former values are returned in an
     invisible named list.  Such a list can be passed as an argument to
     \code{\link{ani.options}} to restore the parameter values.

}

\section{Animation Parameters}{
\describe{
  \item{interval}{ a positive number to set the time interval of the animation (unit in seconds). }
  \item{nmax}{ maximum number of steps for a loop (e.g. iterations) to create animation frames. Note: the actual number of frames can be less than this number, depending on specific animations.}
  \item{ani.width, ani.height}{ width and height of image frames (unit in px); see graphics devices like \code{\link[grDevices]{png}}, \code{\link[grDevices:png]{jpeg}}, ...}
  \item{outdir}{character: specify the output dir if we want to create HTML animation pages; default to be \code{\link[base:tempfile]{tempdir}}.}
  \item{filename}{character: name of the target HTML main file}
  \item{withprompt}{character: prompt to display while using \code{\link{ani.start}} (restore with \code{\link{ani.stop}})}
  \item{ani.type}{character: image format for animation frames, e.g. \code{png}, \code{jpg}, ...}
  \item{ani.dev}{function: the graphics device; e.g. (\code{\link[grDevices]{png}}, \code{\link[grDevices:png]{jpeg}}, ...)}
  \item{title}{character: the title of animation }
  \item{description}{character: a description about the animation }
  \item{footer}{ logical: if \code{TRUE}, write a foot part in the HTML page containing information such as date/time of creation; else don't write.}
  \item{autobrowse}{logical: whether auto-browse the animation page immediately after it is created?}
}
}
\author{ Yihui Xie }
\note{ 
Please note that \code{nmax} is usually equal to the number of animation frames (e.g. for \code{\link{brownian.motion}}) but not \emph{always}! The reason is that sometimes there are more than one frame recorded in a single step of a loop, for instance, there are 2 frames generated in each step of \code{\link{kmeans.ani}}, and 4 frames in \code{\link{knn.ani}}, etc. 

This function can be used for almost all the animation functions such as \code{\link{brownian.motion}}, \code{\link{boot.iid}}, \code{\link{buffon.needle}}, \code{\link{cv.ani}}, \code{\link{flip.coin}}, \code{\link{kmeans.ani}}, \code{\link{knn.ani}}, etc. All the parameters will affect the behaviour of HTML animations, but only \code{interval} will affect animations in windows graphics device.
}
\seealso{
\code{\link[base]{options}}
}
\references{
\url{http://animation.yihui.name/animation:options}
}
\examples{
\dontrun{
# store the old option to restore it later
oopt = ani.options(interval = 0.05, nmax = 100, ani.dev = png, 
    ani.type = "png")
ani.start() 
opar = par(mar = c(3, 3, 2, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
    cex.axis = 0.8, cex.lab = 0.8, cex.main = 1) 
brownian.motion( pch = 21, cex = 5, col = "red", bg = "yellow",
    main = "Demonstration of Brownian Motion",)
par(opar)
ani.stop() 
ani.options(oopt)
}
}
\keyword{ misc }

