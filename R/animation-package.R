##' Statistical Animations Using R.
##' Various functions for animations in statistics which could probably aid in
##' teaching statistics and data analysis.
##'
##' \tabular{ll}{ Package: \tab animation\cr Type: \tab Package\cr Version:
##' \tab 1.1\cr License: \tab GPL-2 | GPL-3\cr } This
##' package mainly makes use of HTML & JavaScript and R windows graphics
##' devices (such as \code{\link[grDevices]{x11}}) to demonstrate animations in
##' statistics; other kinds of output such as Flash (SWF) or GIF animations
##' or PDF animations are also available if required software packages have
##' been installed. See below for details on each type of animation.
##'
##' \describe{
##' \item{\strong{On-screen Animations}}{
##' It's natural and easy to create an animation in R using the windows graphics
##' device, e.g. in \code{x11()} or \code{windows()}. A basic scheme is like
##' the Example 1 (see below).
##'
##' On-screen animations do not depend on any third-party software, but the
##' rendering speed of the windows graphics devices is often slow, so the
##' animation might not be smooth (especially under Linux and Mac OS).
##' }
##'
##' \item{\strong{HTML Pages}}{
##' The generation of HTML animation pages does not rely on any third-party
##' software either, and we only need a web browser to watch the animation.
##' This package has two sets of functions to create HTML pages:
##' \code{\link{saveHTML}} and \code{\link{ani.start}}/\code{\link{ani.stop}}.
##' The former one is recommended, since it can include the source code into
##' the HTML page and is much more visually appealing.
##'
##' The HTML interface is just like a movie player -- it comes with a series
##' of buttons to control the animation (play, stop, next, previous, ...).
##' }
##'
##' \item{\strong{GIF Animations}}{
##' If ImageMagick or GraphicsMagick has been installed, we can use
##' \code{\link{im.convert}} or \code{\link{gm.convert}} to create a GIF
##' animation (combining several R plots together).
##' }
##'
##' \item{\strong{Flash Animations}}{
##' If SWF Tools has been installed, we can use \code{\link{saveSWF}} to
##' create a Flash animation (again, combining R plots).
##' }
##'
##' \item{\strong{PDF Animations}}{
##' If LaTeX is present in the system, we can use \code{\link{saveLatex}}
##' to insert animations into a PDF document and watch the animation
##' using the Adobe reader.
##'
##' The animation is created by the LaTeX package \code{animate}.
##' }
##' }
##' This package also contains several functions to create animations
##' for various statistical topics.
##'
##' @name animation-package
##' @aliases animation-package animation
##' @docType package
##' @exportPattern "^[^\\.]"
##' @author Yihui Xie <\url{http://yihui.name}>
##' @references AniWiki: Animations in Statistics
##'   \url{http://animation.yihui.name}
##' @keywords package dynamic device dplot
##' @example animation/inst/examples/animation-package-Ex.R
##'
NULL





##' Word Counts of a Speech by Chinese President Hu.
##' This speech came on the 30th anniversary of China's economic reform in 1978.
##'
##' On Dec 18, 2008, Chinese President Hu gave a speech on the 30th anniversary
##' of China's economic reform in 1978, and this data has recorded the number
##' of words used in each paragraph of his speech.
##'
##' The format is: int [1:75] 119 175 222 204 276 168 257 89 61 288 ...
##' @name HuSpeech
##' @docType data
##' @source The full text of speech:
##'   \url{http://cpc.people.com.cn/GB/64093/64094/8544901.html}
##' @keywords datasets
##' @examples
##'
##' data(HuSpeech)
##' # clear pattern: 1/3 short, 1/3 long, 1/3 short again
##' plot(HuSpeech, type = "b", pch = 20, xlab = "paragraph index",
##'     ylab = "word count")
##' # see ?moving.block for an animation example
##'
NULL





##' Page views from Sep 21, 2007 to Dec 2, 2007 of Yihui's website.
##'
##' The data is collected by Awstats for the website \url{http://yihui.name}.
##'
##' Format: a data frame with 73 observations on the following 5 variables.
##'   \describe{ \item{day}{Date starts from Sep 21, 2007 to Dec 2,
##'   2007.} \item{visits}{number of visits: a new visit is defined as
##'   each new \emph{incoming visitor} (viewing or browsing a page) who was not
##'   connected to the site during last \emph{60 min}.}
##'   \item{pages}{number of times a \emph{page} of the site is viewed
##'   (sum for all visitors for all visits).  This piece of data differs from
##'   ``files'' in that it counts only HTML pages and excludes images and other
##'   files.} \item{files}{number of times a \emph{page, image, file}
##'   of the site is viewed or downloaded by someone.}
##'   \item{bandwidth}{amount of data downloaded by all \emph{pages},
##'   \emph{images} and \emph{files} within the site (units in MegaBytes).} }
##' @name pageview
##' @docType data
##' @source \url{http://yihui.name}
##' @keywords datasets
##' @examples
##'
##' data(pageview)
##' plot(pageview[,1:2], type = "b", col = "red",
##'   main = "Number of Visits in Yihui's Web")
##' # partial auto-correlation
##' pacf(pageview$visits)
##'
NULL





