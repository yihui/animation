oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4))
sample.simple()

## HTML animation page
saveHTML({
    par(mar = rep(1, 4), lwd = 2)
    ani.options(nmax = ifelse(interactive(), 50, 2))
    sample.simple()
}, img.name='sample.simple',htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = paste("Demonstration of", "the simple random sampling without replacement"),
         description = c("Each member of the population has an equal and",
         "known chance of being selected."))

ani.options(oopt)
