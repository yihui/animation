\name{animation-package}
\alias{animation-package}
\docType{package}
\title{
Statistical Animations Using R
}
\description{
Various functions for animations in statistics which could probably aid in teaching statistics and data analysis. 
}
\details{
\tabular{ll}{
Package: \tab animation\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2008-07-07\cr
License: \tab GPL-2 | GPL-3\cr
}
This package mainly makes use of HTML \& JavaScript and R windows graphics devices (such as \code{\link[grDevices:windows]{x11}}) to demonstrate animations in statistics; other kinds of output such as Flash (SWF) or GIF/MPG animations are also available if necessary software has been installed.
}
\author{
Yihui Xie <\url{http://www.yihui.name}>
}
\references{
AniWiki: Animations in Statistics \url{http://animation.yihui.name}; created and maintained by Yihui Xie
}
\keyword{ package }
\keyword{ dynamic }
\keyword{ device }
\keyword{ dplot } 

\examples{
\dontrun{
#############################################################
# (1) Animations in HTML pages
# create an animation page in the tempdir() and auto-browse it 
# Brownian Motion 
oopt = ani.options(interval = 0.05, nmax = 100, ani.dev = png,
    ani.type = "png",
    title = "Demonstration of Brownian Motion",
    description = "Random walk on the 2D plane: for each point
    (x, y), x = x + rnorm(1) and y = y + rnorm(1).")
ani.start()
opar = par(mar = c(3, 3, 2, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
    cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
    main = "Demonstration of Brownian Motion",)
par(opar)
ani.stop()
ani.options(oopt)

#############################################################
# (2) Animations inside R windows graphics devices
# Bootstrapping
oopt = ani.options(interval = 0.3, nmax = 50)
boot.iid()
ani.options(oopt)

#############################################################
# (3) GIF animations
oopt = ani.options(interval = 0, nmax = 100)
saveMovie(brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow"),
    interval = 0.05, outdir = getwd(), width = 600, height = 600)
ani.options(oopt)

#############################################################
# (4) Flash animations
oopt = ani.options(nmax = 100, interval = 0)
saveSWF(buffon.needle(type = "S"), para = list(mar = c(3, 2.5, 1, 0.2),
    pch = 20, mgp = c(1.5, 0.5, 0)), dev = "pdf", swfname = "buffon.swf",
    outdir = getwd(), interval = 0.1)
ani.options(oopt)
}
}
