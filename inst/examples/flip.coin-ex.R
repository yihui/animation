oopt = ani.options(interval = 0.2, nmax = ifelse(interactive(), 100, 2))
## a coin would stand on the table?? just kidding :)
flip.coin(faces = c("Head", "Stand", "Tail"), type = "n",
          prob = c(0.45, 0.1, 0.45), col =c(1, 2, 4))

flip.coin(bg = "yellow")

## HTML animation page
saveHTML({
    ani.options(interval = 0.2, nmax = ifelse(interactive(), 100, 2))
    par(mar = c(2, 3, 2, 1.5), mgp = c(1.5, 0.5, 0))
    flip.coin(faces = c("Head", "Stand", "Tail"), type = "n",
              prob = c(0.45, 0.1, 0.45), col =c(1, 2, 4))
}, img.name = 'flip.coin', htmlfile='flip.coin.html',
         ani.height = 500, ani.width = 600, title = "Probability in flipping coins",
         description = c("This animation has provided a simulation of flipping coins",
         "which might be helpful in understanding the concept of probability."))

ani.options(oopt)
