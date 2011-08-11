oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 100, 2))
## 90% interval
conf.int(0.90, main = "Demonstration of Confidence Intervals")

## save the animation in HTML pages
saveHTML({
    ani.options(interval = 0.15, nmax = ifelse(interactive(), 100, 10))
    par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
    conf.int()
}, img.name='conf.int',htmlfile='conf.int.html',
         ani.height = 400, ani.width = 600,
         title = "Demonstration of Confidence Intervals",
         description = c("This animation shows the concept of the confidence",
         'interval which depends on the observations: if the samples change,',
         'the interval changes too. At last we can see that the coverage rate',
         'will be approximate to the confidence level.'))

ani.options(oopt)
