oopt = ani.options(interval = 0.2, nmax = ifelse(interactive(), 50, 2))
par(mar = c(4, 4, 1, 1))

## when the number of rectangles is large, use border = NA
MC.samplemean(border = NA)$est

integrate(function(x) x - x^2, 0, 1)

## when adj.x = FALSE, use semi-transparent colors
MC.samplemean(adj.x = FALSE, col.rect = c(rgb(0, 0,
                             0, 0.3), rgb(1, 0, 0)), border = NA)

## another function to be integrated
MC.samplemean(FUN = function(x) x^3 - 0.5^3, border = NA)$est

integrate(function(x) x^3 - 0.5^3, 0, 1)

## HTML animation page
saveHTML({
    ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))
    MC.samplemean(n = 100, border = NA)
}, img.name='MC.samplemean', htmlfile='MC.samplemean.html',
         title = "Sample Mean Monte Carlo Integration",
         description = c('',"Generate Uniform random numbers"," and compute the average",
         "function values."))

ani.options(oopt)
