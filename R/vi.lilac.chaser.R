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
##' @note In fact, points in the original version of `Lilac Chaser'
##' are \emph{blurred}, which is not implemented in this function.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[graphics]{points}}
##' @references \url{http://en.wikipedia.org/wiki/Lilac_chaser}
##'
##' \url{http://animation.yihui.name/animation:misc#lilac_chaser}
##' @keywords dynamic
##' @examples
##' oopt = ani.options(interval = 0.05, nmax = 20)
##' par(pty = "s")
##' vi.lilac.chaser()
##'
##' ## HTML animation page; nmax = 1 is enough!
##' saveHTML({
##' ani.options(interval = 0.05, nmax = 1)
##' par(pty = "s", mar = rep(1, 4))
##' vi.lilac.chaser()
##' }, img.name='vi.lilac.chaser', htmlfile='vi.lilac.chaser.html',
##' ani.height = 480, ani.width = 480,
##'   title = "Visual Illusions: Lilac Chaser",
##'     description = c("Stare at the center cross for a few (say 30) seconds",
##'     "to experience the phenomena of the illusion."))
##'
##' ani.options(oopt)
##'
vi.lilac.chaser = function(np = 16, col = "magenta",
    bg = "gray", p.cex = 7, c.cex = 5) {
    nmax = ani.options("nmax")
    op = par(bg = bg, xpd = NA)
    x = seq(0, 2 * pi, length = np)
    for (j in 1:nmax) {
        for (i in 1:np) {
            plot.new()
            plot.window(xlim = c(-1, 1), ylim = c(-1, 1))
            points(sin(x[-i]), cos(x[-i]), col = col, cex = p.cex,
                   pch = 19)
            points(0, 0, pch = "+", cex = c.cex, lwd = 2)
            ani.pause()
        }
    }
    par(op)
    invisible(NULL)
}
