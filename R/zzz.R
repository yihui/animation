.onLoad <- function(lib, pkg) {
    options(demo.ask = FALSE, example.ask = FALSE)
}
.onUnload <- function(lib) {
    options(ani = NULL)
}
