oopt = ani.options(interval = 0.05, nmax = 20)
par(pty = "s")
vi.lilac.chaser()

## HTML animation page; nmax = 1 is enough!
saveHTML({
    ani.options(interval = 0.05, nmax = 1)
    par(pty = "s", mar = rep(1, 4))
    vi.lilac.chaser()
}, img.name='vi.lilac.chaser', htmlfile='vi.lilac.chaser.html',
         ani.height = 480, ani.width = 480,
         title = "Visual Illusions: Lilac Chaser",
         description = c("Stare at the center cross for a few (say 30) seconds",
         "to experience the phenomena of the illusion."))

ani.options(oopt)
