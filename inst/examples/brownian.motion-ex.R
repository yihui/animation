oopt = ani.options(interval = 0.05, nmax = ifelse(interactive(), 150, 2))
brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow",
                main = "Demonstration of Brownian Motion")
ani.options(oopt)

## create an HTML animation page
saveHTML({
    par(mar = c(3, 3, 1, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
        cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
    ani.options(interval = 0.05, nmax = ifelse(interactive(), 150, 10))
    brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
},
         single.opts = "'controls': ['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'], 'delayMin': 0",
         title = "Demonstration of Brownian Motion",
         description = c("Random walk on the 2D plane: for each point",
         "(x, y), x = x + rnorm(1) and y = y + rnorm(1)."))

ani.options(oopt)

