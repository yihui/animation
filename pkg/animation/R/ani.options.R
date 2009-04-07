`ani.options` <- function(...) {
    mf = list(interval = 1, nmax = 50, ani.width = 480,
        ani.height = 480, outdir = tempdir(), filename = "index.htm",
        withprompt = "ANI> ", ani.type = "png", ani.dev = png,
        title = "Statistical Animations Using R", description = "This is an animation.",
        footer = TRUE, autobrowse = TRUE)
    if (is.null(getOption("ani")))
        options(ani = mf)
    else mf = getOption("ani")
    lst = list(...)
    if (length(lst)) {
        if (is.null(names(lst)) & !is.list(lst[[1]])) {
            getOption("ani")[unlist(lst)][[1]]
        }
        else {
            omf = mf
            mc = list(...)
            if (is.list(mc[[1]]))
                mc = mc[[1]]
            if (length(mc) > 0)
                mf[pmatch(names(mc), names(mf))] = mc
            options(ani = mf)
            return(invisible(omf))
        }
    }
    else {
        getOption("ani")
    }
}
