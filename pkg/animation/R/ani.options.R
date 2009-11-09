ani.options <- function(...) {
    mf = list(interval = 1, nmax = 50, ani.width = 480, ani.height = 480, 
        outdir = tempdir(), imgdir = "images", filename = "index.htm", 
        withprompt = "ANI> ", ani.type = "png", ani.dev = "png", 
        title = "Statistical Animations Using R", description = "This is an animation.", 
        footer = TRUE, loop = TRUE, autobrowse = TRUE, msg = interactive())
    if (is.null(getOption("ani"))) 
        options(ani = mf)
    else mf = getOption("ani")
    oomf = mf
    lst = list(...)
    if (length(lst)) {
        if (is.null(names(lst)) & !is.list(lst[[1]])) {
            if (identical(unlist(lst), "interval") & !interactive()) 
                res = 0
            else res = getOption("ani")[unlist(lst)][[1]]
            
        }
        else {
            omf = mf
            mc = list(...)
            if (is.list(mc[[1]])) 
                mc = mc[[1]]
            if (length(mc) > 0) 
                mf[pmatch(names(mc), names(mf))] = mc
            options(ani = mf)
            res = omf
        }
    }
    else {
        res = getOption("ani")
    }
    nnmf = getOption("ani")
    if (isTRUE(nnmf$msg)) {
        if (!identical(oomf, nnmf)) {
            if (is.function(nnmf$ani.dev) | is.function(oomf$ani.dev)) {
                nnmf$ani.dev = NULL
                oomf$ani.dev = NULL
            }
            for (i in names(oomf)) {
                if (!identical(oomf[[i]], nnmf[[i]])) {
                  if (!(i %in% c("interval", "outdir"))) {
                    message("option '", i, "' changed: ", oomf[[i]], 
                      " --> ", nnmf[[i]])
                  }
                  else {
                    if ((i == "interval") & length(nnmf$interval) == 
                      1) 
                      message("option '", i, "' changed: ", oomf[[i]], 
                        " --> ", nnmf[[i]])
                    if ((i == "outdir") & length(nnmf$outdir) == 
                      1) 
                      message("option '", i, "' changed: ", oomf[[i]], 
                        " --> ", nnmf[[i]])
                  }
                }
            }
        }
    }
    invisible(res)
} 
