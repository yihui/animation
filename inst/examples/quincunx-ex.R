set.seed(123)
oopt=ani.options(nmax = ifelse(interactive(), 200 + 15 -2, 2), interval = 0.03)
freq = quincunx(balls = 200, col.balls = rainbow(200))
## frequency table
barplot(freq, space = 0)

## HTML animation page
saveHTML({
    ani.options(nmax = ifelse(interactive(), 200 + 15 -2, 2), interval = 0.03)
    quincunx(balls = 200, col.balls = rainbow(200))
}, img.name='quincunx', htmlfile='quincunx.html',
         ani.height = 500, ani.width = 600,
         single.opts = paste("'controls':", "['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'],", "'delayMin': 0"),
         title = "Demonstration of the Galton Box",
         description = c("Balls", 'falling through pins will show you the Normal',
         "distribution."))

ani.options(oopt)
