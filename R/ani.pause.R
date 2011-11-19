##' Pause for a while and flush the current graphical device
##'
##' If this function is called in an interactive graphics device, it
##' will pause for a time interval (specified in
##' \code{\link{ani.options}('interval')}) and flush the current
##' device; otherwise it will do nothing.
##'
##' @return Invisible \code{NULL}.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[grDevices]{dev.interactive}},
##' \code{\link[base]{Sys.sleep}}, \code{\link[grDevices]{dev.flush}}
##' @examples ## pause for 2 seconds
##' oopt = ani.options(interval = 2)
##'
##' for (i in 1:5) {
##' plot(runif(10), ylim = c(0, 1))
##' ani.pause()
##' }
##'
##' ani.options(oopt)
##'
##' ## see demo('Xmas2', package = 'animation') for another example
##'
ani.pause = function() {
    if (dev.interactive()) {
        dev.flush()
        Sys.sleep(ani.options('interval'))
    }
}
