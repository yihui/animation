#' Start the generation of an HTML animation page
#'
#' This function copies JavaScript file \file{FUN.js} and CSS file
#' \file{ANI.css} to the same directory as the HTML animation page,
#' create a directory \file{images} and open a graphics device in
#' this directory (the device is specified as \code{ani.dev} in
#' \code{\link{ani.options}}). The prompt of the current R session is
#' modified (by default \code{ANI> }).
#'
#' @param \dots arguments passed to \code{\link{ani.options}} to set
#' animation parameters
#' @return None (invisible \code{NULL}).
#' @note After calling \code{\link{ani.start}}, either animation
#' functions in this package or R script of your own can be used to
#' generate & save animated pictures using proper graphics devices
#' (specified as \code{ani.dev} in \code{\link{ani.options}}), then
#' watch your animation by \code{\link{ani.stop}()}.
#'
#' Note that existing image files in the directory
#' \code{ani.options('imgdir')} will be removed.
#' @author Yihui Xie <\url{http://yihui.name}>
#' @seealso \code{\link{saveHTML}} (the recommended way to create HTML pages),
#' \code{\link{ani.options}}, \code{\link{ani.stop}}
#' @examples
#' ## save the animation in HTML pages and auto-browse it
#' oopt = ani.options(nmax = 20, ani.width = 600, ani.height = 500, interval = 0.2)
#' ani.start()
#' boot.iid()
#' ani.stop()
#' ani.options(oopt)
#'
ani.start = function(...) {
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
    file.copy(system.file("misc", "ANI.css", package = "animation"),
        "ANI.css", overwrite = TRUE)
    file.copy(system.file("misc", "FUN.js", package = "animation"),
        "FUN.js", overwrite = TRUE)
    dev = ani.options("ani.dev")
    if (is.character(dev)) dev = get(dev)
    dev(paste(imgdir, "/%d", ".", ani.options("ani.type"), sep = ""),
        width = ani.options("ani.width"), height = ani.options("ani.height"))
}
