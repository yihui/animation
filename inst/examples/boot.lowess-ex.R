oopt = ani.options(nmax = if (interactive()) 100 else 2, interval = .02)

boot.lowess(cars, pch = 20, xlab = 'speed', ylab = 'dist')

boot.lowess(cars, f = 1/3, pch = 20)

## save in HTML pages
saveHTML({
  par(mar = c(4.5,4,.5,.5))
  boot.lowess(cars, f = 1/3, pch = 20, xlab='speed', ylab='dist')
}, img.name='boot_lowess', imgdir='boot_lowess', interval=.1,
         title='Bootstrapping with LOWESS',
         description='Fit LOWESS curves repeatedly via bootstrapping.')

ani.options(oopt)
