oopts = if (.Platform$OS.type == 'windows'){
   ani.options(ffmpeg = 'D:/Installer/ffmpeg/bin/ffmpeg.exe')
}
## usually Linux users do not need to worry about the ffmpeg path 
## as long as FFmpeg or avconv has been installed

saveVideo({
  par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), tcl = -0.3,
      cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
  ani.options(interval = 0.05, nmax = 300)
  brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow')
}, video.name = 'BM.mp4', other.opts='-pix_fmt yuv420p -b 300k')
# higher bitrate, better quality

ani.options(oopts)
