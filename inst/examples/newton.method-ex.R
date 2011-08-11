oopt = ani.options(interval = 1, nmax = ifelse(interactive(), 50, 2))
par(pch = 20)

## default example
xx = newton.method()
xx$root  # solution

## take a long long journey
newton.method(function(x) 5 * x^3 - 7 * x^2 - 40 * x + 100, 7.15, c(-6.2, 7.1))

## another function
ani.options(interval = 0.5)
xx = newton.method(function(x) exp(-x) * x, rg = c(0, 10), init = 2)

## does not converge!
xx = newton.method(function(x) atan(x), rg = c(-5, 5), init = 1.5)
xx$root   # Inf

## interaction: use your mouse to select the starting point
if (interactive()) {
    ani.options(interval = 0.5, nmax = 50)
    xx = newton.method(function(x) atan(x), rg = c(-2,
                                            2), interact = TRUE)
}

## HTML animation pages
saveHTML({
    ani.options(nmax = ifelse(interactive(), 100, 2))
    par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0), pch = 19)
    newton.method(function(x) 5 * x^3 - 7 * x^2 - 40 *
                  x + 100, 7.15, c(-6.2, 7.1), main = "")
}, img.name='newton.method', htmlfile='newton.method.html',
         ani.height = 500, ani.width = 600,
         title = "Demonstration of the Newton-Raphson Method",
         description = "Go along with the tangent lines and iterate.")

ani.options(oopt)
