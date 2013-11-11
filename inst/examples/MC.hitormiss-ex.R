oopt = ani.options(interval = 0.2, nmax = ifelse(interactive(), 100, 2))

## should be close to 1/6
MC.hitormiss()$est

## should be close to 1/12
MC.hitormiss(from = 0.5, to = 1)$est

## HTML animation page
saveHTML({
  ani.options(interval = 0.5, nmax = ifelse(interactive(), 100, 2))
  MC.hitormiss()
}, img.name='MC.hitormiss',htmlfile='MC.hitormiss.html',
         title = 'Hit or Miss Monte Carlo Integration',
         description = c('','Generate Uniform random numbers', 'and compute the proportion',
                         'of points under the curve.'))

ani.options(oopt)
