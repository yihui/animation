.onLoad = function(lib, pkg) {
  options(demo.ask = FALSE, example.ask = FALSE)
  .ani.env$.ani.opts = list(
    interval = 1, nmax = 50, ani.width = 480, ani.height = 480, ani.res = NA, # ani.bg = 'white',
    imgdir = 'images', ani.type = 'png', ani.dev = 'png', imgnfmt = '%d',
    title = 'Animations Using the R Language',
    description = paste('Animations generated in', R.version.string,
                        'using the package animation'),
    verbose = TRUE, loop = TRUE, autobrowse = interactive(),
    autoplay = TRUE, use.dev = TRUE
  )

  # if on a non-windows system, try to determine if ffmpeg or avconv installed
  # and set default to appropriate command
  # Windows systems will leave it defaulting to NULL
  if (.Platform$OS.type != 'windows') {
    ani.options(ffmpeg = if (Sys.which('ffmpeg') != '' || Sys.which('avconv') == '') 'ffmpeg' else 'avconv')
    # TODO: if it is windows, should we set it to ani.options(ffmpeg = 'D:/Installer/ffmpeg/bin/ffmpeg.exe') by default?
  }
}
