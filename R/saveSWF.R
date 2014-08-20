#' Convert images to Flash animations
#'
#' This function opens a graphical device first to generate a sequence of images
#' based on \code{expr}, then makes use of the commands in SWFTools
#' (\command{png2swf}, \command{jpeg2swf}, \command{pdf2swf}) to convert these
#' images to a single Flash animation.
#' @param expr an expression to generate animations; use either the animation
#'   functions (e.g. \code{brownian.motion()}) in this package or a custom
#'   expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}).
#' @param img.name the base file name of the sequence of images (without any
#'   format or extension)
#' @param swf.name file name of the Flash file
#' @param swftools the path of SWFTools, e.g. \file{C:/swftools}. This argument
#'   is to make sure that \code{png2swf}, \code{jpeg2swf} and \code{pdf2swf} can
#'   be executed correctly. If it is \code{NULL}, it should be guaranteed that
#'   these commands can be executed without the path; anyway, this function will
#'   try to find SWFTools from Windows registry even if it is not in the PATH
#'   variable.
#' @param ... other arguments passed to \code{\link{ani.options}}, e.g.
#'   \code{ani.height} and \code{ani.width}, ...
#' @return An integer indicating failure (-1) or success (0) of the converting
#'   (refer to \code{\link{system}}).
#' @note Please download and install the SWFTools before using this function:
#'   \url{http://www.swftools.org}
#'
#'   We can also set the path to SWF Tools by \code{ani.options(swftools =
#'   'path/to/swftools')}.
#'
#'   \code{ani.options('ani.type')} can only be one of \code{png}, \code{pdf}
#'   and \code{jpeg}.
#'
#'   Also note that PDF graphics can be compressed using qpdf or Pdftk (if
#'   either one is installed and \code{ani.options('qpdf')} or
#'   \code{ani.options('pdftk')} has been set); see \code{\link{qpdf}} or
#'   \code{\link{pdftk}}.
#' @author Yihui Xie
#' @family utilities
#' @export
#' @example inst/examples/saveSWF-ex.R
saveSWF = function(expr, swf.name = 'animation.swf', img.name = 'Rplot', swftools = NULL, ...) {
  oopt = ani.options(...)
  on.exit(ani.options(oopt))
  owd = setwd(tempdir())
  on.exit(setwd(owd), add = TRUE)

  ani.dev = ani.options('ani.dev')
  file.ext = ani.options('ani.type')
  if (!(file.ext %in% c('pdf', 'png', 'jpeg'))) {
    warning("ani.options('ani.type') has to be one of 'pdf', 'png' and 'jpeg'")
    return()
  }
  interval = ani.options('interval')
  if (is.character(ani.dev)) ani.dev = get(ani.dev)
  digits = ceiling(log10(ani.options('nmax'))) + 2
  num = ifelse(ani.options('ani.type') == 'pdf', '', paste('%0', digits, 'd', sep = ''))
  img.fmt = paste(img.name, num, '.', file.ext, sep = '')
  img.fmt = file.path(tempdir(), img.fmt)
  ## remove existing image files first
  unlink(paste(img.name, '*.', file.ext, sep = ''))
  ani.options(img.fmt = img.fmt)
  if ((use.dev <- ani.options('use.dev')))
    ani.dev(img.fmt, width = ani.options('ani.width'),
            height = ani.options('ani.height'))
  in_dir(owd, expr)
  if (use.dev) dev.off()

  ## compress PDF files
  if (file.ext == 'pdf') compress_pdf(img.name)

  if (!is.null(ani.options('swftools'))) {
    swftools = ani.options('swftools')
  } else {
    if (.Platform$OS.type == 'windows' && !inherits(try({
      swftools = utils::readRegistry('SOFTWARE\\quiss.org\\SWFTools\\InstallPath')[[1]]
    }, silent = TRUE), 'try-error')) {
      ani.options(swftools = swftools)
    }
  }
  tool = paste(ifelse(is.null(swftools), '', paste(swftools, .Platform$file.sep, sep = '')),
               paste(file.ext, '2swf', sep = ''), sep = '')
  if (.Platform$OS.type == 'windows') {
    tool = paste(tool, '.exe', sep = '')
    if (file.exists(tool)) tool = normalizePath(tool) else {
      warning('the executable', tool, 'does not exist!')
      return()
    }
  }
  tool = shQuote(tool)
  version = try(system(paste(tool, '--version'), intern = TRUE))
  if (inherits(version, 'try-error') || !length(grep('swftools', version))) {
    warning('The command ', tool, ' is not available. Please install: http://www.swftools.org')
    return()
  }
  wildcard = paste(
    shQuote(list.files('.', paste(img.name, '.*\\.', file.ext, sep = ''), full.names = TRUE)),
    collapse = ' '
  )
  convert = paste(tool, wildcard, '-o', shQuote(basename(swf.name)))
  cmd = -1
  if (file.ext == 'png' || file.ext == 'jpeg') {
    convert = paste(convert, '-r', 1/interval)
    message('Executing: ', convert)
    cmd = system(convert)
  } else {
    convert = paste(convert, ' -s framerate=', 1/interval, sep = '')
    message('Executing: ', convert)
    cmd = system(convert)
  }
  if (cmd == 0) {
    setwd(owd)
    file.copy(file.path(tempdir(), basename(swf.name)), swf.name, overwrite = TRUE)
    message('\n\nFlash has been created at: ',
            output.path <- normalizePath(swf.name))
    auto_browse(output.path)
  }
  invisible(cmd)
}
