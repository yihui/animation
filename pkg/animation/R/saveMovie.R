`saveMovie` <- function(expr, interval = 1, moviename = "movie", 
    movietype = "gif", loop = 0, dev = png, filename = "Rplot", 
    fmt = "%03d", outdir = tempdir(), para = par(no.readonly = TRUE),
    ...) {
    olddir <- setwd(outdir)
    on.exit(setwd(olddir))
    dev(filename = paste(filename, fmt, ".", deparse(substitute(dev)), 
        sep = ""), ...)
    par(para)
    eval(expr)
    dev.off()
    if (.Platform$OS.type == "windows") 
        system <- shell
    version <- system("convert --version", intern = TRUE)
    if (!length(grep("ImageMagick", version))) 
        stop("ImageMagick not found; please install ImageMagick first: http://www.imagemagick.org")
    moviename <- paste(moviename, ".", movietype, sep = "")
    wildcard <- paste(filename, "*.", deparse(substitute(dev)), 
        sep = "")
    convert <- paste("convert -delay", interval * 100, "-loop", 
        loop, wildcard, moviename)
    cat("Executing: ", convert, "\n")
    cmd = system(convert)
    if (cmd == 0) cat("Movie has been created at: ", normalizePath(file.path(outdir, 
        moviename)), "\n")
    invisible(cmd)
} 
