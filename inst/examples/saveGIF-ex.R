## make sure ImageMagick has been installed in your system
saveGIF({for(i in 1:10) plot(runif(10), ylim = 0:1)})

## if the above conversion was successful, the option 'convert' should not be NULL under Windows
ani.options('convert')
## like 'C:/Software/LyX/etc/ImageMagick/convert.exe'

saveGIF({brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow')},
        movie.name = 'brownian_motion.gif',
        interval = 0.1, nmax = ifelse(interactive(), 30, 2), ani.width = 600, ani.height = 600)

## non-constant intervals between image frames
saveGIF({brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow')},
        movie.name = 'brownian_motion2.gif',
        interval = runif(30, .01, 1), nmax = ifelse(interactive(), 30, 2))
