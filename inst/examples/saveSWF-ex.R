## from png to swf
saveSWF({
  par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
  knn.ani(test = matrix(rnorm(16), ncol = 2),
          cl.pch = c(16, 2))}, swf.name = 'kNN.swf', interval = 1.5,
        nmax=ifelse(interactive(), 40, 2))

## from pdf (vector plot) to swf; can set the option 'pdftk' to compress PDF
saveSWF({brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow')},
        swf.name = 'brownian.swf', interval = 0.2,
        nmax = 30, ani.dev = 'pdf', ani.type = 'pdf',
        ani.height = 6, ani.width=6)

