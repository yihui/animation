\name{ani.options}
\alias{ani.options}
\title{Set or query animation options}
\usage{
ani.options(...)
}
\arguments{
  \item{...}{arguments in \code{tag = value} form, or a
  list of tagged values.  The tags usually come from the
  animation parameters described below, but they are not
  restricted to these tags (any tag can be used; this is
  similar to \code{\link{options}}).}
}
\value{
\code{ani.options()} returns a list containing the options:
when parameters are set, their former values are returned
in an invisible named list.  Such a list can be passed as
an argument to \code{\link{ani.options}} to restore the
parameter values.

\code{ani.options('tag')} returns the value of the option
\code{'tag'}.

\code{ani.options(c('tag1', 'tag2'))} or
\code{ani.options('tag1', 'tag2')} returns a list
containing the corresponding options.
}
\description{
There are various parameters that control the behaviour of
the animation, such as time interval, maximum number of
animation frames, height and width, etc.
}
\note{
Please note that \code{nmax} is not always equal to the
number of animation frames. Sometimes there is more than
one frame recorded in a single step of a loop, for
instance, there are 2 frames generated in each step of
\code{\link{kmeans.ani}}, and 4 frames in
\code{\link{knn.ani}}, etc; whereas for
\code{\link{newton.method}}, the number of animation frames
is not definite, because there are other criteria to break
the loop.

This function can be used for almost all the animation
functions such as \code{\link{brownian.motion}},
\code{\link{boot.iid}}, \code{\link{buffon.needle}},
\code{\link{cv.ani}}, \code{\link{flip.coin}},
\code{\link{kmeans.ani}}, \code{\link{knn.ani}}, etc. Most
of the options here will affect the behaviour of animations
of the formats HTML, GIF, SWF and PDF; on-screen animations
are only affected by \code{interval} and \code{nmax}.
}
\section{Animation options}{
  The supported animation parameters: \describe{

  \item{interval}{ a positive number to set the time
  interval of the animation (unit in seconds); default to
  be 1. }

  \item{nmax}{ maximum number of steps in a loop (e.g.
  iterations) to create animation frames. Note: the actual
  number of frames can be less than this number, depending
  on specific animations. Default to be 50.}

  \item{ani.width, ani.height}{ width and height of image
  frames (unit in px); see graphics devices like
  \code{\link{png}}, \code{\link{jpeg}}, ...; default to be
  480. NB: for different graphics devices, the units of
  these values might be different, e.g. PDF devices usually
  use inches, whereas bitmap devices often use pixels.}

  \item{imgdir}{character: the name of the directory (a
  relative path) for images when creating HTML animation
  pages; default to be \code{'images'}.}

  \item{htmlfile}{character: name of the target HTML main
  file (without path name; basename only; default to be
  \code{'index.html'})}

  \item{ani.dev}{a function or a function name: the
  graphics device; e.g.  (\code{\link{png}},
  \code{\link{pdf}}, ...); default to be \code{'png'}}

  \item{ani.type}{character: image format for animation
  frames, e.g.  \code{png}, \code{jpeg}, ...; default to be
  \code{'png'}; this will be used as the file extension of
  images, so don't forget to change this option as well
  when you changed the option \code{ani.dev}}

  \item{title, description}{character: the title and
  description of the animation in the HTML page created by
  \code{\link{saveHTML}}}

  \item{verbose}{ logical or character: if \code{TRUE},
  write a footer part in the HTML page containing detailed
  technical information; if given a character string, it
  will be used as the footer message; in other cases, the
  footer of the page will be blank.}

  \item{loop}{whether to iterate or not (default
  \code{TRUE} to iterate for infinite times)}

  \item{autobrowse}{logical: whether auto-browse the
  animation page immediately after it is created? (default
  to be \code{interactive()})}

  \item{autoplay}{logical: whether to autoplay the
  animation when the HTML page is loaded (default to be
  \code{TRUE}); only applicable to \code{\link{saveHTML}}}

  \item{use.dev}{ whether to use the graphics device
  specified in \code{ani.options('ani.dev')} (default to be
  \code{TRUE}); if \code{FALSE}, we need to generate image
  files by our own approaches in the expression \code{expr}
  (see functions \code{\link{saveHTML}},
  \code{\link{saveGIF}}, \code{\link{saveLatex}} and
  \code{\link{saveSWF}}); this can be useful when the
  output cannot be captured by standard R graphics devices
  -- a typical example is the \pkg{rgl} graphics (we can
  use \code{rgl.snapshot} to capture \pkg{rgl} graphics to
  png files, or \code{rgl.postscript} to save plots as
  postscript/pdf; see \code{demo('rgl_animation')} or
  \code{demo('use_Cairo')} for examples or the last example
  below). Note, however, we do not really have to create
  the images using R graphics devices -- see
  \code{demo('flowers')} on how to download images from the
  Internet and create an HTML animation page!}

  }
}

