binom.norm.approx <-
function(n = seq(1, 100, 2), p = seq(0, 
    1, 0.02), nrep = 100, levels = c(0, 0.01, 0.05, 0.1, 0.2, 
    1), ...) {
    pval.mat = matrix(nrow = length(n), ncol = length(p))
    for (i in 1:nrow(pval.mat)) {
        for (j in 1:ncol(pval.mat)) {
            pval.mat[i, j] = ks.test(replicate(nrep, mean(rbinom(n[i], 
                size = 1, prob = p[j]))), "pnorm", mean = p[j], 
                sd = sqrt(p[j] * (1 - p[j])/n[i]))$p.value
        }
    }
    dimnames(pval.mat) = list(n, p)
    filled.contour(x = n, y = p, z = pval.mat, levels = levels, 
        ...)
    list(n = n, p = p, p.value = pval.mat)
}

