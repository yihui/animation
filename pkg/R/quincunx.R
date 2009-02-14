`quincunx` <-
function(balls = 200, layers = 15, pch.layers = 2, 
    pch.balls = 19, col.balls = sample(colors(), balls, TRUE), 
    cex.balls = 2) {
    op = par(mar = c(1, 0.1, 0.1, 0.1), mfrow = c(2, 1))
    nmax = max(balls + layers - 2, ani.options("nmax"))
    interval = ani.options("interval")
    layerx = layery = NULL
    for (i in 1:layers) {
        layerx = c(layerx, seq(0.5 * (i + 1), layers - 0.5 * 
            (i - 1), 1))
        layery = c(layery, rep(i, layers - i + 1))
    }
    ballx = bally = directx = matrix(nrow = balls, ncol = nmax)
    finalx = numeric(balls)
    for (i in 1:balls) {
        directx[i, i] = 0
        ballx[i, i] = (1 + layers)/2
        if (layers > 2) {
            tmp = rbinom(layers - 2, 1, 0.5) * 2 - 1
            directx[i, i + 1:(layers - 2)] = tmp
            ballx[i, i + 1:(layers - 2)] = cumsum(tmp) * 0.5 + 
                (1 + layers)/2
        }
        bally[i, (i - 1) + 1:(layers - 1)] = (layers - 1):1
        finalx[i] = ballx[i, i + layers - 2]
    }
    rgx = c(1, layers)
    rgy = c(0, max(table(finalx)))
    for (i in 1:ani.options("nmax")) {
        plot(1:layers, type = "n", ann = FALSE, axes = FALSE)
        points(layerx, layery, pch = pch.layers)
        points(ballx[, i], bally[, i], pch = pch.balls, col = col.balls, 
            cex = cex.balls)
        par(bty = "u")
        if (i < layers - 1) 
            plot.new()
        else hist(finalx[1:(i - layers + 2)], breaks = 1:layers, 
            xlim = rgx, ylim = rgy, main = "", xlab = "", ylab = "", 
            ann = FALSE, axes = FALSE)
        Sys.sleep(interval)
    }
    par(op)
    return(invisible(c(table(finalx))))
}

