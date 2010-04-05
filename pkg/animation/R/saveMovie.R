saveMovie <- function(expr, interval = 1, moviename = "movie",
    movietype = "gif", loop = 0, dev = png, filename = "Rplot",
    fmt = "%03d", outdir = tempdir(), convert = "convert", cmd.fun,
    clean = TRUE, ani.first = NULL, para = par(no.readonly = TRUE),
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
    if (missing(cmd.fun))
        cmd.fun = if (.Platform$OS.type == "windows")
            shell
        else system
    version = cmd.fun(sprintf("%s --version", convert), intern = TRUE)
    if (!length(grep("ImageMagick", version))) {
        message("ImageMagick cannot be found by setting convert = ",
            shQuote(convert))
        if (.Platform$OS.type == "windows") {
            magick.path = readRegistry("SOFTWARE\\ImageMagick\\Current")$BinPath
            if (nzchar(magick.path)) {
                convert = shQuote(normalizePath(file.path(magick.path,
                  "convert.exe")))
                message("but I can find it from the Registry Hive: ",
                  magick.path)
            }
            else if (nzchar(prog <- Sys.getenv("ProgramFiles")) &&
                length(magick.dir <- list.files(prog, "^ImageMagick.*")) &&
                length(magick.path <- list.files(file.path(prog,
                  magick.dir), pattern = "^convert\\.exe$", full.names = TRUE,
                  recursive = TRUE))) {
                convert = shQuote(normalizePath(magick.path[1]))
                message("but I can find it from the 'Program Files' directory: ",
                  magick.path)
            }
            else stop("ImageMagick not installed yet!")
        }
        else {
            stop("Please install ImageMagick first or give the full path of the 'convert' command.")
        }
    }
    moviename = paste(moviename, ".", movietype, sep = "")
    wildcard = paste(filename, "*.", deparse(substitute(dev)),
        sep = "")
    convert = paste(sprintf("%s -delay", convert), interval *
        100, "-loop", loop, wildcard, moviename)
    message("Executing: ", convert)
    cmd = cmd.fun(convert)
    if (cmd == 0) {
        message("Movie has been created at: ", movie.path <- normalizePath(file.path(outdir,
            moviename)))
        if (clean)
            unlink(list.files(pattern = paste(filename, ".*\\.",
                deparse(substitute(dev)), sep = "")))
        if (.Platform$OS.type == "windows")
            try(shell.exec(movie.path))
    }
    else {
        message("There seems to be an error in the conversion...")
    }
    invisible(cmd)
}
