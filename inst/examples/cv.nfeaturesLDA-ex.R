oopt = ani.options(nmax = ifelse(interactive(), 10, 2))
par(mar = c(3, 3, 0.2, 0.7), mgp = c(1.5, 0.5, 0))
cv.nfeaturesLDA(pch = 19)

## save the animation in HTML pages
saveHTML({
    ani.options(interval = 0.5, nmax = 10)
    par(mar = c(3, 3, 1, 0.5),
        mgp = c(1.5, 0.5, 0), tcl = -0.3, pch = 19, cex = 1.5)
    cv.nfeaturesLDA(pch = 19)
},
         img.name='cv.nfeaturesLDA',htmlfile='cv.nfeaturesLDA.html',
         ani.height = 480, ani.width = 600,
         title = "Cross-validation to find the optimum number of features in LDA",
         description = c("This",
         'animation has provided an illustration of the process of finding',
         'out the optimum number of variables using k-fold cross-validation',
         'in a linear discriminant analysis (LDA).'))

ani.options(oopt)
