oopt = ani.options(interval = 2, nmax = ifelse(interactive(), 50, 2))

## observe the location of the red line (closer to the population mean)
res = sample.ratio()

## absolute difference with the true mean
matplot(abs(cbind(res$ybar.ratio, res$ybar.simple) -
            res$Ybar), type = "l")
legend("topleft", c("Ratio Estimation", "Sample Average"),
       lty = 1:2, col = 1:2)

## if the ratio does not actually exist:
sample.ratio(X = rnorm(50), Y = rnorm(50))
## ratio estimation may not be better than the simple average


## HTML animation page
saveHTML({
    par(mar = c(4, 4, 1, 0.5), mgp = c(2, 1, 0))
    ani.options(interval = 2, nmax = ifelse(interactive(), 50, 2))
    sample.ratio()
}, img.name='sample.ratio',htmlfile='sample.ratio.html',
         ani.height = 400, ani.width = 500,
         title = "Demonstration of the Ratio Estimation",
         description = c("Estimate the mean of Y, making use of the ratio",
         "Y/X which will generally improve the estimation."))

ani.options(oopt)
