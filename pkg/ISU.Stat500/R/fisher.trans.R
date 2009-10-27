fisher.trans <-
function(x, y, rho = 0, conf.level = 0.95, 
    ...) {
    n = length(x)
    r = cor(x, y, ...)
    estimate = 0.5 * log((1 + r)/(1 - r))
    rho0 = 0.5 * log((1 + rho)/(1 - rho))
    conf.int = sapply(exp(2 * (estimate + c(-1, 1) * qnorm(1 - 
        (1 - conf.level)/2) * sqrt(1/(n - 3)))), function(s) (s - 
        1)/(s + 1))
    names(conf.int) = c("lwr", "upr")
    list(estimate = estimate, p.value = 2 * pnorm(sqrt(n - 3) * 
        (estimate - rho0), lower.tail = FALSE), conf.int = conf.int)
}

