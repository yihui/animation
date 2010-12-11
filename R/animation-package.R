##' Statistical Animations Using R.
##' Various functions for animations in statistics which could probably aid in
##' teaching statistics and data analysis.
##'
##' \tabular{ll}{ Package: \tab animation\cr Type: \tab Package\cr Version:
##' \tab 1.1\cr Date: \tab 2010-09-28\cr License: \tab GPL-2 | GPL-3\cr } This
##' package mainly makes use of HTML \& JavaScript and R windows graphics
##' devices (such as \code{\link[grDevices]{x11}}) to demonstrate animations in
##' statistics; other kinds of output such as Flash (SWF) or GIF animations
##' or PDF animations are also available if required software packages have
##' been installed.
##'
##' @name animation-package
##' @aliases animation-package animation
##' @docType package
##' @exportPattern "^[^\\.]"
##' @author Yihui Xie <\url{http://yihui.name}>
##' @references AniWiki: Animations in Statistics
##'   \url{http://animation.yihui.name}
##' @keywords package dynamic device dplot
##' @examples
##'
##' \dontrun{
##' #############################################################
##' # (1) Animations in HTML pages
##' # create an animation page in the tempdir() and auto-browse it
##' # Brownian Motion
##' oopt = ani.options(interval = 0.05, nmax = 100, ani.dev = png,
##'     ani.type = "png",
##'     title = "Demonstration of Brownian Motion",
##'     description = "Random walk on the 2D plane: for each point
##'     (x, y), x = x + rnorm(1) and y = y + rnorm(1).")
##' ani.start()
##' opar = par(mar = c(3, 3, 2, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
##'     cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
##' brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
##'     main = "Demonstration of Brownian Motion")
##' par(opar)
##' ani.stop()
##' ani.options(oopt)
##'
##' #############################################################
##' # (2) Animations inside R windows graphics devices
##' # Bootstrapping
##' oopt = ani.options(interval = 0.3, nmax = 50)
##' boot.iid()
##' ani.options(oopt)
##'
##' #############################################################
##' # (3) GIF animations
##' oopt = ani.options(interval = 0, nmax = 100)
##' saveMovie(brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow"),
##'     interval = 0.05, outdir = getwd(), width = 600, height = 600)
##' ani.options(oopt)
##'
##' #############################################################
##' # (4) Flash animations
##' oopt = ani.options(nmax = 100, interval = 0)
##' saveSWF(buffon.needle(type = "S"), para = list(mar = c(3, 2.5, 1, 0.2),
##'     pch = 20, mgp = c(1.5, 0.5, 0)), dev = "pdf", swfname = "buffon.swf",
##'     outdir = getwd(), interval = 0.1)
##' ani.options(oopt)
##'
##' #############################################################
##' # (5) PDF animations
##' oopt = ani.options(interval = 0.1, nmax = 100)
##' saveLatex({
##'     brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
##'         main = "Brownian Motion")
##' }, ani.basename = "BM", ani.opts = "controls,loop,width=0.8\textwidth",
##'     ani.first = par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0),
##'         tcl = -0.3, cex.axis = 0.8, cex.lab = 0.8, cex.main = 1),
##'     latex.filename = "brownian.motion.tex")
##' ani.options(oopt)
##' }
##'
NULL





##' Word Counts of a Speech by Chinese President Hu.
##' This speech came on the 30th anniversary of China's economic reform in 1978.
##'
##' On Dec 18, 2008, Chinese President Hu gave a speech on the 30th anniversary
##' of China's economic reform in 1978, and this data has recorded the number
##' of words used in each paragraph of his speech.
##'
##' @name HuSpeech
##' @docType data
##' @format The format is: int [1:75] 119 175 222 204 276 168 257 89 61 288 ...
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
##' @name pageview
##' @docType data
##' @format A data frame with 73 observations on the following 5 variables.
##'   \describe{ \item{list("day")}{Date starts from Sep 21, 2007 to Dec 2,
##'   2007.} \item{list("visits")}{number of visits: a new visit is defined as
##'   each new \emph{incoming visitor} (viewing or browsing a page) who was not
##'   connected to the site during last \emph{60 min}.}
##'   \item{list("pages")}{number of times a \emph{page} of the site is viewed
##'   (sum for all visitors for all visits).  This piece of data differs from
##'   ``files'' in that it counts only HTML pages and excludes images and other
##'   files.} \item{list("files")}{number of times a \emph{page, image, file}
##'   of the site is viewed or downloaded by someone.}
##'   \item{list("bandwidth")}{amount of data downloaded by all \emph{pages},
##'   \emph{images} and \emph{files} within the site (units in MegaBytes).} }
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
##' @name pollen
##' @docType data
##' @format A data frame with 3848 observations on the following 5 variables.
##'   \describe{ \item{list("RIDGE")}{a numeric vector} \item{list("NUB")}{a
##'   numeric vector} \item{list("CRACK")}{a numeric vector}
##'   \item{list("WEIGHT")}{a numeric vector} \item{list("DENSITY")}{a numeric
##'   vector} }
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
##' @name vanke1127
##' @docType data
##' @format A data frame with 2831 observations on the following 2 variables.
##'   \describe{ \item{list("time")}{POSIXt: the time corresponding to stock
##'   prices} \item{list("price")}{a numeric vector: stock prices} }
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



