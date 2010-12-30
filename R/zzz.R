.onLoad <- function(lib, pkg) {
    options(demo.ask = FALSE, example.ask = FALSE)
    .ani.env$.ani.opts =
        list(interval = 1, nmax = 50, ani.width = 480, ani.height = 480,
             outdir = tempdir(), imgdir = "images", htmlfile = "index.html",
             withprompt = "ANI> ", ani.type = "png", ani.dev = "png",
             title = "Animations Using the R Language",
             description = paste("Animations generated in", R.version.string,
             'using the package animation'),
             verbose = TRUE, loop = TRUE, autobrowse = interactive(),
             autoplay = TRUE, use.dev = TRUE)
}
