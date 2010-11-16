`knn.ani` <- function(train, test, cl, k = 10, interact = FALSE,
    tt.col = c("blue", "red"), cl.pch = seq_along(unique(cl)),
    dist.lty = 2, dist.col = "gray", knn.col = "green") {
    nmax = ani.options("nmax")
    interval = ani.options("interval")
    if (missing(train)) {
        train = matrix(c(rnorm(40, mean = -1), rnorm(40, mean = 1)),
            ncol = 2, byrow = TRUE)
        cl = rep(c("first class", "second class"), each = 20)
    }
    if (missing(test))
        test = matrix(rnorm(20, mean = 0, sd = 1.2), ncol = 2)
    train <- as.matrix(train)
    if (interact) {
        plot(train, main = "Choose test set points", pch = unclass(as.factor(cl)),
            col = tt.col[1])
        lct = locator(n = nmax, type = "p", pch = "?", col = tt.col[2])
        test = cbind(lct$x, lct$y)
    }
    if (is.null(dim(test)))
        dim(test) <- c(1, length(test))
    test <- as.matrix(test)
    if (any(is.na(train)) || any(is.na(test)) || any(is.na(cl)))
        stop("no missing values are allowed")
    if (ncol(test) != 2 | ncol(train) != 2)
        stop("both column numbers of 'train' and 'test' must be 2!")
    ntr <- nrow(train)
    if (length(cl) != ntr)
        stop("'train' and 'class' have different lengths")
    if (ntr < k) {
        warning(gettextf("k = %d exceeds number %d of patterns",
            k, ntr), domain = NA)
        k <- ntr
    }
    if (k < 1)
        stop(gettextf("k = %d must be at least 1", k), domain = NA)
    nte = nrow(test)
    clf = as.factor(cl)
    res = NULL
    pre.plot = function(j, pf = NULL, i.point = TRUE) {
        plot(rbind(train, test), type = "n", xlab = expression(italic(X)[1]),
            ylab = expression(italic(X)[2]), panel.first = pf)
        points(train, col = tt.col[1], pch = cl.pch[unclass(clf)])
        if (j < nte)
            points(test[(j + 1):nte, 1], test[(j + 1):nte, 2],
                col = tt.col[2], pch = "?")
        if (j > 1)
            points(test[1:(j - 1), 1], test[1:(j - 1), 2], col = tt.col[2],
                pch = cl.pch[unclass(res)], cex = 2)
        if (i.point)
            points(test[j, 1], test[j, 2], col = tt.col[2], pch = "?",
                cex = 2)
        legend("topleft", legend = levels(clf), pch = cl.pch[seq_along(levels(clf))],
            bty = "n", y.intersp = 1.3)
        legend("bottomleft", legend = c("training set", "test set"),
            fill = tt.col, bty = "n", y.intersp = 1.3, )
    }
    nmax = min(nmax, nrow(test))
    for (i in 1:nmax) {
        pre.plot(i)
        Sys.sleep(interval)
        idx = rank(apply(train, 1, function(x) sqrt(sum((x -
            test[i, ])^2))), ties.method = "random") %in% seq(k)
        vote = cl[idx]
        res = c(res, factor(names(which.max(table(vote))), levels = levels(clf),
            labels = levels(clf)))
        pre.plot(i, segments(train[, 1], train[, 2], test[i,
            1], test[i, 2], lty = dist.lty, col = dist.col))
        Sys.sleep(interval)
        bd = train[idx, 1:2]
        pre.plot(i, {
            segments(train[, 1], train[, 2], test[i, 1], test[i,
                2], lty = dist.lty, col = dist.col)
            if (k > 1) {
                polygon(bd[chull(bd), ], density = 10, col = knn.col)
            }
            else {
                points(bd[1], bd[2], col = knn.col, pch = cl.pch[unclass(clf)[idx]],
                  cex = 2, lwd = 2)
            }
        })
        Sys.sleep(interval)
        pre.plot(i, {
            segments(train[, 1], train[, 2], test[i, 1], test[i,
                2], lty = dist.lty, col = dist.col)
            if (k > 1) {
                polygon(bd[chull(bd), ], density = 10, col = knn.col)
            }
            else {
                points(bd[1], bd[2], col = knn.col, pch = cl.pch[unclass(clf)[idx]],
                  cex = 2, lwd = 2)
            }
            points(test[i, 1], test[i, 2], col = tt.col[2], pch = cl.pch[unclass(res)[i]],
                cex = 3, lwd = 2)
        }, FALSE)
        Sys.sleep(interval)
    }
    ani.options(nmax = 4 * nmax)
    invisible(levels(clf)[res])
}
