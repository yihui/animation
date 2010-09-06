.First.lib <- function(lib, pkg) {
    if (interactive()) {
      if (!require('R2WinBUGS')) {
          install.packages('R2WinBUGS')
          library(R2WinBUGS)
      }
      iBUGS()
    }
}
.Last.lib <- function(lib) {
    options(iBUGS = NULL)
}
