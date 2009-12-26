\name{saveLatex}
\alias{saveLatex}
\title{
Insert Animations into A LaTeX Document and Compile It
}
\description{
Record animation frames and insert them into a LaTeX document with the \code{animate} package. Compile the document if an appropriate LaTeX command is provided.
}
\usage{
saveLatex(expr, interval = ani.options("interval"), 
    nmax = ani.options("nmax"), ani.dev = "pdf", 
    outdir = ani.options("outdir"), ani.basename = "Rplot", 
    ani.ext = "pdf", num = ifelse(ani.ext == "pdf", "", "\%d"), 
    ani.first = par(), ani.opts = "controls,width=\\\\textwidth", 
    centering = "\\\\centering", caption = NULL, 
    label = NULL, pkg.opts = NULL, documentclass = "article", 
    latex.filename = "animation.tex", pdflatex = "pdflatex", 
    install.animate = TRUE, ...)
}
\arguments{
  \item{expr}{ an expression to generate animations; use either the animation functions (e.g. \code{brownian.motion()}) in this package or a custom expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}). }
  \item{interval}{ duration between animation frames (unit in seconds) }
  \item{nmax,outdir}{
maximum number of animatio frames and the directory for output (see \code{\link{ani.options}})
}
  \item{ani.dev}{
the graphics device to be used to record image frames
}
  \item{ani.basename,ani.ext}{
basename and extension of file names of animation frames
}
  \item{num}{
the format for page numbers
}
  \item{ani.first}{
  an expression to be evaluated before plotting (this will be useful to set graphical parameters in advance, e.g. \code{ani.first = par(pch = 20)})  
}
  \item{ani.opts}{
  options to control the behavior of the animation (passed to the LaTeX macro \code{"\\animategraphics"})
}
  \item{centering}{
the macro to center the graph (can be \code{NULL})
}
  \item{caption,label}{
caption and label for the graphics in the figure environment
}
  \item{pkg.opts}{
global options for the \code{animate} package
}
  \item{documentclass}{
LaTeX document class
}
  \item{latex.filename}{
file name of the LaTeX document; if an empty string \code{""}, the LaTeX code will be printed in the console and hence not compiled
}
  \item{pdflatex}{
the command for pdfLaTeX (set to \code{NULL} to ignore the compiling)
}
  \item{install.animate}{
copy the LaTeX style files \file{animate.sty} and \file{animfp.sty} to \code{outdir}? If you have not installed the LaTeX package \code{animate}, it suffices just to copy these to files.
}
  \item{\dots}{
other arguments passed to the graphics device \code{ani.dev}, e.g. height and width
}
}
\details{
This is actually a wrapper to generate a LaTeX document using R. The document uses the LaTeX package called \code{animate} to insert animations into PDF's. When we pass an R expression to this function, the expression will be evaluated and recorded by a grahpics device (typically \code{\link[grDevices]{png}} and \code{\link[grDevices]{pdf}}). At last, a LaTeX document will be created and compiled if an appropriate LaTeX command is provided. And the final PDF output will be opened with the PDF viewer set in \code{getOption("pdfviewer")} if \code{ani.options("autobrowse") == TRUE}.
}
\value{
Invisible \code{NULL}
}
\references{
To know more about the \code{animate} package, please refer to \url{http://www.ctan.org/tex-archive/macros/latex/contrib/animate/}. There are a lot of options can be set in \code{ani.opts} and \code{pkg.opts}.
}
\author{
Yihui Xie <\url{http://yihui.name}>
}
\note{
When using \code{ani.dev = "png"} or other bitmap graphics devices, all the images can be recorded only if a proper \code{num} is provided; typically it must be \code{"\%d"}.

PDF devices are recommended because of their high quality and usually they are more friendly to LaTeX. But sometimes the size of PDF files is much larger.
}
\seealso{
\code{\link{saveMovie}} to convert image frames to a single GIF/MPEG file; \code{\link{saveSWF}} to convert images to Flash
}
\examples{
\dontrun{

oopt = ani.options(interval = 0.1, nmax = 100)
## brownian motion: note the 'loop' option in ani.opts
##     and how to set graphics parameters with 'ani.first'
saveLatex({
    brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow", 
        main = "Demonstration of Brownian Motion")
}, ani.basename = "BM", ani.opts = "controls,loop,width=0.8\\\\textwidth", 
    ani.first = par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), 
        tcl = -0.3, cex.axis = 0.8, cex.lab = 0.8, cex.main = 1), 
    latex.filename = "brownian.motion.tex")
ani.options(oopt) 
}
}
\keyword{ dynamic }
\keyword{ device }
\keyword{ utilities }
