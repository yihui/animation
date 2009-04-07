`cv.nfeaturesLDA` <- function(data = matrix(rnorm(600),
    60), cl = gl(3, 20), k = 5, cex.rg = c(0.5, 3), col.av = c("blue",
    "red")) {
    nmax = min(ncol(data), ani.options("nmax"))
    cl = as.factor(cl)
    dat = data.frame(data, cl)
    N = nrow(dat)
    n = sample(N)
    dat = dat[n, ]
    kf = cumsum(c(1, kfcv(k, N)))
    aovF = function(x, cl) {
        qr.obj <- qr(model.matrix(~cl))
        qty.obj <- qr.qty(qr.obj, x)
        tab <- table(factor(cl))
        dfb <- length(tab) - 1
        dfw <- sum(tab) - dfb - 1
        ms.between <- apply(qty.obj[2:(dfb + 1), , drop = FALSE]^2,
            2, sum)/dfb
        ms.within <- apply(qty.obj[-(1:(dfb + 1)), , drop = FALSE]^2,
            2, sum)/dfw
        Fstat <- ms.between/ms.within
    }
    acc = matrix(nrow = k, ncol = nmax)
    loc = cbind(rep(1:nmax, each = k), rep(1:k, nmax))
    op = par(mfrow = c(1, 2))
    interval = ani.options("interval")
    for (j in 1:nmax) {
        for (i in 2:(k + 1)) {
            idx = kf[i - 1]:(kf[i] - 1)
            trdat = dat[-idx, ]
            slct = order(aovF(as.matrix(trdat[, -ncol(trdat)]),
                trdat[, ncol(trdat)]), decreasing = TRUE) <=
                j
            fit = lda(as.formula(paste(colnames(dat)[ncol(dat)],
                "~", paste(colnames(dat)[-ncol(dat)][slct], collapse = "+"))),
                data = dat)
            pred = predict(fit, dat[idx, ], dimen = 2)
            acc[i - 1, j] = mean(dat[idx, ncol(dat)] == pred$class)
            plot(1, xlim = c(1, nmax), ylim = c(0, k), type = "n",
                xlab = "Number of Features", ylab = "Fold", yaxt = "n",
                panel.first = grid())
            axis(2, 1:k)
            axis(2, 0, expression(bar(p)))
            if ((j - 1) * k + i - 1 < nmax * k)
                text(matrix(loc[-(1:((j - 1) * k + i - 1)), ],
                  ncol = 2), "?")
            points(matrix(loc[1:((j - 1) * k + i - 1), ], ncol = 2),
                cex = c(acc) * diff(cex.rg) + min(cex.rg), col = col.av[1])
            points(1:nmax, rep(0, nmax), cex = apply(acc, 2,
                mean, na.rm = TRUE) * diff(cex.rg) + min(cex.rg),
                col = col.av[2])
            styl.pch = as.integer(dat[idx, ncol(dat)])
            styl.col = 2 - as.integer(dat[idx, ncol(dat)] ==
                pred$class)
            plot(pred$x, pch = styl.pch, col = styl.col)
            legend("topright", legend = c("correct", "wrong"),
                fill = 1:2, bty = "n", cex = 0.8)
            legend("bottomleft", legend = levels(dat[idx, ncol(dat)])[unique(styl.pch)],
                pch = unique(styl.pch), bty = "n", cex = 0.8)
            Sys.sleep(interval)
        }
    }
    ani.options(nmax = k * nmax)
    par(op)
    rownames(acc) = paste("Fold", 1:k, sep = "")
    colnames(acc) = 1:nmax
    nf = which.max(apply(acc, 2, mean))
    names(nf) = NULL
    invisible(list(accuracy = acc, optimum = nf))
}
