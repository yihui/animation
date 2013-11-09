# evaluate code in a specified directory
in_dir = function(wd, expr) {
  owd = setwd(wd); on.exit(setwd(owd))
  force(expr)
}

# compress pdf
comp_pdf = function(img.name){
  if (
    (use.pdftk <- !is.null(ani.options('pdftk'))) || (use.qpdf <- !is.null(ani.options('qpdf')))
  ) {
    for (f in list.files(path = dirname(img.name), pattern =
                           sprintf('^%s[0-9]*\\.pdf$', img.name), full.names = TRUE))
      if (use.qpdf) qpdf(f) else if (use.pdftk) pdftk(f)
  }
}

# auto browse 
auto_browse = function(output){
  if (ani.options('autobrowse')) {
    if (.Platform$OS.type == 'windows')
      try(shell.exec(output)) else if (Sys.info()['sysname'] == 'Darwin')
        try(system(paste('open ', shQuote(output))), TRUE) else
          try(system(paste('xdg-open ', shQuote(output))), TRUE)
    invisible(0)
  }
}
