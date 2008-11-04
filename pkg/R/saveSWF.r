`saveSWF` <- function(expr, interval = 1, swfname = "movie.swf", 
    dev = c("png", "jpeg", "pdf"), filename = "Rplot", fmt = "%03d", 
    outdir = tempdir(), swftools = NULL, para = par(no.readonly = TRUE),
    ...) {
    olddir <- setwd(outdir)
    on.exit(setwd(olddir))
    anidev = switch(dev, png = png, jpeg = jpeg, pdf = pdf)
    anidev(paste(filename, fmt, ".", dev, sep = ""), ...)
    par(para)
    eval(expr)
    dev.off()
    tool = ifelse(is.null(swftools), paste(dev, "2swf", sep = ""), 
        shQuote(file.path(swftools, paste(dev, "2swf", sep = ""))))
    if (.Platform$OS.type == "windows") 
        system <- shell
    version <- system(tool, intern = TRUE)
    if (length(version) < 10) 
        stop("swftools not found; please install swftools first: http://www.swftools.org")
    cat("Flash will be created at: ", normalizePath(file.path(outdir, 
        swfname)), "\n")
    wildcard <- paste(filename, "*.", dev, sep = "")
    convert <- paste(tool, wildcard, "-o", swfname)
    if (dev == "png" | dev == "jpeg") {
        convert = paste(convert, "-r", 1/interval)
        cat("Executing: ", convert, "\n")
        system(convert)
    }
    else {
        convert = paste(convert, " -s framerate=", 1/interval, sep = "")
        cat("Executing: ", convert, "\n")
        system(convert)
    }
} 
