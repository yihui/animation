oopt = ani.options(nmax = ifelse(interactive(), 50, 2))
par(mar = rep(1, 4))
sample.cluster(col = c('bisque', 'white'))

## HTML animation page
saveHTML({
  par(mar = rep(1, 4), lwd = 2)
  ani.options(nmax = ifelse(interactive(), 50, 2))
  sample.cluster(col = c('bisque', 'white'))
}, img.name='sample.cluster',htmlfile='sample.html',
         ani.height = 350, ani.width = 500,
         title = 'Demonstration of the cluster sampling',
         description = c('Once a cluster is sampled,',
                         'all its elements will be chosen.'))

ani.options(oopt)
