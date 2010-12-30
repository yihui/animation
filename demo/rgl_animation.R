## how to use saveLatex() with the rgl package

library(animation)
data(pollen)

if (require('rgl')) {
    ## ajust the view
    uM =
        matrix(c(-0.37, -0.51, -0.77, 0, -0.73, 0.67,
                 -0.10, 0, 0.57, 0.53, -0.63, 0, 0, 0, 0, 1),
               nrow = 4, ncol = 4)

    ## note the width and height are 500px respectively
    open3d(userMatrix = uM, windowRect = c(10, 10, 510, 510))
    plot3d(pollen[, 1:3])
    zm = c(1, .9, .8, .6, .4, .1)
    par3d(zoom = 1)

    ## the most important argument is use.dev = FALSE!
    ## and the file extension should be 'pdf', since we are using rgl.postscript()
    saveLatex({
        for (i in 1:length(zm)) {
            par3d(zoom = zm[i])
            rgl.postscript(file.path(ani.options('outdir'), sprintf('pollen_demo%d.pdf', i)),
                           fmt = 'pdf', drawText=FALSE)
        }
        rgl.close()
    }, img.name='pollen_demo', use.dev=FALSE,
              ani.type='pdf', interval = 1,
              latex.filename='rgl_pollen_animation.tex')

} else warning('You have to install the rgl package first: install.packages("rgl")')
