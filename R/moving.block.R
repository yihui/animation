moving.block <- function(dat = runif(100), block, 
    FUN = function(..., dat = dat, i = i, block = block) {
        plot(...)
    }, ...) {
    nmax = ani.options("nmax")
    n = ifelse(is.null(dim(dat)), length(dat), nrow(dat))
    if (missing(block)) 
        block = n - ani.options("nmax") + 1
    if (block < 1) 
        stop("block length less than 1; please set smaller ani.options('nmax') or larger 'block'")
    if (block != n - nmax + 1) {
        warning(sprintf("block length is too %s; try to adjust 'block' or ani.options('nmax')", 
            ifelse(block > n - nmax + 1, "long", "short")))
    }    
    for (i in seq_len(nmax) - 1) {
        FUN(subset(dat, seq_len(n) %in% (i + 1:block)), dat = dat, 
            i = i, block = block, ...)
        Sys.sleep(ani.options("interval"))
    }
}



