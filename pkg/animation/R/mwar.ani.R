`mwar.ani` <- function(x, k = 15, conf = 2, mat = matrix(1:2,
    2), widths = rep(1, ncol(mat)), heights = rep(1, nrow(mat)),
    lty.rect = 2, ...) {
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    if (missing(x))
        x = sin(seq(0, 2 * pi, length = 50)) + rnorm(50, sd = 0.2)
    n = length(x)
    if (k > n)
        stop("The window width k must be smaller than the length of x!")
    idx = matrix(1:k, nrow = k, ncol = n - k + 1) + matrix(rep(0:(n -
        k), each = k), nrow = k, ncol = n - k + 1)
    phi = se = numeric(ncol(idx))
    j = 1
    for (i in 1:ncol(idx)) {
        if (j > nmax)
            break
        fit = arima(x[idx[, i]], order = c(1, 0, 0))
        phi[i] = coef(fit)["ar1"]
        se[i] = sqrt(vcov(fit)[1, 1])
        j = j + 1
    }
    layout(mat, widths, heights)
    U = phi + conf * se
    L = phi - conf * se
    j = 1
    minx = maxx = NULL
    for (i in 1:ncol(idx)) {
        if (j > nmax)
            break
        plot(x, xlab = "", ylab = "Original data")
        minx = c(minx, min(x[idx[, i]]))
        maxx = c(maxx, max(x[idx[, i]]))
        rect(1:i, minx, k:(i + k - 1), maxx, lty = lty.rect,
            border = 1:i)
        plot(x, xlim = c(1, n), ylim = range(c(U, L), na.rm = TRUE),
            type = "n", ylab = "AR(1) coefficient", xlab = "")
        arrows(1:i + k/2 - 0.5, L[1:i], 1:i + k/2 - 0.5, U[1:i],
            angle = 90, code = 3, length = par("din")[1]/n *
                0.4, col = 1:i)
        points(1:i + k/2 - 0.5, phi[1:i], ...)
        Sys.sleep(interval)
        j = j + 1
    }
    ani.options(nmax = j - 1)
    invisible(list(phi = phi, lower = L, upper = U))
}
