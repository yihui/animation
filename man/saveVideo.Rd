\name{saveVideo}
\alias{saveVideo}
\title{Convert a sequence of images to a video by FFmpeg}
\usage{
saveVideo(expr, video.name = "animation.mp4", img.name = "Rplot", ffmpeg = "ffmpeg", 
    other.opts = "", clean = FALSE, ...)
}
\arguments{
  \item{expr}{the R code to draw (several) plots}

  \item{img.name}{the file name of the sequence of images
  to be generated}

  \item{video.name}{the file name of the output video (e.g.
  \file{animation.mp4} or \file{animation.avi})}

  \item{ffmpeg}{the command to call FFmpeg (e.g.
  \code{"C:/Software/ffmpeg/bin/ffmpeg.exe"} under
  Windows); note the full path of FFmpeg can be
  pre-specified in \code{\link{ani.options}('ffmpeg')}}

  \item{other.opts}{other options to be passed to
  \code{ffmpeg}, e.g. we can specify the bitrate as
  \code{other.opts = "-b 400k"}}

  \item{clean}{whether to remove the sequence of images
  after conversion}

  \item{...}{other arguments to be passed to
  \code{\link{ani.options}}}
}
\value{
  An integer indicating failure (-1) or success (0) of the
  converting (refer to \code{\link[base]{system}}).
}
\description{
  This function opens a graphics device to record the
  images produced in the code \code{expr}, then uses FFmpeg
  to convert these images to a video.
}
\details{
  This function uses \code{\link[base]{system}} to call
  FFmpeg to convert the images to a single video. The
  command line used in this function is: \command{ffmpeg -y
  -r <1/interval> -i <img.name>\%d.<ani.type> other.opts
  video.name}

  where \code{interval} comes from
  \code{ani.options('interval')}, and \code{ani.type} is
  from \code{ani.options('ani.type')}. For more details on
  the numerous options of FFmpeg, please see the reference.
}
\note{
  There are a lot of possibilities in optimizing the video.
  My knowledge on FFmpeg is very limited, hence the default
  output by this function could be of low quality or too
  large. The file \file{presets.xml} of WinFF might be a
  good guide: \url{http://code.google.com/p/winff/}.
}
\examples{
oopts = ani.options(ffmpeg = "D:/Installer/ffmpeg/bin/ffmpeg.exe")
## usually Linux users do not need to worry about the path as long as FFmpeg
## has been installed
if (.Platform$OS.type != "windows") ani.options(ffmpeg = "ffmpeg")

saveVideo({
    par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), tcl = -0.3, cex.axis = 0.8, cex.lab = 0.8, 
        cex.main = 1)
    ani.options(interval = 0.05, nmax = 300)
    brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
}, video.name = "BM.mp4", other.opts = "-b 300k")  # higher bitrate, better quality

ani.options(oopts)
}
\author{
  Yihui Xie <\url{http://yihui.name}>, based on an inital
  version by Thomas Julou \email{thomas.julou@gmail.com}
}
\references{
  \url{http://ffmpeg.org/documentation.html}
}
\seealso{
  \code{\link{saveGIF}}, \code{\link{saveLatex}},
  \code{\link{saveHTML}}, \code{\link{saveSWF}}
}
