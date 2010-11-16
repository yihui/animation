`least.squares` <-
function(x, y, n = 15, ani.type = c("slope", 
    "intercept"), a, b, a.range, b.range, ab.col = c("gray", 
    "black"), est.pch = 19, v.col = "red", v.lty = 2, rss.pch = 19, 
    rss.type = "o", mfrow = c(1, 2), ...) {
    interval = ani.options("interval")
    nmax = ani.options("nmax")
    if (missing(x)) 
        x = 1:n
    if (missing(y)) 
        y = x + rnorm(n)
    ani.type = match.arg(ani.type)
    fit = coef(lm(y ~ x))
    if (missing(a)) 
        a = fit[1]
    if (missing(b)) 
        b = fit[2]
    rss = rep(NA, nmax)
    par(mfrow = mfrow)
    if (ani.type == "slope") {
        if (missing(b.range)) 
            bseq = tan(seq(pi/10, 3.5 * pi/10, length = nmax))
        else bseq = seq(b.range[1], b.range[2], length = nmax)
        for (i in 1:nmax) {
            plot(x, y, ...)
            abline(fit, col = ab.col[1])
            abline(a, bseq[i], col = ab.col[2])
            points(x, bseq[i] * x + a, pch = est.pch)
            segments(x, bseq[i] * x + a, x, y, col = v.col, lty = v.lty)
            rss[i] = sum((y - bseq[i] * x - a)^2)
            plot(1:nmax, rss, xlab = paste("Slope =", round(bseq[i], 
                3)), ylab = "Residual Sum of Squares", pch = rss.pch, 
                type = rss.type)
            Sys.sleep(interval)
        }
        return(invisible(list(lmfit = fit, anifit = c(x = bseq[which.min(rss)]))))
    }
    else if (ani.type == "intercept") {
        if (missing(a.range)) 
            aseq = seq(-5, 5, length = nmax)
        else aseq = seq(a.range[1], a.range[2], length = nmax)
        for (i in 1:nmax) {
            plot(x, y, ...)
            abline(fit, col = ab.col[1])
            abline(aseq[i], b, col = ab.col[2])
            points(x, b * x + aseq[i], pch = est.pch)
            segments(x, b * x + aseq[i], x, y, col = v.col, lty = v.lty)
            rss[i] = sum((y - b * x - aseq[i])^2)
            plot(1:nmax, rss, xlab = paste("Intercept =", round(aseq[i], 
                3)), ylab = "Residual Sum of Squares", pch = rss.pch, 
                type = rss.type)
            Sys.sleep(interval)
        }
        return(invisible(list(lmfit = fit, anifit = c("(Intercept)" = aseq[which.min(rss)]))))
    }
    else warning("Incorrect animation type!")
}

