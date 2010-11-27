im.convert = function(files, interval = ani.options("interval"),
    loop = 0, output = "animation.gif", extra.opts = "", outdir = getwd(),
    convert = "convert", cmd.fun, clean = FALSE) {
    output.path = file.path(outdir, output)
    if (missing(cmd.fun))
        cmd.fun = if (.Platform$OS.type == "windows")
            shell
        else system
    version = cmd.fun(sprintf("%s --version", convert), intern = TRUE)
    # try to look for ImageMagick in the Windows Registry Hive,
    # the Program Files directory and the LyX installation
    if (!length(grep("ImageMagick", version))) {
        message("I cannot find ImageMagick with convert = ",
            shQuote(convert))
        if (.Platform$OS.type == "windows") {
            if (!inherits(try({
                magick.path = readRegistry("SOFTWARE\\ImageMagick\\Current")$BinPath
            }, silent = TRUE), "try-error")) {
                if (nzchar(magick.path)) {
                  convert = shQuote(normalizePath(file.path(magick.path,
                    "convert.exe")))
                  message("but I can find it from the Registry Hive: ",
                    magick.path)
                }
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
            else if (!inherits(try({
                magick.path = readRegistry("LyX.Document\\Shell\\open\\command",
                  "HCR")
            }, silent = TRUE), "try-error")) {
                convert = shQuote(normalizePath(file.path(dirname(gsub("(^\"|\" \"%1\"$)",
                  "", magick.path[[1]])), "..", "imagemagick",
                  "convert.exe")))
                message("but I can find it from the LyX installation: ",
                  dirname(convert))
            }
            else stop("ImageMagick not installed yet!")
        }
        else {
            stop("Please install ImageMagick first or give the full path of the 'convert' command \n(e.g. 'C:\\Program Files\\ImageMagick\\convert.exe')")
        }
    }
    input = paste(files, collapse = " ")
    convert = sprintf("%s -delay %s -loop %s %s %s %s", convert,
        interval * 100, loop, extra.opts, input, output.path)
    message("Executing: ", convert)
	flush.console()
    cmd = cmd.fun(convert)
    if (cmd == 0) {
        message("Output at: ", output.path)
        if (clean)
            unlink(files)
        if (interactive() & ani.options('autobrowse')) {
			switch(.Platform$OS.type,
				windows = try(shell.exec(output.path)),
				unix = try(system(paste('xdg-open ', output.path)), TRUE))
			if (Sys.info()["sysname"] == "Darwin")
				try(system(paste('open ', output.path)), TRUE)
			}
        return(invisible(output.path))
    }
    else {
        message("There seems to be an error in the conversion...")
    }
}
