oopt = ani.options(interval = 2, nmax = 15)
cv.ani(main = 'Demonstration of the k-fold Cross Validation', bty = 'l')

## leave-one-out CV
cv.ani(x = runif(15), k = 15)

## save the animation in HTML pages
saveHTML({
  ani.options(interval = 2)
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
  cv.ani(bty = 'l')
}, img.name='cv.ani',htmlfile='cv.ani.html',
         ani.height = 400, ani.width = 600,
         title = 'Demonstration of the k-fold Cross Validation',
         description = c('This is a naive demonstration for the k-fold cross',
                         'validation. The k rectangles in the plot denote the k folds of data.',
                         'Each time a fold will be used as the test set and the rest parts',
                         'as the training set.'))

ani.options(oopt)
