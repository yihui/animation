saveLatex <- function(expr, interval = ani.options("interval"), 
    nmax = ani.options("nmax"), ani.dev = "pdf", outdir = ani.options("outdir"), 
    ani.basename = "Rplot", ani.ext = "pdf", num = ifelse(ani.ext == 
        "pdf", "", "%d"), ani.first = par(), ani.opts = "controls,width=\\textwidth", 
    centering = "\\centering", caption = NULL, label = NULL, 
    pkg.opts = NULL, documentclass = "article", latex.filename = "animation.tex", 
    pdflatex = "pdflatex", install.animate = TRUE, ...) {
    odir = setwd(outdir)
    interval = interval
    oopt = ani.options(interval = 0)
    on.exit(setwd(odir))
    on.exit(ani.options(oopt), add = TRUE)
    if (is.character(ani.dev)) 
        ani.dev = get(ani.dev)
    ani.dev(sprintf("%s%s.%s", ani.basename, num, ani.ext), ...)
    eval(ani.first)
    eval(expr)
    dev.off()
    if (install.animate) {
        file.copy(system.file("js", "animate.sty", package = "animation"),
            "animate.sty", overwrite = TRUE)
        file.copy(system.file("js", "animfp.sty", package = "animation"),
            "animfp.sty", overwrite = TRUE)    
    }
    cat(sprintf(paste("\\documentclass{%s}", "\\usepackage%s{animate}", 
        "\\begin{document}", "\\begin{figure}", "%s", "\\animategraphics[%s]{%s}{%s}{%d}{%d}%s%s", 
        "\\end{figure}", "\\end{document}", sep = "\n"), documentclass, 
        ifelse(is.null(pkg.opts), "", sprintf("[%s]", pkg.opts)), 
        centering, ani.opts, 1/interval, ani.basename, 0, nmax - 1, 
        ifelse(is.null(caption), "", sprintf("\\caption{%s}", 
            caption)), ifelse(is.null(label), "", sprintf("\\label{%s}", 
            label))), "\n", file = latex.filename)
    message("LaTeX document created at: ", file.path(getwd(), 
        latex.filename))
    if ((latex.filename != "") & !is.null(pdflatex)) {
        if (system(sprintf("%s %s", pdflatex, latex.filename), 
            show.output.on.console = FALSE) == 0) {
            message(sprintf("successfully compiled: %s %s", pdflatex, 
                latex.filename))
            if (ani.options("autobrowse")) 
                system(sprintf("%s %s", getOption("pdfviewer"), 
                  sprintf("%s.pdf", sub("([^.]+)\\.[[:alnum:]]+$", 
                    "\\1", latex.filename))))
        }
        else message("An error occurred while compiling the LaTeX document; \nyou should probably take a look at the log file: ", 
            sprintf("%s.log", sub("([^.]+)\\.[[:alnum:]]+$", 
                "\\1", latex.filename)), " under ", getwd())
    }
    invisible(NULL)
}
