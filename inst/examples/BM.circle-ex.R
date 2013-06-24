oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 300, 2))
par(mar = rep(0.5, 4))
BM.circle(cex = 2, pch = 19)

saveHTML({
  par(mar = rep(0.5, 4), pch=19)
  ani.options(interval=0.05,nmax=ifelse(interactive(), 100, 10))
  BM.circle(cex = 2, pch = 19)
}, img.name='BM.circle', htmlfile='BM.circle.html', ani.height = 450, ani.width = 450,
         single.opts = paste("'controls':", "['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'],", "'delayMin': 0"),
         title = "Brownian Motion in a Circle",
         description = "Brownian Motion in a circle.")

ani.options(oopt)

