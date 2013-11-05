oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 150, 2))
op = par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
clt.ani(type = 's')
par(op)

## HTML animation page
saveHTML({
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
  ani.options(interval = 0.1, nmax = ifelse(interactive(), 150, 10))
  clt.ani(type = 'h')
}, img.name='clt.ani', htmlfile='clt.ani.html',
         ani.height = 500, ani.width = 600,
         title = 'Demonstration of the Central Limit Theorem',
         description = c('This animation shows the distribution of the sample',
                         'mean as the sample size grows.'))

## other distributions: Chi-square with df = 5 (mean = df, var = 2*df)
f = function(n) rchisq(n, 5)
clt.ani(FUN = f, mean = 5, sd = sqrt(2*5))

ani.options(oopt)

