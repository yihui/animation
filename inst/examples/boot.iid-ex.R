## bootstrap for 20 random numbers from U(0, 1)
par(mar = c(1.5, 3, 1, 0.1), cex.lab = 0.8, cex.axis = 0.8,
    mgp = c(2, 0.5, 0), tcl = -0.3)
oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
## don't want the titles
boot.iid(main = c("", ""))

## for the median of 15 points from chi-square(5)
boot.iid(x = rchisq(15, 5), statistic = median, main = c("", ""))

## change the layout; or you may try 'mat = matrix(1:2, 1)'
par(mar = c(1.5, 3, 2.5, 0.1), cex.main = 1)
boot.iid(heights = c(1, 2))

## save the animation in HTML pages
saveHTML({
    par(mar = c(2.5, 4, 0.5, 0.5))
    ani.options(nmax = ifelse(interactive(), 50, 10))
    boot.iid(main = c("", ""), heights = c(1, 2))
},img.name='boot.iid',htmlfile='boot.iid.html',
         ani.height = 500, ani.width = 600,
         title = "Bootstrapping the i.i.d data",
         description = c("This is a naive version of bootstrapping but",
         "may be useful for novices."))

ani.options(oopt)
