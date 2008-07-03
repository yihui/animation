`ani.start` <- function(...) {
    ani.options(...)
    ani.options(withprompt = c(options(prompt = ani.options("withprompt"))$prompt,
        ani.options("withprompt")))
    ani.options(outdir = c(ani.options("outdir"), setwd(ani.options("outdir"))))
    if (!file.exists("images")) {
        dir.create("images")
    }
    else {
        file.remove(list.files("images", full.names = TRUE))
    }
    file.copy(system.file("js", "ANI.css", package = "animation"),
        "ANI.css", overwrite = TRUE)
    file.copy(system.file("js", "FUN.js", package = "animation"),
        "FUN.js", overwrite = TRUE)
    ani.options(interval = c(0, ani.options("interval")))
    dev = ani.options("ani.dev")
    dev(filename = paste("images/%d", ".", ani.options("ani.type"), sep = ""),
        width = ani.options("ani.width"), height = ani.options("ani.height"))
}
