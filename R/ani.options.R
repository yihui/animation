

#' Set or Query Animation Parameters
#' Set or query various parameters that control the behaviour of the animation,
#' such as time interval, maximum frames, height and width, etc. This function
#' is based on \code{\link{options}} to set an option \code{ani} which is a
#' list containing the animation parameters.
#' 
#' The supported animation parameters: \describe{ \item{interval a positive
#' number to set the time interval of the animation (unit in seconds); default
#' to be 1. } \item{nmax maximum number of steps for a loop (e.g. iterations)
#' to create animation frames. Note: the actual number of frames can be less
#' than this number, depending on specific animations. Default to be 50.}
#' \item{ani.width, ani.height width and height of image frames (unit in px);
#' see graphics devices like \code{\link{png}}, \code{\link{jpeg}}, ...;
#' default to be 480.} \item{outdircharacter: specify the output dir if we want
#' to create HTML animation pages; default to be \code{\link{tempdir}}.}
#' \item{imgdircharacter: the name of the directory (a relative path) for
#' images when creating HTML animation pages; default to be \code{"images"}.}
#' \item{filenamecharacter: name of the target HTML main file (without path
#' name; basename only)} \item{withpromptcharacter: prompt to display while
#' using \code{\link{ani.start}} (restore with \code{\link{ani.stop}})}
#' \item{ani.typecharacter: image format for animation frames, e.g. \code{png},
#' \code{jpg}, ...; default to be \code{"png"}} \item{ani.deva function or a
#' function name: the graphics device; e.g. (\code{\link{png}},
#' \code{\link{jpeg}}, ...); default to be \code{"png"}} \item{titlecharacter:
#' the title of animation } \item{descriptioncharacter: a description about the
#' animation } \item{footer logical or character: if \code{TRUE}, write a foot
#' part in the HTML page containing information such as date/time of creation;
#' if given a character string, it will be used as the footer message; in other
#' cases, the footer of the page will be blank.} \item{loopwhether to iterate
#' or not (default \code{TRUE} to interate for infinite times)}
#' \item{autobrowselogical: whether auto-browse the animation page immediately
#' after it is created?} }
#' 
#' @param \dots arguments in \code{tag = value} form, or a list of tagged
#'   values.  The tags must come from the animation parameters described below.
#' @return a list containing the options.
#' 
#' When parameters are set, their former values are returned in an invisible
#'   named list.  Such a list can be passed as an argument to
#'   \code{\link{ani.options}} to restore the parameter values.
#' @note Please note that \code{nmax} is usually equal to the number of
#'   animation frames (e.g. for \code{\link{brownian.motion}}) but not
#'   \emph{always}! The reason is that sometimes there are more than one frame
#'   recorded in a single step of a loop, for instance, there are 2 frames
#'   generated in each step of \code{\link{kmeans.ani}}, and 4 frames in
#'   \code{\link{knn.ani}}, etc.
#' 
#' This function can be used for almost all the animation functions such as
#'   \code{\link{brownian.motion}}, \code{\link{boot.iid}},
#'   \code{\link{buffon.needle}}, \code{\link{cv.ani}},
#'   \code{\link{flip.coin}}, \code{\link{kmeans.ani}}, \code{\link{knn.ani}},
#'   etc. All the parameters will affect the behaviour of HTML animations, but
#'   only \code{interval} will affect animations in windows graphics device.
#' 
#' When R is not running interactively, \code{interval} will be set to 0
#'   because it does not make much sense to let R wait for a possibly very long
#'   time when we cannot watch the animations in real time.
#' @author Yihui Xie <\url{http://yihui.name}>
#' @seealso \code{\link{options}}
#' @references \url{http://animation.yihui.name/animation:options}
#' @keywords misc
#' @examples
#' 
#' \dontrun{
#' # store the old option to restore it later
#' oopt = ani.options(interval = 0.05, nmax = 100, ani.dev = "png", 
#'     ani.type = "png")
#' ani.start() 
#' opar = par(mar = c(3, 3, 2, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
#'     cex.axis = 0.8, cex.lab = 0.8, cex.main = 1) 
#' brownian.motion( pch = 21, cex = 5, col = "red", bg = "yellow",
#'     main = "Demonstration of Brownian Motion",)
#' par(opar)
#' ani.stop() 
#' ani.options(oopt)
#' }
#' 
ani.options <- function(...) {
    mf = list(interval = 1, nmax = 50, ani.width = 480, ani.height = 480, 
        outdir = tempdir(), imgdir = "images", filename = "index.htm", 
        withprompt = "ANI> ", ani.type = "png", ani.dev = "png", 
        title = "Statistical Animations Using R", description = "This is an animation.", 
        footer = TRUE, loop = TRUE, autobrowse = TRUE)
    if (is.null(getOption("ani"))) 
        options(ani = mf)
    else mf = getOption("ani")
    lst = list(...)
    if (length(lst)) {
        if (is.null(names(lst)) & !is.list(lst[[1]])) {
            if (identical(unlist(lst), "interval") & !interactive()) 
                0
            else getOption("ani")[unlist(lst)][[1]]
            
        }
        else {
            omf = mf
            mc = list(...)
            if (is.list(mc[[1]])) 
                mc = mc[[1]]
            if (length(mc) > 0) 
                mf[pmatch(names(mc), names(mf))] = mc
            options(ani = mf)
            if (!identical(omf$nmax, mf$nmax) & interactive()) {
                message("animation option 'nmax' changed: ", omf$nmax, " --> ", mf$nmax)
            }
            invisible(omf)
        }
    }
    else {
        getOption("ani")
    }
} 
