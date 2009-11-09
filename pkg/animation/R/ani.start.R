`ani.start` <- function(...) {
    ani.options(...)
    ani.options(withprompt = c(options(prompt = ani.options("withprompt"))$prompt,
        ani.options("withprompt")))
    ani.options(outdir = c(ani.options("outdir"), setwd(ani.options("outdir"))))
    imgdir = ani.options("imgdir")
    if (!file.exists(imgdir)) {
        dir.create(imgdir)
    }
    else {
        file.remove(list.files(imgdir, full.names = TRUE))
    }
    file.copy(system.file("js", "ANI.css", package = "animation"),
        "ANI.css", overwrite = TRUE)
    file.copy(system.file("js", "FUN.js", package = "animation"),
        "FUN.js", overwrite = TRUE)
    ani.options(interval = c(0, ani.options("interval")))
    dev = ani.options("ani.dev")
    if (is.character(dev)) dev = get(dev)
    dev(filename = paste(imgdir, "/%d", ".", ani.options("ani.type"), sep = ""),
        width = ani.options("ani.width"), height = ani.options("ani.height"))
}
