#' A Gallery of Animations in Statistics and Utilities to Create Animations
#'
#' This package contains a variety functions for animations in statistics which
#' could probably aid in teaching statistics and data analysis; it also has
#' several utilities to export R animations to other formats.
#'
#' This package mainly makes use of HTML & JavaScript and R windows graphics
#' devices (such as \code{\link{x11}}) to demonstrate animations in statistics;
#' other kinds of output such as Flash (SWF) or GIF animations or PDF animations
#' are also available if required software packages have been installed. See
#' below for details on each type of animation.
#'
#' @section On-screen Animations: It's natural and easy to create an animation
#'   in R using the windows graphics device, e.g. in \code{x11()} or
#'   \code{windows()}. A basic scheme is like the Example 1 (see below).
#'
#'   On-screen animations do not depend on any third-party software, but the
#'   rendering speed of the windows graphics devices is often slow, so the
#'   animation might not be smooth (especially under Linux and Mac OS).
#'
#' @section HTML Pages: The generation of HTML animation pages does not rely on
#'   any third-party software either, and we only need a web browser to watch
#'   the animation. See \code{\link{saveHTML}}.
#'
#'   The HTML interface is just like a movie player -- it comes with a series of
#'   buttons to control the animation (play, stop, next, previous, ...).
#'
#'   This HTML approach is flexible enough to be used even in Rweb, which means
#'   we do not really have to install R to create animations! There is a demo in
#'   \code{system.file('misc', 'Rweb', 'demo.html', package = 'animation')}. We
#'   can use \code{\link{saveHTML}} to create animations directly in Rweb; this
#'   can be helpful when we do not have R or cannot install R.
#'
#' @section GIF Animations: If ImageMagick or GraphicsMagick has been installed,
#'   we can use \code{\link{im.convert}} or \code{\link{gm.convert}} to create a
#'   GIF animation (combining several R plots together), or use
#'   \code{\link{saveGIF}} to create a GIF animation from an R code chunk.
#'
#' @section Flash Animations: If SWF Tools has been installed, we can use
#'   \code{\link{saveSWF}} to create a Flash animation (again, combining R
#'   plots).
#'
#' @section PDF Animations: If LaTeX is present in the system, we can use
#'   \code{\link{saveLatex}} to insert animations into a PDF document and watch
#'   the animation using the Adobe reader.
#'
#'   The animation is created by the LaTeX package \code{animate}.
#'
#' @section Video: The function \code{\link{saveVideo}} can use FFmpeg to
#'   convert images to various video formats (e.g. \file{mp4}, \file{avi} and
#'   \file{wmv}, etc).
#' @name animation-package
#' @aliases animation
#' @docType package
#' @author Yihui Xie
#' @note Bug reports and feature requests can be sent to
#'   \url{https://github.com/yihui/animation/issues}.
#' @references The associated website for this package:
#'   \url{http://vis.supstat.com}
#'
#'   Yihui Xie and Xiaoyue Cheng. animation: A package for statistical
#'   animations. \emph{R News}, \bold{8}(2):23--27, October 2008.  URL:
#'   \url{http://CRAN.R-project.org/doc/Rnews/Rnews_2008-2.pdf}
#'
#'   (NB: some functions mentioned in the above article have been slightly
#'   modified; see the help pages for the up-to-date usage.)
#'
#'   Yihui Xie (2013). animation: An R Package for Creating Animations and
#'   Demonstrating Statistical Methods. \emph{Journal of Statistical Software},
#'   \bold{53}(1), 1-27. URL \url{http://www.jstatsoft.org/v53/i01/}.
#' @seealso \code{\link{saveHTML}}, \code{\link{saveGIF}},
#'   \code{\link{saveSWF}}, \code{\link{saveVideo}}, \code{\link{saveLatex}}
#' @import datasets grDevices graphics stats utils
#' @example inst/examples/animation-package-ex.R
NULL

#' Word counts of a speech by the Chinese President Hu
#'
#' This speech came on the 30th anniversary of China's economic reform in 1978.
#'
#' On Dec 18, 2008, Chinese President Hu gave a speech on the 30th anniversary
#' of China's economic reform in 1978, and this data has recorded the number of
#' words used in each paragraph of his speech.
#'
#' @name HuSpeech
#' @docType data
#' @format int [1:75] 119 175 222 204 276 168 257 89 61 288 ...
#' @source The full text of speech is at
#'   \url{http://cpc.people.com.cn/GB/64093/64094/8544901.html}
#' @examples
#' ## clear pattern: 1/3 short, 1/3 long, 1/3 short again
#' plot(HuSpeech, type = 'b', pch = 20, xlab = 'paragraph index',
#'     ylab = 'word count')
#' ## see ?moving.block for an animation example
NULL

