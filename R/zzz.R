.onLoad = function(lib, pkg) {
  options(demo.ask = FALSE, example.ask = FALSE)
  .ani.env$.ani.opts = list(
    interval = 1, nmax = 50, ani.width = 480, ani.height = 480,
    imgdir = 'images', ani.type = 'png', ani.dev = 'png',
    title = 'Animations Using the R Language',
    description = paste('Animations generated in', R.version.string,
                        'using the package animation'),
    verbose = TRUE, loop = TRUE, autobrowse = interactive(),
    autoplay = TRUE, use.dev = TRUE
  )
  
  # if on a non-windows system, try to determine if ffmpeg or avconv installed
  # and set default to appropirate command
  # Windows systems will leave it defaulting to NULL
  if (.Platform$OS.type != "windows")
  {
    # check if ffmpeg installed
    if (Sys.which('ffmpeg')==''){
      # can't find ffmpeg, so try avconv
      if(Sys.which('avconv')!=''){
        ani.options(ffmpeg = "avconv")
     } else {
       ani.options(ffmpeg= "ffmpeg")
     }
  } # TODO: if it is windows, should we set it to ani.options(ffmpeg = 'D:/Installer/ffmpeg/bin/ffmpeg.exe') by default?
}

  
}
