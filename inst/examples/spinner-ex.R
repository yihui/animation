library(scales) # for the alpha() function

t <- seq(0, 2*pi, length.out=201L)[-1L]
x <- cos(3*t); y <- sin(2*t)
opacity <- seq(0, 1, length.out=length(t)-3L)
fplot <- function(i){
  par(mar=c(0,0,0,0))
  plot(x, y, type="n", axes=FALSE, xlab=NA, ylab=NA)
  j <- (c(i, i+1, i+2) %% 200L) + 1L
  ii <- i+3
  points(x[-j][(ii:(196+ii))%%200+1], y[-j][(ii:(196+ii))%%200+1],
         pch = 19, cex = 1.5,
         col = alpha("pink", opacity))
  points(x[j], y[j], col=alpha("red", 0.5), pch=19, cex=c(1.5, 2, 2.5))
  text(0, 0, "Calculating...", cex=4, font = 4)
}

saveGIF(
  {
    for(i in 1:200) fplot(i)
  },
  movie.name = "spinner.gif",
  interval=0.025, ani.width=500, ani.height=500,
  ani.dev = function(...) png(bg="transparent", ...),
  extra.opts = "-coalesce -dispose previous"
)

