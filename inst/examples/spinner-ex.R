t <- seq(0, 2*pi, length.out = 260L)[-1L]
x <- cos(3*t); y <- sin(2*t)
opacity <- format(as.hexmode(0:255), width = 2)
pinks <- paste0("#FFC0CB", opacity)
fplot <- function(i){
  par(mar = c(0,0,0,0))
  plot(x, y, type = "n", axes = FALSE, xlab = NA, ylab = NA)
  j <- (c(i, i+1, i+2) %% 259L) + 1L
  ii <- i+3
  points(x[-j][(ii:(255+ii))%%259+1], y[-j][(ii:(255+ii))%%259+1],
         pch = 19, cex = 1.5,
         col = pinks)
  points(x[j], y[j], col = "#FF000080", pch = 19, cex = c(1.5, 2, 2.5))
  text(0, 0, "Calculating...", cex = 4, font = 4)
}

saveGIF(
  {
    for(i in 1:259) fplot(i)
  },
  movie.name = "spinner.gif",
  interval = 0.025, ani.width = 500, ani.height = 500,
  ani.dev = function(...) png(bg = "transparent", ...),
  extra.opts = "-coalesce -dispose previous"
)

