.First.lib <- function(lib, pkg) {
    options(demo.ask = FALSE, example.ask = FALSE)
}
.Last.lib <- function(lib) {
    options(ani = NULL)
}
