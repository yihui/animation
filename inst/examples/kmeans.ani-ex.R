## set larger 'interval' if the speed is too fast
oopt = ani.options(interval = 2)
par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
kmeans.ani()

## the kmeans() example; very fast to converge!
x = rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
          matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
colnames(x) = c('x', 'y')
kmeans.ani(x, centers = 2)

## what if we cluster them into 3 groups?
kmeans.ani(x, centers = 3)

## create an HTML animation page
saveHTML({
  ani.options(interval = 2)
  par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
  
  cent = 1.5 * c(1, 1, -1, -1, 1, -1, 1, -1); x = NULL
  for (i in 1:8) x = c(x, rnorm(25, mean = cent[i]))
  x = matrix(x, ncol = 2)
  colnames(x) = c('X1', 'X2')
  
  kmeans.ani(x, centers = 4, pch = 1:4, col = 1:4)
  
}, img.name='kmeans.ani',htmlfile='kmeans.ani.html',
         ani.height = 480, ani.width = 480,
         title = 'Demonstration of the K-means Cluster Algorithm',
         description = 'Move! Average! Cluster! Move! Average! Cluster! ...')

ani.options(oopt)
