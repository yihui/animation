\docType{package}
\name{animation-package}
\alias{animation}
\alias{animation-package}
\title{A Gallery of Animations in Statistics and Utilities to Create Animations}
\description{
This package contains a variety functions for animations in
statistics which could probably aid in teaching statistics
and data analysis; it also has several utilities to export
R animations to other formats.
}
\details{
This package mainly makes use of HTML & JavaScript and R
windows graphics devices (such as \code{\link{x11}}) to
demonstrate animations in statistics; other kinds of output
such as Flash (SWF) or GIF animations or PDF animations are
also available if required software packages have been
installed. See below for details on each type of animation.
}
\note{
Bug reports and feature requests can be sent to
\url{https://github.com/yihui/animation/issues}.
}
\section{On-screen Animations}{
  It's natural and easy to create an animation in R using
  the windows graphics device, e.g. in \code{x11()} or
  \code{windows()}. A basic scheme is like the Example 1
  (see below).

  On-screen animations do not depend on any third-party
  software, but the rendering speed of the windows graphics
  devices is often slow, so the animation might not be
  smooth (especially under Linux and Mac OS).
}

\section{HTML Pages}{
  The generation of HTML animation pages does not rely on
  any third-party software either, and we only need a web
  browser to watch the animation. See
  \code{\link{saveHTML}}.

  The HTML interface is just like a movie player -- it
  comes with a series of buttons to control the animation
  (play, stop, next, previous, ...).

  This HTML approach is flexible enough to be used even in
  Rweb, which means we do not really have to install R to
  create animations! There is a demo in
  \code{system.file('misc', 'Rweb', 'demo.html', package =
  'animation')}. We can use \code{\link{saveHTML}} to
  create animations directly in Rweb; this can be helpful
  when we do not have R or cannot install R.
}

\section{GIF Animations}{
  If ImageMagick or GraphicsMagick has been installed, we
  can use \code{\link{im.convert}} or
  \code{\link{gm.convert}} to create a GIF animation
  (combining several R plots together), or use
  \code{\link{saveGIF}} to create a GIF animation from an R
  code chunk.
}

\section{Flash Animations}{
  If SWF Tools has been installed, we can use
  \code{\link{saveSWF}} to create a Flash animation (again,
  combining R plots).
}

\section{PDF Animations}{
  If LaTeX is present in the system, we can use
  \code{\link{saveLatex}} to insert animations into a PDF
  document and watch the animation using the Adobe reader.

  The animation is created by the LaTeX package
  \code{animate}.
}

\section{Video}{
  The function \code{\link{saveVideo}} can use FFmpeg to
  convert images to various video formats (e.g. \file{mp4},
  \file{avi} and \file{wmv}, etc).
}
\examples{
### 1. How to setup a simple animation ###

## set some options first
oopt = ani.options(interval = 0.2, nmax = 10)
## use a loop to create images one by one
for (i in 1:ani.options('nmax')) {
  plot(rnorm(30))
  ani.pause()   ## pause for a while ('interval')
}
## restore the options
ani.options(oopt)

## see ?ani.record for an alternative way to set up an animation

### 2. Animations in HTML pages ###
saveHTML({
  ani.options(interval = 0.05, nmax = 30)
  par(mar = c(3, 3, 2, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
      cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
  brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow',
                  main = 'Demonstration of Brownian Motion')
}, img.name = 'bm_plot', title = 'Demonstration of Brownian Motion',
         description = c('Random walk on the 2D plane: for each point',
                         '(x, y), x = x + rnorm(1) and y = y + rnorm(1).'))

### 3. GIF animations ###
saveGIF({
  ani.options(nmax = 30)
  brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow')
}, interval = 0.05, movie.name = 'bm_demo.gif', ani.width = 600, ani.height = 600)


### 4. Flash animations ###
saveSWF({
  par(mar = c(3, 2.5, 1, 0.2), pch = 20, mgp = c(1.5, 0.5, 0))
  buffon.needle(type = 'S')
}, ani.dev = 'pdf', ani.type = 'pdf', swf.name = 'buffon.swf',
        interval = 0.1, nmax = 40, ani.height = 7, ani.width = 7)


### 5. PDF animations ###
saveLatex({
  par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), tcl = -0.3,
      cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
  brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow', main = 'Brownian Motion')
}, img.name = 'BM_plot',
          latex.filename = ifelse(interactive(), 'brownian_motion.tex', ''),
          interval = 0.1, nmax = 20)

}
\author{
Yihui Xie
}
\references{
The associated website for this package:
\url{http://vis.supstat.com}

Yihui Xie and Xiaoyue Cheng. animation: A package for
statistical animations. \emph{R News}, \bold{8}(2):23--27,
October 2008.  URL:
\url{http://CRAN.R-project.org/doc/Rnews/Rnews_2008-2.pdf}

(NB: some functions mentioned in the above article have
been slightly modified; see the help pages for the
up-to-date usage.)

Yihui Xie (2013). animation: An R Package for Creating
Animations and Demonstrating Statistical Methods.
\emph{Journal of Statistical Software}, \bold{53}(1), 1-27.
URL \url{http://www.jstatsoft.org/v53/i01/}.
}
\seealso{
\code{\link{saveHTML}}, \code{\link{saveGIF}},
\code{\link{saveSWF}}, \code{\link{saveVideo}},
\code{\link{saveLatex}}
}
\keyword{device}
\keyword{dplot}
\keyword{dynamic}
\keyword{package}

