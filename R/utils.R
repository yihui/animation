# evaluate code in a specified directory
in_dir = function(wd, expr) {
  owd = setwd(wd); on.exit(setwd(owd))
  expr
}

# compress pdf
compress_pdf = function(img.name){
  compress = if (use.pdftk <- !is.null(ani.options('pdftk'))) pdftk else {
    if (use.qpdf  <- !is.null(ani.options('qpdf'))) qpdf
  }
  if (is.null(compress)) return()

  for (f in list.files(
    dirname(img.name), pattern = sprintf('^%s[0-9]*\\.pdf$', basename(img.name)),
    full.names = TRUE
  )) compress(f)
}

# auto browse
auto_browse = function(output){
  if(!ani.options('autobrowse')) return()
  if (.Platform$OS.type == 'windows') {
    try(shell.exec(output))
  } else if (Sys.info()['sysname'] == 'Darwin') {
    system(paste('open ', shQuote(output)))
  } else system(paste('xdg-open ', shQuote(output)))
}

# find ImageMagick/GraphicsMagick
find_magic = function() {
  # try to look for ImageMagick in the Windows Registry Hive, the Program Files
  # directory and the LyX installation
  if (!inherits(try({
    magick.path = utils::readRegistry('SOFTWARE\\ImageMagick\\Current')$BinPath
  }, silent = TRUE), 'try-error')) {
    if (nzchar(magick.path)) {
      convert = normalizePath(file.path(magick.path, 'convert.exe'))
      message('but I can find it from the Registry Hive: ', magick.path)
    }
  } else if (
    nzchar(prog <- Sys.getenv('ProgramFiles')) &&
      length(magick.dir <- list.files(prog, '^ImageMagick.*')) &&
      length(magick.path <- list.files(file.path(prog, magick.dir), pattern = '^convert\\.exe$',
                                       full.names = TRUE, recursive = TRUE))
  ) {
    convert = normalizePath(magick.path[1])
    message('but I can find it from the "Program Files" directory: ', magick.path)
  } else if (!inherits(try({
    magick.path = utils::readRegistry('LyX.Document\\Shell\\open\\command', 'HCR')
  }, silent = TRUE), 'try-error')) {
    convert = file.path(dirname(gsub('(^\"|\" \"%1\"$)', '', magick.path[[1]])), c('..', '../etc'),
                        'imagemagick', 'convert.exe')
    convert = convert[file.exists(convert)]
    if (length(convert)) {
      convert = normalizePath(convert)
      message('but I can find it from the LyX installation: ', dirname(convert))
    } else {
      warning('No way to find ImageMagick!')
      return()
    }
  } else {
    warning('ImageMagick not installed yet!')
    return()
  }
  ## write it into ani.options() to save future efforts
  ani.options(convert = convert)
  return(convert)
}
