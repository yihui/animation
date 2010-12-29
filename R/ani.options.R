##' Set or query animation options.
##' There are various parameters that control the behaviour of the
##' animation, such as time interval, maximum number of animation frames,
##' height and width, etc.
##'
##' The supported animation parameters:
##' \describe{
##'
##' \item{interval}{ a positive
##' number to set the time interval of the animation (unit in seconds); default
##' to be 1. }
##'
##' \item{nmax}{ maximum number of steps in a loop (e.g.
##' iterations) to create animation frames. Note: the actual number of frames
##' can be less than this number, depending on specific animations. Default to
##' be 50.}
##'
##' \item{ani.width, ani.height}{ width and height of image frames
##' (unit in px); see graphics devices like \code{\link[grDevices]{png}},
##' \code{\link[grDevices]{jpeg}}, ...; default to be 480. NB: for different
##' graphics devices, the units of these values might be different, e.g.
##' PDF devices usually use inches, whereas bitmap devices often use pixels.}
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
##' \item{ani.dev}{a
##' function or a function name: the graphics device; e.g.
##' (\code{\link[grDevices]{png}}, \code{\link[grDevices]{pdf}}, ...); default
##' to be \code{"png"}} \item{title}{character: the title of animation }
##'
##' \item{ani.type}{character: image format for animation frames, e.g.
##' \code{png}, \code{jpeg}, ...; default to be \code{"png"}; this will be
##' used as the file extension of images, so don't forget to change this
##' option as well when you changed the option \code{ani.dev}}
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
##' values.  The tags usually come from the animation parameters described
##' below, but they are not restricted to these tags (any tag can be used;
##' this is similar to \code{\link[base]{options}}).
##' @return \code{ani.options()} returns a list containing the options:
##' when parameters are set, their former values are returned in an invisible
##'   named list.  Such a list can be passed as an argument to
##'   \code{\link{ani.options}} to restore the parameter values.
##'
##' \code{ani.options('tag')} returns the value of the option \code{'tag'}.
##'
##' \code{ani.options(c('tag1', 'tag2'))} returns a list containing the
##' corresponding options.
##' @note Please note that \code{nmax} is not always equal to the
##' number of animation frames. Sometimes there is more than one
##' frame recorded in a single step of a loop, for instance, there are
##' 2 frames generated in each step of \code{\link{kmeans.ani}}, and 4
##' frames in \code{\link{knn.ani}}, etc; whereas for
##' \code{\link{newton.method}}, the number of animation frames is not
##' definite, because there are other criteria to break the loop.
##'
##' This function can be used for almost all the animation functions
##' such as \code{\link{brownian.motion}}, \code{\link{boot.iid}},
##' \code{\link{buffon.needle}}, \code{\link{cv.ani}},
##' \code{\link{flip.coin}}, \code{\link{kmeans.ani}},
##' \code{\link{knn.ani}}, etc. Most of the options here will affect
##' the behaviour of animations of the formats HTML, GIF, SWF and PDF;
##' on-screen animations are only affected by \code{interval} and \code{nmax}.
##'
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[base]{options}}, \code{\link[grDevices]{dev.interactive}}
##' @references \url{http://animation.yihui.name/animation:options}
##' @keywords misc
##' @examples
##' ## see the first example in help(animation) on how to set and restore
##' ##   animation options
##'
##' ## use the PDF device: remember to set 'ani.type' accordingly
##' oopt = ani.options(ani.dev = 'pdf', ani.type = 'pdf', ani.height = 5, ani.width = 7)
##'
##' ## use the Cairo PDF device
##' # if (require('Cairo')) {
##' #     ani.options(ani.dev = CairoPDF, ani.type = 'pdf',
##' #                 ani.height = 6, ani.width = 6)
##' # }
##'
##' ## change outdir to the current working directory
##' ani.options(outdir = getwd())
##'
##' ## don't loop for GIF/HTML animations
##' ani.options(loop = FALSE)
##'
##' ## don't try to open the output automatically
##' ani.options(autobrowse = FALSE)
##'
##' ## it's a good habit to restore the options in the end so that
##' ##   other code will not be affected
##' ani.options(oopt)
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
                .ani.opts[names(lst)] = lst
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
