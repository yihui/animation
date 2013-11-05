library(animation)

n = 20
x = sort(rnorm(n))
y = rnorm(n)
## set up an empty frame, then add points one by one
par(bg = 'white')   # ensure the background color is white
plot(x, y, type = 'n')

ani.record(reset = TRUE)   # clear history before recording

for (i in 1:n) {
  points(x[i], y[i], pch = 19, cex = 2)
  ani.record()   # record the current frame
}

## now we can replay it, with an appropriate pause between frames
oopts = ani.options(interval = .5)
ani.replay()

## or export the animation to an HTML page
saveHTML(ani.replay(), img.name = 'record_plot')

## record plots and replay immediately
saveHTML({
  dev.control('enable')   # enable recording
  par(bg = 'white')   # ensure the background color is white
  plot(x, y, type = 'n')
  for (i in 1:n) {
    points(x[i], y[i], pch = 19, cex = 2)
    ani.record(reset=TRUE, replay.cur=TRUE)   # record the current frame
  }
})

ani.options(oopts)
