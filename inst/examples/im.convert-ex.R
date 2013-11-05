## generate some images
owd = setwd(tempdir())
oopt = ani.options(interval = 0.05, nmax = 20)
png('bm%03d.png')
brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow',
                main = 'Demonstration of Brownian Motion')
dev.off()

## filenames with a wildcard *
im.convert('bm*.png', output = 'bm-animation1.gif')
## use GraphicsMagick
gm.convert('bm*.png', output = 'bm-animation2.gif')

## or a filename vector
bm.files = sprintf('bm%03d.png', 1:20)
im.convert(files = bm.files, output = 'bm-animation3.gif')

ani.options(oopt)
setwd(owd)
