##' Visual Illusions: Lilac Chaser.
##' Stare at the center cross for a few (say 30) seconds to experience the
##' phenomena of the illusion.
##'
##' Just try it out.
##'
##' @param np number of points
##' @param col color of points
##' @param bg background color of the plot
##' @param p.cex magnification of points
##' @param c.cex magnification of the center cross
##' @return None.
##' @note In fact, points in the original version of `Lilac Chaser' are
##'   \emph{blurred}, which is not implemented in this function. If you have
##'   any idea, please contact me.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[graphics]{points}}
##' @references \url{http://en.wikipedia.org/wiki/Lilac_chaser}
##'
##' \url{http://animation.yihui.name/animation:misc#lilac_chaser}
##' @keywords dynamic
##' @examples
##' oopt = ani.options(interval = 0.05, nmax = 20)
##' op = par(pty = "s")
##' vi.lilac.chaser()
##'
##' \dontrun{
##' # HTML animation page; nmax = 1 is enough!
##' ani.options(ani.height = 480, ani.width = 480, nmax = 1,
##'     interval = 0.05, title = "Visual Illusions: Lilac Chaser",
##'     description = "Stare at the center cross for a few (say 30) seconds
##'     to experience the phenomena of the illusion.")
##' ani.start()
##' par(pty = "s", mar = rep(1, 4))
##' vi.lilac.chaser()
##' ani.stop()
##' }
##' par(op)
##' ani.options(oopt)
##'
vi.lilac.chaser = function(np = 16, col = "magenta",
    bg = "gray", p.cex = 7, c.cex = 5) {
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    op = par(bg = bg, xpd = NA)
    x = seq(0, 2 * pi, length = np)
    for (j in 1:nmax) {
        for (i in 1:np) {
            plot.new()
            plot.window(xlim = c(-1, 1), ylim = c(-1, 1))
            points(sin(x[-i]), cos(x[-i]), col = col, cex = p.cex,
                   pch = 19)
            points(0, 0, pch = "+", cex = c.cex, lwd = 2)
            Sys.sleep(interval)
        }
    }
    ani.options(nmax = nmax * np)
    par(op)
    invisible(NULL)
}