\section{Hidden options}{
  There are a couple of ``hidden'' options which are
  designed to facilitate the usage of some functions but
  are not initialized like the above options when the
  package is loaded, including:

  \describe{

  \item{convert}{this option will be checked first when
  calling \code{\link{im.convert}} (or
  \code{\link{saveGIF}}) to see if it contains the path to
  \file{convert.exe}; we can specify it beforehand to save
  the efforts in searching for \file{convert.exe} in
  ImageMagick under Windows.  For example,
  \code{ani.options(convert = 'c:/program
  files/imagemagick/convert.exe')}; note this option also
  works for Mac and Linux (see \code{help(im.convert)})}

  \item{swftools}{this can help \code{\link{saveSWF}} save
  the efforts of searching for the software package ``SWF
  Tools'' under Windows; e.g. we can specify
  \code{ani.options(swftools = 'c:/program
  files/swftools')} in advance}

  \item{img.fmt}{the value of this option can be used to
  determine the image filename format when we want to use
  custom graphics devices to record images, e.g. in
  \code{\link{saveLatex}}, if \code{ani.options('use.dev')
  == FALSE}, then \code{ani.options('img.fmt')} will be a
  string like \code{'path/to/output/img.name\%d.png'}, so
  we can use it to generate file names in the argument
  \code{expr}; see \code{demo('rgl_animation')} for example
  or the last example below}

  \item{qpdf}{the path of the program \command{qpdf}, e.g.
  \code{ani.options(qpdf =
  'C:/Software/qpdf/bin/qpdf.exe')}; \command{qpdf} is
  mainly used to compress PDF files in this package, and it
  is a smaller tool than \command{pdftk}. It is recommended
  over \command{pdftk} especially under Linux, because
  tests show that \command{pdftk} does not work well under
  Linux in compressing PDF files, while \command{qpdf} is
  much better.}

  \item{pdftk}{the path of the program \command{Pdftk},
  e.g.  \code{ani.options(pdftk = 'C:/Software/pdftk.exe')}
  or \code{ani.options(pdftk = '/home/john/bin/pdftk')};
  \command{pdftk} will be used to compress the PDF graphics
  output in the function \code{\link{pdftk}}; compression
  will not be tried if this options is \code{NULL}. This
  option will only affect \code{\link{saveGIF}},
  \code{\link{saveLatex}} and \code{\link{saveSWF}} when
  \code{ani.options('ani.type')} is \code{'pdf'}.}

  \item{ffmpeg}{the path of the progam \command{ffmpeg},
  e.g.  \code{ani.options(ffmpeg =
  'C:/Software/ffmpeg/bin/ffmpeg.exe')}; FFmpeg is used to
  convert a sequence of images to a video. See
  \code{\link{saveVideo}}.}

  }
}
\examples{
## see the first example in help(animation) on how to set and restore animation options

## use the PDF device: remember to set 'ani.type' accordingly
oopt = ani.options(ani.dev = 'pdf', ani.type = 'pdf', ani.height = 5, ani.width = 7)

## use the Cairo PDF device
## if (require('Cairo')) {
##     ani.options(ani.dev = CairoPDF, ani.type = 'pdf',
##                 ani.height = 6, ani.width = 6)
## }

## don't loop for GIF/HTML animations
ani.options(loop = FALSE)

## don't try to open the output automatically
ani.options(autobrowse = FALSE)

## it's a good habit to restore the options in the end so that other code will not be affected
ani.options(oopt)

## how to make use of the hidden option 'img.fmt'
saveHTML(expr = {
  png(ani.options('img.fmt'))
  for(i in 1:5) plot(runif(10))
  dev.off()
}, img.name='custom_plot', use.dev = FALSE, ani.type='png',
         description="Note how we use our own graphics device in 'expr'.",
         htmlfile='custom_device.html')
}
\author{
Yihui Xie
}
\seealso{
\code{\link{options}}, \code{\link{dev.interactive}},
\code{\link{saveHTML}}, \code{\link{saveGIF}},
\code{\link{saveLatex}}, \code{\link{saveSWF}},
\code{\link{pdftk}}

\url{http://qpdf.sourceforge.net/}

\url{http://www.pdflabs.com/docs/pdftk-man-page/}
}

