#' Record and replay animations
#'
#' These two functions use \code{\link{recordPlot}} and \code{\link{replayPlot}}
#' to record image frames and replay the animation respectively.
#'
#' One difficulty in capturing images in R (base graphics) is that the
#' off-screen graphics devices cannot capture low-level plotting commands as
#' \emph{new} image files -- only high-level plotting commands can produce new
#' image files; \code{\link{ani.record}} uses \code{\link{recordPlot}} to record
#' the plots when any changes are made on the current plot. For a graphical
#' device to be recordable, you have to call \code{dev.control('enable')} before
#' plotting.
#' @param reset if \code{TRUE}, the recording list will be cleared, otherwise
#'   new plots will be appended to the existing list of recorded plots
#' @param replay.cur whether to replay the current plot (we can set both
#'   \code{reset} and \code{replay.cur} to \code{TRUE} so that low-level
#'   plotting changes can be captured by off-screen graphics devices without
#'   storing all the plots in memory; see Note)
#' @return Invisible \code{NULL}.
#' @note Although we can record changes made by low-level plotting commands
#'   using \code{\link{ani.record}}, there is a price to pay -- we need memory
#'   to store the recorded plots, which are usually verg large when the plots
#'   are complicated (e.g. we draw millions of points or polygons in a single
#'   plot). However, we can set \code{replay.cur} to force R to produce a new
#'   copy of the current plot, which will be automatically recorded by
#'   off-screen grapihcs devices as \emph{new} image files. This method has a
#'   limitation: we must open a screen device to assist R to record the plots.
#'   See the last example below. We must be very careful that no other graphics
#'   devices are opened before we use this function.
#'
#'   If we use base graphics, we should bear in mind that the background colors
#'   of the plots might be transparent, which could lead to problems in HTML
#'   animation pages when we use the \code{\link{png}} device (see the examples
#'   below).
#' @author Yihui Xie
#' @seealso \code{\link{recordPlot}} and \code{\link{replayPlot}};
#'   \code{\link{ani.pause}}
#' @export
#' @example inst/examples/ani.record-ex.R
ani.record = function(reset = FALSE, replay.cur = FALSE) {
  if (reset) .ani.env$.images = list() else {
    ## make sure a graphics device has been opened
    if (dev.cur() != 1) {
      n = length(.ani.env$.images)
      .ani.env$.images[[n + 1]] = recordPlot()
    } else warning('no current device to record from')
  }
  if (replay.cur) {
    tmp = recordPlot()
    dev.hold()
    replayPlot(tmp)
    dev.flush()
  }
  invisible(NULL)
}

#' Replay the animation
#'
#' @details \code{\link{ani.replay}} can replay the recorded plots as an
#'   animation. Moreover, we can convert the recorded plots to other formats
#'   too, e.g. use \code{\link{saveHTML}} and friends.
#'
#'   The recorded plots are stored as a list in \code{.ani.env$.images}, which
#'   is the default value to be passed to \code{\link{ani.replay}};
#'   \code{.ani.env} is an invisible \code{\link{environment}} created when this
#'   package is loaded, and it will be used to store some commonly used objects
#'   such as animation options (\code{\link{ani.options}}).
#'
#' @rdname ani.record
#' @param list a list of recorded plots; if missing, the recorded plots by
#'   \code{\link{ani.record}} will be used
#' @export
ani.replay = function(list) {
  if (missing(list)) list = .ani.env$.images
  lapply(list, function(x) {
    dev.hold()
    replayPlot(x)
    ani.pause()
  })
  invisible(NULL)
}

.ani.env$.images = list()
