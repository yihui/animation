##' Set or query animation options.
##' There are various parameters that control the behaviour of the
##' animation, such as time interval, maximum frames, height and width, etc.
##'
##' The supported animation parameters:
##' \describe{
##'
##' \item{interval}{ a positive
##' number to set the time interval of the animation (unit in seconds); default
##' to be 1. }
##'
##' \item{nmax}{ maximum number of steps for a loop (e.g.
##' iterations) to create animation frames. Note: the actual number of frames
##' can be less than this number, depending on specific animations. Default to
##' be 50.}
##'
##' \item{ani.width, ani.height}{ width and height of image frames
##' (unit in px); see graphics devices like \code{\link[grDevices]{png}},
##' \code{\link[grDevices]{jpeg}}, ...; default to be 480.}
##'
##' \item{outdir}{character: specify the output dir if we want to create HTML
##' animation pages; default to be \code{\link[base]{tempdir}}.}
##'
##' \item{imgdir}{character: the name of the directory (a relative path) for
##' images when creating HTML animation pages; default to be \code{"images"}.}
##'
##' \item{htmlfile}{character: name of the target HTML main file (without path
##' name; basename only; default to be \code{"index.html"})}
##'
##' \item{withprompt}{character: prompt to display while
##' using \code{\link{ani.start}} (restore with \code{\link{ani.stop}})}
##'
##' \item{ani.type}{character: image format for animation frames, e.g.
##' \code{png}, \code{jpg}, ...; default to be \code{"png"}}; this will be
##' used as the file extension of images
##'
##' \item{ani.dev}{a
##' function or a function name: the graphics device; e.g.
##' (\code{\link[grDevices]{png}}, \code{\link[grDevices]{jpeg}}, ...); default
##' to be \code{"png"}} \item{title}{character: the title of animation }
##'
##' \item{description}{character: a description about the animation }
##'
##' \item{verbose}{ logical or character: if \code{TRUE}, write a footer part in
##' the HTML page containing detailed technical information; if
##' given a character string, it will be used as the footer message; in other
##' cases, the footer of the page will be blank.}
##'
##' \item{loop}{whether to
##' iterate or not (default \code{TRUE} to iterate for infinite times)}
##'
##' \item{autobrowse}{logical: whether auto-browse the animation page
##' immediately after it is created? (default to be \code{interactive()})}
##'
##' \item{autoplay}{logical: whether to autoplay the animation when the HTML
##' page is loaded (default to be \code{TRUE}); only applicable to
##' \code{\link{saveHTML}}}
##'
##' }
##'
##' @param ... arguments in \code{tag = value} form, or a list of tagged
##' values.  The tags must come from the animation parameters described
##' below.
##' @return a list containing the options.
##'
##' When parameters are set, their former values are returned in an invisible
##'   named list.  Such a list can be passed as an argument to
##'   \code{\link{ani.options}} to restore the parameter values.
##' @note Please note that \code{nmax} is usually equal to the number of
##'   animation frames (e.g. for \code{\link{brownian.motion}}) but not
##'   \emph{always}! The reason is that sometimes there are more than one frame
##'   recorded in a single step of a loop, for instance, there are 2 frames
##'   generated in each step of \code{\link{kmeans.ani}}, and 4 frames in
##'   \code{\link{knn.ani}}, etc.
##'
##' This function can be used for almost all the animation functions such as
##'   \code{\link{brownian.motion}}, \code{\link{boot.iid}},
##'   \code{\link{buffon.needle}}, \code{\link{cv.ani}},
##'   \code{\link{flip.coin}}, \code{\link{kmeans.ani}}, \code{\link{knn.ani}},
##'   etc. All the parameters will affect the behaviour of HTML animations, but
##'   only \code{interval} will affect animations in windows graphics device.
##'
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[grDevices]{dev.interactive}}
##' @references \url{http://animation.yihui.name/animation:options}
##' @keywords misc
##' @examples
##'
##' \dontrun{
##' # store the old option to restore it later
##' oopt = ani.options(interval = 0.05, nmax = 100, ani.dev = "png",
##'     ani.type = "png")
##' ani.start()
##' opar = par(mar = c(3, 3, 2, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
##'     cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
##' brownian.motion( pch = 21, cex = 5, col = "red", bg = "yellow",
##'     main = "Demonstration of Brownian Motion",)
##' par(opar)
##' ani.stop()
##' ani.options(oopt)
##' }
##'
ani.options = function(...) {
    lst = list(...)
    .ani.opts = .ani.env$.ani.opts
    if (length(lst)) {
        if (is.null(names(lst)) && !is.list(lst[[1]])) {
            lst = unlist(lst)
            if (length(lst) == 1) .ani.opts[[lst]] else .ani.opts[lst]
        } else {
            omf = .ani.opts
            if (is.list(lst[[1]]))
                lst = lst[[1]]
            if (length(lst) > 0) {
                .ani.opts[pmatch(names(lst), names(.ani.opts))] = lst
                .ani.env$.ani.opts = .ani.opts
                if (!identical(omf$nmax, .ani.opts$nmax) && interactive()) {
                    message("animation option 'nmax' changed: ", omf$nmax,
                            " --> ", .ani.opts$nmax)
                }
            }
            invisible(omf)
        }
    } else {
        .ani.opts
    }
}

## create an environment to store animation options
.ani.env = new.env()
