oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4), lwd = 2)

sample.system()

## HTML animation pages
saveHTML({
  ani.options(interval = 1, nmax = ifelse(interactive(), 30,2))
  par(mar = rep(1, 4), lwd = 2)
  sample.system()
}, img.name='sample.system', htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = 'Demonstration of the systematic sampling',
         description = 'Sampling with equal distances.')

ani.options(oopt)