#' Word counts of a speech by the US President Obama
#'
#' This data recorded the number of words in each paragraph of Barack Obama's
#' speech in Chicago after winning the presidential election.
#' @name ObamaSpeech
#' @docType data
#' @format int [1:59] 2 45 52 53 11 48 28 15 50 29 ...
#' @source The full text of speech is at
#'   \url{http://www.baltimoresun.com/news/nation-world/bal-text1105,0,5055673,full.story}
#'
#'
#' @examples
#' ## pattern: longer paragraph and shorter paragraph
#' plot(ObamaSpeech, type = 'b', pch = 20, xlab = 'paragraph index',
#'     ylab = 'word count')
NULL

#' Page views from Sep 21, 2007 to Dec 2, 2007 of Yihui's website
#'
#' The data is collected by Awstats for the website \url{http://yihui.name}.
#' @name pageview
#' @docType data
#' @format A data frame with 73 observations on the following 5 variables.
#'   \describe{ \item{day}{Date starts from Sep 21, 2007 to Dec 2, 2007.}
#'   \item{visits}{number of visits: a new visit is defined as each new
#'   \emph{incoming visitor} (viewing or browsing a page) who was not connected
#'   to the site during last \emph{60 min}.}  \item{pages}{number of times a
#'   \emph{page} of the site is viewed (sum for all visitors for all visits).
#'   This piece of data differs from ``files'' in that it counts only HTML pages
#'   and excludes images and other files.} \item{files}{number of times a
#'   \emph{page, image, file} of the site is viewed or downloaded by someone.}
#'   \item{bandwidth}{amount of data downloaded by all \emph{pages},
#'   \emph{images} and \emph{files} within the site (units in MegaBytes).} }
#' @source \url{http://yihui.name}
#' @examples
#' plot(pageview[,1:2], type = 'b', col = 'red',
#'   main = "Number of Visits in Yihui's Web")
#' ## partial auto-correlation
#' pacf(pageview$visits)
NULL

#' Synthetic dataset about the geometric features of pollen grains
#'
#' There are 3848 observations on 5 variables. From the 1986 ASA Data Exposition
#' dataset, made up by David Coleman of RCA Labs
#' @name pollen
#' @docType data
#' @format A data frame with 3848 observations on the following 5 variables.
#'   \describe{ \item{RIDGE}{a numeric vector} \item{NUB}{a numeric vector}
#'   \item{CRACK}{a numeric vector} \item{WEIGHT}{a numeric vector}
#'   \item{DENSITY}{a numeric vector} }
#' @source collected from Statlib Datasets Archive:
#'   \url{http://lib.stat.cmu.edu/data-expo/}
#' @examples
#' ## some dense points in the center?
#' plot(pollen[, 1:2], pch = 20, col = rgb(0, 0, 0, 0.1))
#'
#' ## see demo('pollen', package = 'animation') for a 3D demo; truth is there!
NULL

#' Stock prices of Vanke Co., Ltd on 2009/11/27
#'
#' This is a sample of stock prices of the Vanke Co., Ltd on 2009/11/27.
#' @name vanke1127
#' @docType data
#' @format A data frame with 2831 observations on the following 2 variables.
#'   \describe{ \item{time}{POSIXt: the time corresponding to stock prices}
#'   \item{price}{a numeric vector: stock prices} }
#' @source This data can be obtained from most stock websites.
#' @example inst/examples/vanke1127-ex.R
NULL

#' Average yearly temperatures in central Iowa
#'
#' Temperatures in central Iowa over 106 years.
#' @name iatemp
#' @docType data
#' @format Time-Series [1:116] from 1895 to 2010: 32.7 27.8 32.7 30.4 42.6 31.9
#'   34.5 39.8 32.6 39.6 ...
#' @source \url{http://www.wrcc.dri.edu/cgi-bin/divplot1_form.pl?1305}
#' @examples plot(iatemp)
NULL

#' The NBA game between CLE Cavaliers and LAL Lakers on Dec 25, 2009
#'
#' Cleveland Cavaliers played against Los Angeles Lakers at Staples Center in LA
#' on Dec 25, 2009 and won the game by 102:87. This data recorded the locations
#' of players on the court and the results of the shots.
#' @name CLELAL09
#' @docType data
#' @format A data frame with 455 observations on the following 7 variables.
#'   \describe{ \item{\code{player}}{a character vector: the current player}
#'   \item{\code{time}}{a character vector: the time} \item{\code{period}}{a
#'   numeric vector: the period (1 - 4)} \item{\code{realx}}{a numeric vector:
#'   the x-axis location} \item{\code{realy}}{a numeric vector: the y-axis
#'   location} \item{\code{result}}{a factor with levels \code{made} and
#'   \code{missed}} \item{\code{team}}{a factor with levels \code{CLE},
#'   \code{LAL} and \code{OFF}} }
#' @source \url{http://www.basketballgeek.com/data/} (transformed based on the
#'   original data)
#' @note We view the court with CLE in the left and LAL in the right:
#'   \code{realx} is the distance to the left border of CLE's court, and
#'   \code{realy} is the distance to the bottom border of the court; notice that
#'   the size of the court is \eqn{94 \times 50}{94 x 50} (feet).
#' @examples
#' ## see demo('CLEvsLAL', package = 'animation') for a `replay' of the game
NULL
