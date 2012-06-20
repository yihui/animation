\name{saveHTML}
\alias{saveHTML}
\title{Insert animations into an HTML page}
\usage{
saveHTML(expr, img.name = "Rplot", global.opts = "", single.opts = "", 
    ...)
}
\arguments{
  \item{expr}{an R expression to be evaluated to create a
  sequence of images}

  \item{img.name}{the filename of the images (the real
  output will be like \file{img.name1.png},
  \file{img.name2.png}, ...); this name has to be different
  for different animations, since it will be used as the
  identifiers for each animation; make it as unique as
  possible; meanwhile, the following characters in
  \code{img.name} will be replaced by \code{_} to make it a
  legal jQuery string:

  \verb{!"#$\%&'()*+,./:;?@[\]^`{|}~}}

  \item{global.opts}{a string: the global options of the
  animation; e.g. we can specify the default theme to be
  blue using \verb{$.fn.scianimator.defaults.theme =
  'blue';} note these options must be legal JavaScript
  expressions (ended by \code{';'})}

  \item{single.opts}{the options for each single animation
  (if there are multiple ones in one HTML page), e.g. to
  use the dark theme and text labels for buttons:

  \verb{'utf8': false, 'theme': 'dark'}

  or to remove the navigator panel (the navigator can
  affect the smoothness of the animation when the playing
  speed is extremely fast (e.g.  \code{interval} less than
  0.05 seconds)):

  \verb{'controls': ['first', 'previous', 'play', 'next',
  'last', 'loop', 'speed']}

  see the reference for a complete list of available
  options}

  \item{...}{other arguments to be passed to
  \code{\link{ani.options}} to animation options such as
  the time interval between image frames}
}
\value{
  the path of the output
}
\description{
  This function first records all the plots in the R
  expression as bitmap images, then inserts them into an
  HTML page and finally creates the animation using the
  SciAnimator library.
}
\details{
  This is a much better version than
  \code{\link{ani.start}} and \code{\link{ani.stop}}, and
  all users are encouraged to try this function when
  creating HTML animation pages. It mainly uses the
  SciAnimator library, which is based on jQuery. It has a
  neat interface (both technically and visually) and is
  much easier to use or extend. Moreover, this function
  allows multiple animations in a single HTML page -- just
  use the same filename for the HTML page (specified in
  \code{ani.options('htmlfile')}).

  Optionally the source code and some session information
  can be added below the animations for the sake of
  reproducibility (specified by the option
  \code{ani.options('verbose')} -- if \code{TRUE}, the
  description, loaded packages, the code to produce the
  animation, as well as a part of
  \code{\link[utils]{sessionInfo}()} will be written in the
  bottom of the animation; the R code will be highlighted
  using the SyntaxHighlighter library for better reading
  experience).
}
\note{
  Microsoft IE might restrict the HTML page from running
  JavaScript and try to ``protect your security'' when you
  view the animation page, but this is not really a
  security problem.

  When you want to publish the HTML page on the web, you
  have to upload the associated \file{css} and \file{js}
  folders with the HTML file as well as the images.

  For \code{\link{saveHTML}},
  \code{ani.options('description')} can be a character
  vector, in which case this vector will be pasted into a
  scalar; use \code{"\n\n"} in the string to separate
  paragraphs (see the first example below).

  For the users who do not have R at hand, there is a demo
  in \code{system.file('misc', 'Rweb', 'demo.html', package
  = 'animation')} to show how to create animations online
  without R being installed locally. It depends, however,
  on whether the Rweb service can be provided for public
  use in a long period (currently we are using the Rweb at
  Tama University).  See the last example below.
}
\examples{
## A quick and dirty demo
saveHTML({
    par(mar = c(4, 4, 0.5, 0.5))
    for (i in 1:20) {
        plot(runif(20), ylim = c(0, 1))
        ani.pause()
    }
}, img.name = "unif_plot", imgdir = "unif_dir", htmlfile = "random.html", autobrowse = FALSE, 
    title = "Demo of 20 uniform random numbers", description = c("This is a silly example.\\n\\n", 
        "You can describe it in more detail.", "For example, bla bla..."))



## we can merge another animation into the former page as long as 'htmlfile' is
## the same; this time I don't want the animation to autoplay, and will use
## text labels for the buttons (instead of UTF-8 symbols)
saveHTML({
    par(mar = c(4, 4, 0.5, 0.5))
    ani.options(interval = 0.5)
    for (i in 1:10) {
        plot(rnorm(50), ylim = c(-3, 3))
        ani.pause()
    }
}, img.name = "norm_plot", single.opts = "'utf8': false", autoplay = FALSE, interval = 0.5, 
    imgdir = "norm_dir", htmlfile = "random.html", ani.height = 400, ani.width = 600, 
    title = "Demo of 50 Normal random numbers", description = c("When you write a long long long long description,", 
        "R will try to wrap the words automatically.", "Oh, really?!"))



## use the function brownian.motion() in this package; note this page is
## created in 'index.html' under ani.options('outdir')
saveHTML({
    par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), tcl = -0.3, cex.axis = 0.8, cex.lab = 0.8, 
        cex.main = 1)
    ani.options(interval = 0.05, nmax = ifelse(interactive(), 150, 2))
    brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
}, img.name = "brownian_motion_a", htmlfile = "index.html", description = c("Random walk of 10 points on the 2D plane:", 
    "for each point (x, y),", "x = x + rnorm(1) and y = y + rnorm(1)."))



## we may feel that the navigation panel is too wide, so let's remove it in
## this example; the default value of 'controls' is: ['first', 'previous',
## 'play', 'next', 'last', 'navigator', 'loop', 'speed'], among which we need
## to remove 'navigator'
saveHTML({
    par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), tcl = -0.3, cex.axis = 0.8, cex.lab = 0.8, 
        cex.main = 1)
    ani.options(interval = 0.05, nmax = ifelse(interactive(), 150, 2))
    brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
}, img.name = "brownian_motion_b", htmlfile = "index.html", single.opts = "'controls': ['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'], 'delayMin': 0", 
    description = c("Random walk of 10 points on the 2D plane", "(without the navigation panel)"))


## use Rweb to create animations
if (interactive()) browseURL(system.file("misc", "Rweb", "demo.html", 
    package = "animation"))
}
\author{
  Yihui Xie <\url{http://yihui.name}>
}
\references{
  \url{https://github.com/brentertz/scianimator}
}
\seealso{
  \code{\link{saveGIF}}, \code{\link{saveSWF}},
  \code{\link{saveLatex}}, \code{\link{saveVideo}};
  \code{\link{ani.start}}, \code{\link{ani.stop}} (early
  versions of HTML animations)
}