##' Synthetic dataset about the geometric features of pollen grains
##' There are 3848 observations on 5 variables. From the 1986 ASA Data Exposition
##' dataset, made up by David Coleman of RCA Labs.
##'
##' Format: a data frame with 3848 observations on the following 5 variables.
##'   \describe{ \item{RIDGE}{a numeric vector} \item{NUB}{a
##'   numeric vector} \item{CRACK}{a numeric vector}
##'   \item{WEIGHT}{a numeric vector} \item{DENSITY}{a numeric
##'   vector} }
##' @name pollen
##' @docType data
##' @source Collected from Statlib Datasets Archive:
##'   \url{http://stat.cmu.edu/datasets/}
##' @keywords datasets
##' @examples
##'
##' data(pollen)
##' ## some dense points in the center?
##' plot(pollen[, 1:2], pch = 20, col = rgb(0, 0, 0, 0.1))
##'
##' ## check with rgl
##' \dontrun{
##' library(rgl)
##' # ajust the view
##' uM = matrix(c(-0.370919227600098, -0.513357102870941,
##'     -0.773877620697021, 0, -0.73050606250763, 0.675815105438232,
##'     -0.0981751680374146, 0, 0.573396027088165, 0.528906404972076,
##'     -0.625681936740875, 0, 0, 0, 0, 1), 4, 4)
##' open3d(userMatrix = uM, windowRect = c(10, 10, 510, 510))
##' plot3d(pollen[, 1:3])
##' zm = seq(1, 0.045, length = 200)
##' par3d(zoom = 1)
##' for (i in 1:length(zm)) {
##'     par3d(zoom = zm[i])
##'     # remove the comment if you want to save the snapshots
##'     # rgl.snapshot(paste(formatC(i, width = 3, flag = 0), ".png", sep = ""))
##'     Sys.sleep(0.01)
##' }
##' }
##'
NULL





##' Stock prices of Vanke Co., Ltd on 2009/11/27.
##' This is a sample of stock prices of the Vanke Co., Ltd on 2009/11/27.
##'
##' Format: a data frame with 2831 observations on the following 2 variables.
##'   \describe{ \item{time}{POSIXt: the time corresponding to stock
##'   prices} \item{price}{a numeric vector: stock prices} }
##' @name vanke1127
##' @docType data
##' @source This data can be obtained from most stock websites.
##' @keywords datasets
##' @examples
##'
##' data(vanke1127)
##' with(vanke1127, {
##'     tab.price = table(price)
##'     plot(as.numeric(names(tab.price)), tab.price, type = "h",
##'         xlab = "price", ylab = "frequency")
##' })
##'
##' \dontrun{
##' ani.options(interval = 0.5, loop = FALSE)
##'
##' with(vanke1127, {
##'     ## a series of HTML animations with different time spans
##'     ani.start(title = "Prices changing along with time interval 15 min")
##'     price.ani(price, time, lwd = 2)
##'     ani.stop()
##'
##'     ani.start(title = "Prices changing along with time interval 30 min")
##'     price.ani(price, time, span = 30 * 60, lwd = 3)
##'     ani.stop()
##'
##'     ani.start(title = "Prices changing along with time interval 5 min")
##'     price.ani(price, time, span = 5 * 60, lwd = 2)
##'     ani.stop()
##'
##'     ## GIF animation
##'     saveMovie(price.ani(price, time, lwd = 2), interval = 1,
##'         moviename = "price", loop = 1)
##' })
##' }
##'
NULL



##' Average yearly temperatures in central Iowa.
##'
##' The format is:
##'
##' Time-Series [1:116] from 1895 to 2010: 32.7 27.8 32.7 30.4 42.6 31.9 34.5 39.8 32.6 39.6 ...
##' @name iatemp
##' @docType data
##' @source \url{http://www.wrcc.dri.edu/cgi-bin/divplot1_form.pl?1305}
##' @keywords datasets
##' @examples data(iatemp)
##' plot(iatemp)
NULL
