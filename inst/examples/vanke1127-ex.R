tab.price = table(vanke1127$price)
plot(as.numeric(names(tab.price)), as.numeric(tab.price), type = 'h',
     xlab = 'price', ylab = 'frequency')

oopt = ani.options(interval = 0.5, loop = FALSE, title = 'Stock price of Vanke')

## a series of HTML animations with different time spans
saveHTML({
  price.ani(vanke1127$price, vanke1127$time, lwd = 2)
}, img.name = 'vanke_a', description = 'Prices changing along with time interval 15 min',
  htmlfile = "vanke1127_1.html")

saveHTML({
  price.ani(vanke1127$price, vanke1127$time, span = 30 * 60, lwd = 3)
}, img.name = 'vanke_b', description = 'Prices changing along with time interval 30 min',
  htmlfile = "vanke1127_2.html")

saveHTML({
  price.ani(vanke1127$price, vanke1127$time, span = 5 * 60, lwd = 2)
}, img.name = 'vanke_c', description = 'Prices changing along with time interval 5 min',
  htmlfile = "vanke1127_3.html")

## GIF animation
saveGIF(price.ani(vanke1127$price, vanke1127$time, lwd = 2),
        movie.name = 'price.gif', loop = 1)

ani.options(oopt)
