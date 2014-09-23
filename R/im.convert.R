#' A wrapper for the `convert' utility of ImageMagick or GraphicsMagick
#'
#' The main purpose of these two functions is to create GIF animations.
#'
#' The function \code{im.convert} simply wraps the arguments of the
#' \command{convert} utility of ImageMagick to make it easier to call
#' ImageMagick in R;
#' @rdname convert
#' @param files either a character vector of file names, or a single string
#'   containing wildcards (e.g. \file{Rplot*.png})
#' @param output the file name of the output (with proper extensions, e.g.
#'   \code{gif})
#' @param convert the \command{convert} command; it must be either
#'   \code{'convert'} or \code{'gm convert'}; and it can be pre-specified as an
#'   option in \code{\link{ani.options}('convert')}, e.g. (Windows users)
#'   \code{ani.options(convert = 'c:/program
#'   files/imagemagick/convert.exe')}, or (Mac users) \code{ani.options(convert
#'   = '/opt/local/bin/convert')}; see the Note section for more details
#' @param cmd.fun a function to invoke the OS command; by default
#'   \code{\link{system}}
#' @param extra.opts additional options to be passed to \command{convert} (or
#'   \command{gm convert})
#' @param clean logical: delete the input \code{files} or not
#' @return The command for the conversion.
#'
#'   If \code{ani.options('autobrowse') == TRUE}, this function will also try to
#'   open the output automatically.
#' @note If \code{files} is a character vector, please make sure the order of
#'   filenames is correct! The first animation frame will be \code{files[1]},
#'   the second frame will be \code{files[2]}, ...
#'
#'   Both ImageMagick and GraphicsMagick may have a limit on the number of
#'   images to be converted. It is a known issue that this function can fail
#'   with more than (approximately) 9000 images. The function
#'   \code{\link{saveVideo}} is a better alternative in such a case.
#'
#'   Most Windows users do not have read the boring notes below after they have
#'   installed ImageMagick or GraphicsMagick. For the rest of Windows users:
#'
#'   \describe{
#'
#'   \item{\strong{ImageMagick users}}{Please install ImageMagick from
#'   \url{http://www.imagemagick.org}, and make sure the the path to
#'   \command{convert.exe} is in your \code{'PATH'} variable, in which case the
#'   command \command{convert} can be called without the full path.  Windows
#'   users are often very confused about the ImageMagick and \code{'PATH'}
#'   setting, so I'll try to search for ImageMagick in the Registry Hive by
#'   \code{readRegistry('SOFTWARE\ImageMagick\Current')$BinPath}, thus you might
#'   not really need to modify your \code{'PATH'} variable.
#'
#'   For Windows users who have installed LyX, I will also try to find the
#'   \command{convert} utility in the LyX installation directory, so they do not
#'   really have to install ImageMagick if LyX exists in their system (of
#'   course, the LyX should be installed with ImageMagick).
#'
#'   Once the \command{convert} utility is found, the animation option
#'   \code{'convert'} will be set (\code{ani.options(convert =
#'   'path/to/convert.exe')}); this can save time for searching for
#'   \command{convert} in the operating system next time.  }
#'
#'   \item{\strong{GraphicsMagick users}}{During the installation of
#'   GraphicsMagick, you will be asked if you allow it to change the PATH
#'   variable; please do check the option.  }
#'
#'   }
#'
#'   A reported problem is \code{cmd.fun = shell} might not work under Windows
#'   but \code{cmd.fun = system} works fine. Try this option in case of
#'   failures.
#' @author Yihui Xie
#' @family utilities
#' @references ImageMagick: \url{http://www.imagemagick.org/script/convert.php}
#'   GraphicsMagick: \url{http://www.graphicsmagick.org}
#' @export
#' @example inst/examples/im.convert-ex.R
im.convert = function(
  files, output = 'animation.gif', convert = c('convert', 'gm convert'),
  cmd.fun = if (.Platform$OS.type == 'windows') shell else system, extra.opts = '', clean = FALSE
) {
  interval = head(ani.options('interval'), length(files))
  convert = match.arg(convert)
  if (convert == 'convert') {
    version = ''
    if (!is.null(ani.options('convert'))) {
      try(version <- cmd.fun(sprintf('%s --version', shQuote(ani.options('convert'))), intern = TRUE))
    }
    if (!length(grep('ImageMagick', version))) {
      try(version <- cmd.fun(sprintf('%s --version', convert), intern = TRUE))
    } else convert = ani.options('convert')
    if (!length(grep('ImageMagick', version))) {
      message('I cannot find ImageMagick with convert = ', shQuote(convert))
      if (.Platform$OS.type != 'windows' || is.null(convert <- find_magic())) {
        warning('Please install ImageMagick first or put its bin path into the system PATH variable')
        return()
      }
    }
  } else {
    ## GraphicsMagick
    version = ''
    if (!is.null(ani.options('convert')))
      try(version <- cmd.fun(sprintf('%s -version', shQuote(ani.options('convert'))), intern = TRUE))
    if (!length(grep('GraphicsMagick', version))) {
      try(version <- cmd.fun(sprintf('%s -version', convert), intern = TRUE))
      if (!length(grep('GraphicsMagick', version))) {
        warning('I cannot find GraphicsMagick with convert = ', shQuote(convert),
                '; you may have to put the path of GraphicsMagick in the PATH variable.')
        return()
      }
    } else convert = ani.options('convert')
  }

  loop = ifelse(isTRUE(ani.options('loop')), 0, ani.options('loop'))
  convert = sprintf(
    '%s -loop %s %s %s %s', shQuote(convert), loop,
    extra.opts, paste(
      '-delay', interval * 100,
      if (length(interval) == 1) paste(files, collapse = ' ') else files,
      collapse = ' '),
    shQuote(output)
  )
  # there might be an error "the input line is too long", and we need to quote
  # the command; see http://stackoverflow.com/q/682799/559676
  if (.Platform$OS.type == 'windows') convert = sprintf('"%s"', convert)
  message('Executing: ', strwrap(convert, exdent = 4, prefix = '\n'))
  if (interactive()) flush.console()
  cmd = cmd.fun(convert)
  ## if fails on Windows using shell(), try system() instead of shell()
  if (cmd != 0 && .Platform$OS.type == 'windows' && identical(cmd.fun, shell)) {
    cmd = system(convert)
  }
  if (cmd == 0) {
    message('Output at: ', output)
    if (clean)
      unlink(files)
    auto_browse(output)
  } else message('an error occurred in the conversion... see Notes in ?im.convert')
  invisible(convert)
}
#' @details The function \code{gm.convert} is a wrapper for the command
#'   \command{gm convert} of GraphicsMagick.
#' @rdname convert
#' @param ... arguments to be passed to \code{\link{im.convert}}
#' @export
gm.convert = function(..., convert = 'gm convert') {
  im.convert(..., convert = convert)
}
