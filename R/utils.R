# evaluate code in a specified directory
in_dir = function(wd, expr) {
  owd = setwd(wd); on.exit(setwd(owd))
  force(expr)
}
