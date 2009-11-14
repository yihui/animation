saveMovie <- function(expr, interval = 1, moviename = "movie", 
    movietype = "gif", loop = 0, dev = png, filename = "Rplot", 
    fmt = "%03d", outdir = tempdir(), para = par(no.readonly = TRUE), 
    ...) {
    installImageMagick <- function() {
        owd = setwd(Sys.getenv("HOME"))
        windows_config <- list(magick_url = "http://www.imagemagick.org/download/binaries/ImageMagick-6.5.7-7-Q16-windows-dll.exe", 
            installer = function(path) {
                shell(path)
            })
        darwin_config <- list(magick_url = "http://www.imagemagick.org/download/binaries/ImageMagick-i386-apple-darwin10.0.0.tar.gz", 
            installer = function(path) {
                system(sprintf("tar xvfz %s", basename(path)))
                system("export MAGICK_HOME=\"$HOME/ImageMagick-6.5.5\"")
                system("export PATH=\"$MAGICK_HOME/bin:$PATH\"")
                system("export DYLD_LIBRARY_PATH=\"$MAGICK_HOME/lib\"")
            })
        unix_config <- NULL
        magick_web <- "http://www.imagemagick.org"
        install_system_dep <- function(dep_name, dep_url, dep_web, 
            installer) {
            if (!interactive()) {
                message("Please install ", dep_name, " from ", 
                  dep_url)
                return()
            }
            choice <- menu(paste(c("Install", "Do not install"), 
                dep_name), TRUE, paste("Need", dep_name, "?"))
            if (choice == 1) {
                path <- file.path(getwd(), basename(dep_url))
                if (download.file(dep_url, path, mode = "wb") > 
                  0) 
                  stop("Failed to download ", dep_name)
                installer(path)
            }
            message("If 'convert' still does not work, please make sure it is in the 'PATH' variable of your system.")
            message("Learn more about ", dep_name, " at ", dep_web)
        }
        
        install_all <- function() {
            if (.Platform$OS.type == "windows") 
                config <- windows_config
            else if (length(grep("darwin", R.version$platform))) 
                config <- darwin_config
            else config <- unix_config
            
            if (is.null(config)) 
                stop("Sorry, I'm not familiar with this platform.", 
                  "Please install ImageMagick manually, if necessary. See: ", 
                  magick_web)
            
            install_system_dep("ImageMagick", config$magick_url, 
                magick_web, config$installer)
        }
        
        install_all()
        setwd(owd)
    }    
    
    olddir = setwd(outdir)
    on.exit(setwd(olddir))
    oopt = ani.options(interval = 0)
    dev(filename = paste(filename, fmt, ".", deparse(substitute(dev)), 
        sep = ""), ...)
    par(para)
    eval(expr)
    dev.off()
    ani.options(oopt)
    if (.Platform$OS.type == "windows") 
        system <- shell
    version <- system("convert --version", intern = TRUE)
    if (!length(grep("ImageMagick", version))) {
        message("ImageMagick not found; I will try to install it.")
        installImageMagick()
    }
    moviename <- paste(moviename, ".", movietype, sep = "")
    wildcard <- paste(filename, "*.", deparse(substitute(dev)), 
        sep = "")
    convert <- paste("convert -delay", interval * 100, "-loop", 
        loop, wildcard, moviename)
    cat("Executing: ", convert, "\n")
    cmd = system(convert)
    if (cmd == 0) 
        cat("Movie has been created at: ", normalizePath(file.path(outdir, 
            moviename)), "\n")
    invisible(cmd)
} 
