## A quick and dirty demo
des=c('This is a silly example.\n\n', 'You can describe it in more detail.', 'For example, bla bla...')
saveHTML({
  par(mar = c(4, 4, .5, .5))
  for (i in 1:20) {
    plot(runif(20), ylim = c(0, 1))
    ani.pause()
  }
}, img.name = 'unif_plot', imgdir = 'unif_dir', htmlfile = 'random.html',
         autobrowse = FALSE,
         title = 'Demo of 20 uniform random numbers',
         description = des)



## we can merge another animation into the former page as long as 'htmlfile' is the same; this time I don't want the animation to autoplay, and will use text labels for the buttons (instead of UTF-8 symbols)
des=c('When you write a long long long long description, R will try to wrap the',
      'words automatically.', 'Oh, really?!')
saveHTML({
  par(mar = c(4, 4, .5, .5))
  ani.options(interval = 0.5)
  for (i in 1:10) {
    plot(rnorm(50), ylim = c(-3, 3))
    ani.pause()
  }
}, img.name = 'norm_plot', single.opts = 'utf8: false',
         autoplay = FALSE, interval = 0.5,
         imgdir = 'norm_dir', htmlfile = 'random.html',
         ani.height = 400, ani.width = 600,
         title = 'Demo of 50 Normal random numbers',
         description = des)



## use the function brownian.motion() in this package; this page is created in 'index.html' under the current working directory
des=c('Random walk of 10 points on the 2D plane:', 'for each point (x, y),', 'x = x + rnorm(1) and y = y + rnorm(1).')
saveHTML({
  par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), tcl = -0.3,
      cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
  ani.options(interval = 0.05, nmax = ifelse(interactive(), 150, 2))
  brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow')
}, img.name = 'brownian_motion_a', htmlfile = 'index.html',
         description = des)



## remove the 'navigator' (progress bar)
saveHTML({
  par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0), tcl = -0.3,
      cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
  ani.options(interval = 0.05, nmax = ifelse(interactive(), 150, 2))
  brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow')
}, img.name = 'brownian_motion_b',
         htmlfile = 'index.html',
         navigator = FALSE,
         description = c('Random walk of 10 points on the 2D plane', '(without the navigation panel)'))


## use Rweb to create animations
if (interactive())
  browseURL(system.file('misc', 'Rweb', 'demo.html', package = 'animation'))
