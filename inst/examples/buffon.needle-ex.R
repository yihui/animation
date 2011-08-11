## it takes several seconds if 'redraw = TRUE'
oopt = ani.options(nmax = ifelse(interactive(), 500, 2), interval = 0.05)
par(mar = c(3, 2.5, 0.5, 0.2), pch = 20, mgp = c(1.5, 0.5, 0))
buffon.needle()

## this will be faster
buffon.needle(redraw = FALSE)

## create an HTML animation page
saveHTML({
    par(mar = c(3, 2.5, 1, 0.2), pch = 20, mgp = c(1.5, 0.5, 0))
    ani.options(nmax = ifelse(interactive(), 300, 10), interval = 0.1)
    buffon.needle(type = "S")
}, img.name='buffon.needle', htmlfile='buffon.needle.html',
         ani.height = 500, ani.width = 600, title = "Simulation of Buffon's Needle",
         description = c('There are three graphs made in each step: the',
         'top-left, one is a simulation of the scenario, the top-right one',
         'is to help us understand the connection between dropping needles',
         'and the mathematical method to estimate pi, and the bottom one is',
         'the result for each dropping.'))

ani.options(oopt)
