saveMovie <-
    function(expr, interval = 1, moviename = "animation.gif",
             loop = 0, dev = png, filename = "Rplot",
             fmt = "%03d", fileext = "png", outdir = getwd(),
             convert = "convert", cmd.fun, clean = TRUE,
             ani.first = NULL, para = par(no.readonly = TRUE),
             ...) {
        ## create images in the temp dir
        tmpdir = setwd(tempdir())
        on.exit(setwd(tmpdir))

        wildcard = paste(filename, "*.", fileext, sep = "")

        ## clean up the files first
        unlink(wildcard)

        ## draw the plots and record them in image files
        oopt = ani.options(interval = 0)
        dev(paste(filename, fmt, ".", fileext, sep = ""), ...)
        par(para)
        eval(ani.first)
        eval(expr)
        dev.off()
        ani.options(oopt)

        if (missing(cmd.fun))
            cmd.fun = if (.Platform$OS.type == "windows")
                shell
            else system

        ## convert to animations
        im.convert(wildcard, interval = interval, loop = loop,
                   output = moviename, outdir = outdir, convert = convert,
                   cmd.fun = cmd.fun, clean = clean)
    }
