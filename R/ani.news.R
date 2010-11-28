

##' Read news of package `animation'
##' Read news and changes in the package `animation'.
##' 
##' This function just makes use of \code{\link[base]{file.show}} to display a
##' file \file{NEWS} in this package.
##' 
##' @param \dots arguments passed to \code{\link[base]{file.show}}.
##' @return None (invisible `\code{NULL}').
##' @author Yihui Xie
##' @seealso \code{\link[base]{file.show}}
##' @keywords IO
##' @examples
##' 
##' ani.news() 
##' 
`ani.news` <-
function(...){
    newsfile <- file.path(system.file(package = "animation"), 
        "NEWS")
    file.show(newsfile,...)
}

