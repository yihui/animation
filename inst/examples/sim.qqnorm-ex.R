oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 100,2))
par(mar = c(3, 3, 2, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)

sim.qqnorm(n = 20, last.plot = expression(abline(0, 1)))

## HTML animation pages
saveHTML({
    par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
    ani.options(interval = 0.1, nmax = ifelse(interactive(), 100,2))
    sim.qqnorm(n = 15, pch = 20, main = "")
}, img.name='sim.qqnorm',htmlfile='sim.qqnorm.html',
         ani.height = 500, ani.width = 500,
         title = "Demonstration of Simulated QQ Plots",
         description = c("This animation shows the QQ plots of random numbers",
         "from a Normal distribution. Does them really look like normally",
         "distributed?"))

ani.options(oopt)

