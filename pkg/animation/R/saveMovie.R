saveMovie <- function(expr, interval = 1, moviename = "movie", 
    movietype = "gif", loop = 0, dev = png, filename = "Rplot", 
    fmt = "%03d", outdir = tempdir(), convert = "convert", 
    ani.first = NULL, para = par(no.readonly = TRUE), 
    ...) {
    olddir = setwd(outdir)
    on.exit(setwd(olddir))
    oopt = ani.options(interval = 0)
    dev(filename = paste(filename, fmt, ".", deparse(substitute(dev)), 
        sep = ""), ...)
    par(para)
    eval(ani.first)
    eval(expr)
    dev.off()
    ani.options(oopt)
    version <- system(sprintf("%s --version", convert), intern = TRUE)
    if (!length(grep("ImageMagick", version))) {
        stop("ImageMagick not found!")
    }
    moviename <- paste(moviename, ".", movietype, sep = "")
    wildcard <- paste(filename, "*.", deparse(substitute(dev)), 
        sep = "")
    convert <- paste(sprintf("%s -delay", convert), interval * 100, "-loop", 
        loop, wildcard, moviename)
    cat("Executing: ", convert, "\n")
    cmd = system(convert)
    if (cmd == 0) 
        cat("Movie has been created at: ", normalizePath(file.path(outdir, 
            moviename)), "\n")
    invisible(cmd)
} 
