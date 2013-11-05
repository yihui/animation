## moving window along a sin curve
oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 50, 2))
par(mar = c(2, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
mwar.ani(lty.rect = 3, pch = 21, col = 'red', bg = 'yellow',type='o')

## for the data 'pageview'
mwar.ani(pageview$visits, k = 30)

## HTML animation page
saveHTML({
  ani.options(interval = 0.1, nmax = ifelse(interactive(), 50, 2))
  par(mar = c(2, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
  mwar.ani(lty.rect = 3, pch = 21, col = 'red', bg = 'yellow',type='o')
}, img.name='mwar.ani',htmlfile='mwar.ani.html',
         ani.height = 500, ani.width = 600,
         title = 'Demonstration of Moving Window Auto-Regression',
         description = c('Compute the AR(1) coefficient for the data in the',
                         'window and plot the confidence intervals. Repeat this step as the',
                         'window moves.'))

ani.options(oopt)

