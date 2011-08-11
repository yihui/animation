oopt = ani.options(nmax = ifelse(interactive(), 30, 2))

## default example
xx = bisection.method()
xx$root  # solution

## a cubic curve
f = function(x) x^3 - 7 * x - 10
xx = bisection.method(f, c(-3, 5))

## interaction: use your mouse to select the two end-points
if (interactive())
    bisection.method(f, c(-3, 5), interact = TRUE)

## HTML animation pages
saveHTML({
    par(mar = c(4, 4, 1, 2))
    bisection.method(main = "")
}, img.name='bisection.method', htmlfile = 'bisection.method.html',
         ani.height = 400, ani.width = 600, interval = 1,
         title = "The Bisection Method for Root-finding on an Interval",
         description = c("The bisection method is a root-finding algorithm",
         "which works by repeatedly dividing an interval in half and then",
         "selecting the subinterval in which a root exists."))

ani.options(oopt)
