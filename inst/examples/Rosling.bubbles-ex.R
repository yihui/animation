oopt = ani.options(interval = 0.1, nmax = ifelse(interactive(), 50, 2))

## use default arguments (random numbers); you may try to find the real data
par(mar = c(4, 4, 0.2, 0.2))
Rosling.bubbles()

## rectangles
Rosling.bubbles(rectangles = matrix(abs(rnorm(50 * 10 * 2)), ncol = 2))

## save the animation in HTML pages
saveHTML({
    par(mar = c(4, 4, 0.2, 0.2))
    ani.options(interval = 0.1, nmax = ifelse(interactive(), 50, 2))
    Rosling.bubbles(text = 1951:2000)
}, img.name='Rosling.bubbles', htmlfile='Rosling.bubbles.html',
         ani.height = 450, ani.width = 600,
         title = "The Bubbles Animation in Hans Rosling's Talk",
         description = c("An imitation of Hans Rosling's moving bubbles.",
         "(with 'years' as the background)"))

ani.options(oopt)
