#' Convert a sequence of images to a video by FFmpeg
#'
#' This function opens a graphics device to record the images produced in the
#' code \code{expr}, then uses FFmpeg to convert these images to a video.
#'
#' This function uses \code{\link{system}} to call FFmpeg to convert the images
#' to a single video. The command line used in this function is: \command{ffmpeg
#' -y -r <1/interval> -i <img.name>\%d.<ani.type> other.opts video.name}
#'
#' where \code{interval} comes from \code{ani.options('interval')}, and
#' \code{ani.type} is from \code{ani.options('ani.type')}. For more details on
#' the numerous options of FFmpeg, please see the reference.
#' @param expr the R code to draw (several) plots
#' @param img.name the file name of the sequence of images to be generated
#' @param video.name the file name of the output video (e.g.
#'   \file{animation.mp4} or \file{animation.avi})
#' @param ffmpeg the command to call FFmpeg (e.g.
#'   \code{'C:/Software/ffmpeg/bin/ffmpeg.exe'} under Windows); note the full
#'   path of FFmpeg can be pre-specified in \code{\link{ani.options}('ffmpeg')}
#' @param other.opts other options to be passed to \code{ffmpeg}, e.g. we can
#'   specify the bitrate as \code{other.opts = '-b 400k'}
#' @param ... other arguments to be passed to \code{\link{ani.options}}
#' @return An integer indicating failure (-1) or success (0) of the converting
#'   (refer to \code{\link{system}}).
#' @author Yihui Xie, based on an inital version by Thomas Julou
#'   \email{thomas.julou@@gmail.com}
#' @note There are a lot of possibilities in optimizing the video. My knowledge
#'   on FFmpeg is very limited, hence the default output by this function could
#'   be of low quality or too large. The file \file{presets.xml} of WinFF might
#'   be a good guide: \url{http://code.google.com/p/winff/}.
#' @references \url{http://ffmpeg.org/documentation.html}
#' @family utilities
#' @export
#' @example inst/examples/saveVideo-ex.R
saveVideo = function(
  expr, video.name = 'animation.mp4', img.name = 'Rplot', ffmpeg = 'ffmpeg',
  other.opts = if (grepl('[.]mp4$', video.name)) '-pix_fmt yuv420p', ...
) {
  oopt = ani.options(...)
  on.exit(ani.options(oopt))
  owd = setwd(tempdir())
  on.exit(setwd(owd), add = TRUE)

  if (!is.null(ani.options('ffmpeg'))) {
    ffmpeg = ani.options('ffmpeg')
  }
  if (!grepl('^["\']', ffmpeg)) ffmpeg = shQuote(ffmpeg)

  version = try(system(paste(ffmpeg, '-version'), intern = TRUE))
  if (inherits(version, 'try-error')) {
    warning('The command "', ffmpeg, '" is not available in your system. Please install FFmpeg first: ',
            ifelse(.Platform$OS.type == 'windows', 'http://ffmpeg.arrozcru.org/autobuilds/',
                   'http://ffmpeg.org/download.html'))
    return()
  }

  ani.dev = ani.options('ani.dev')
  file.ext = ani.options('ani.type')
  interval = ani.options('interval')
  if (is.character(ani.dev)) ani.dev = get(ani.dev)

  num = ifelse(file.ext == 'pdf', '', '%d')
  unlink(paste(img.name, '*.', file.ext, sep = ''))
  img.fmt = paste(img.name, num, '.', file.ext, sep = '')
  img.fmt = file.path(tempdir(), img.fmt)
  ani.options(img.fmt = img.fmt)
  if ((use.dev <- ani.options('use.dev')))
    ani.dev(img.fmt, width = ani.options('ani.width'),
            height = ani.options('ani.height'))
  in_dir(owd, expr)
  if (use.dev) dev.off()

  ## call FFmpeg
  ffmpeg = paste(ffmpeg, '-y', '-r', 1/ani.options('interval'), '-i',
                 basename(img.fmt), other.opts, basename(video.name))
  message('Executing: ', ffmpeg)
  cmd = system(ffmpeg)

  if (cmd == 0) {
    setwd(owd)
    file.copy(file.path(tempdir(), basename(video.name)), video.name)
    message('\n\nVideo has been created at: ',
            output.path <- normalizePath(video.name))
    auto_browse(output.path)
  }
  invisible(cmd)
}
