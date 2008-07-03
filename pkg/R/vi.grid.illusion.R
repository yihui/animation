`vi.grid.illusion` <-
function(nrow = 8, ncol = 8, lwd = 8, 
    cex = 3, col = "darkgray", type = c("s", "h")) {
    op = par(mar = rep(0, 4), bg = "black")
    plot.new()
    x = seq(0, 1, length = ncol)
    y = seq(0, 1, length = nrow)
    abline(v = x, h = y, col = col, lwd = lwd)
    if (type[1] == "s") 
        points(rep(x, each = nrow), rep(y, ncol), col = "white", 
            cex = cex, pch = 20)
    par(op)
}

