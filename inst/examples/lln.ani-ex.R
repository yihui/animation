oopt = ani.options(interval = 0.01, nmax = ifelse(interactive(), 150, 2))

lln.ani(pch = '.')

## chi-square distribution; population mean = df
lln.ani(FUN = function(n, mu) rchisq(n, df = mu), mu = 5, cex = 0.6)

## save the animation in HTML pages
saveHTML({
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
  ani.options(interval = 0.1, nmax = ifelse(interactive(), 150, 2))
  lln.ani(cex = 0.6)
}, img.name='lln.ani',htmlfile='lln.ani.html',
         ani.height = 480, ani.width = 600,
         title = 'Demonstration of the Law of Large Numbers',
         description = c('The sample mean approaches to the population mean as',
                         'the sample size n grows.'))

ani.options(oopt)
