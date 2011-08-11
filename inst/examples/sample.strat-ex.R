oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4), lwd = 2)

sample.strat(col = c("bisque", "white"))

## HTML animation page
saveHTML({
    par(mar = rep(1, 4), lwd = 2)
    ani.options(nmax = ifelse(interactive(), 50, 2))
    sample.strat(col = c("bisque", "white"))
}, img.name='sample.strat', htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = "Demonstration of the stratified sampling",
         description = c("Every rectangle stands for a stratum, and the simple",
         "random sampling without replacement is performed within each stratum."))

ani.options(oopt)
