`vi.lilac.chaser` <- function(np = 16, col = "magenta",
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
