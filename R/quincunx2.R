#' @rdname quincunx
#' @export

quincunx2 = function(
  balls = 200, layers = 15, pch.layers = 2, pch.balls = 19,
  col.balls = sample(colors(), balls, TRUE), cex.balls = 2
) {
  op = par(mar = c(1, 0.1, 0.1, 0.1), mfcol = c(4, 1)); on.exit(par(op))
  if (ani.options('nmax') != (balls + layers - 2))
    warning("It's strongly recommended that ani.options(nmax = balls + layers -2)")
  nmax = max(balls + layers - 2, ani.options("nmax"))
  layerx = layery = newlayerx = newlayery = NULL
  flagi = ifelse(layers%%2, 1, 0)
  for (i in 1:layers) {
    if (flagi) {
      newi = ifelse(i%%2, 1, 2)
    } else {
      newi = ifelse(i%%2, 2, 1)
    }
    layerx = c(layerx, seq(0.5 * (i + 1), layers - 0.5 * (i - 1), 1))
    layery = c(layery, rep(i, layers - i + 1))
    if (i > 1) {
      newlayerx = c(newlayerx, seq(0.5 * (newi + 1), layers - 0.5 * (newi - 1), 1))
      newlayery = c(newlayery, rep(i, layers - newi + 1))
    }
  }
  ballx = bally = matrix(nrow = balls, ncol = nmax)
  finalx = newfinalx = numeric(balls)
  for (i in 1:balls) {
    ballx[i, i] = (1 + layers)/2
    if (layers > 2) {
      tmp = rbinom(layers - 2, 1, 0.5) * 2 - 1
      ballx[i, i + 1:(layers - 2)] = cumsum(tmp) * 0.5 + (1 + layers)/2
    }
    bally[i, (i - 1) + 1:(layers - 1)] = (layers - 1):1
    finalx[i] = ballx[i, i + layers - 2]
  }
  rgx = c(1, layers)
  rgy = c(0, max(table(finalx)))
  newballx = ballx
  diag(newballx) = finalx
  for (i in 1:balls) {
    tmp = rbinom(layers - 2, 1, 0.5) * 2 - 1
    tmp = ifelse(newballx[i, i] + cumsum(tmp) < rgx[2], tmp, -1)
    tmp = ifelse(newballx[i, i] + cumsum(tmp) > rgx[1], tmp, +1)
    newballx[i, i + 1:(layers - 2)] = newballx[i, i] + cumsum(tmp) * 0.5
    newfinalx[i] = newballx[i, i + layers - 2]
  }
  for (i in 1:ani.options('nmax')) {
    dev.hold()
    plot(1:layers, type = 'n', ann = FALSE, axes = FALSE)
    points(layerx, layery, pch = pch.layers)
    points(ballx[, i], bally[, i], pch = pch.balls, col = col.balls, cex = cex.balls)
    par(bty = 'u')
    if (i < layers - 1) {
      plot.new()
    } else {
      hist(
        finalx[1:(i - layers + 2)], breaks = 1:layers, xlim = rgx, ylim = rgy,
        main = '', xlab = '', ylab = '', ann = FALSE, axes = FALSE
      )
    }
    if (i > (layers - 1)) {
      newi = i - layers + 1
      plot(1:layers, type = 'n', ann = FALSE, axes = FALSE)
      points(newlayerx, newlayery, pch = pch.layers)
      points(newballx[, newi], bally[, newi] + 1, pch = pch.balls, col = col.balls, cex = cex.balls)
      par(bty = 'u')
      if (newi < layers - 1) plot.new() else
        hist(newfinalx[1:(newi - layers + 2)], breaks = 1:layers, xlim = rgx, ylim = rgy, main = '',
             xlab = '', ylab = '', ann = FALSE, axes = FALSE)
    } else {
      plot(1:layers, type = 'n', ann = FALSE, axes = FALSE)
      points(newlayerx, newlayery, pch = pch.layers)
      plot(1:layers, type = 'n', ann = FALSE, axes = FALSE)
    }
    ani.pause()
  }
  invisible(list(top = c(table(finalx)), bottom = c(table(newfinalx))))
}
