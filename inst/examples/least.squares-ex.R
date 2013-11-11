par(mar = c(5, 4, 0.5, 0.1))
oopt = ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))

## default animation: with slope changing
least.squares()

## intercept changing
least.squares(ani.type = 'intercept')

## save the animation in HTML pages
saveHTML({
  ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))
  par(mar = c(4, 4, 0.5, 0.1), mgp = c(2, 0.5, 0), tcl = -0.3)
  least.squares()
}, img.name='least.squares',htmlfile='least.squares.html',
         ani.height = 450, ani.width = 600,
         title = 'Demonstration of Least Squares',
         description = c('We want to find an estimate for the slope',
                         'in 50 candidate slopes, so we just compute the RSS one by one. '))

ani.options(oopt)
