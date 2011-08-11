## default example
oopt = ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))
xx = grad.desc()
xx$par  # solution
xx$persp(col = "lightblue", phi = 30)   # perspective plot

## define more complex functions; a little time-consuming
f1 = function(x, y) x^2 + 3 * sin(y)
xx = grad.desc(f1, pi * c(-2, -2, 2, 2), c(-2 * pi, 2))
xx$persp(col = "lightblue", theta = 30, phi = 30)

## need to provide the gradient when deriv() cannot handle the function
grad.desc(FUN = function(x1, x2) {
    x0 = cos(x2)
    x1^2 + x0
}, gr = function(x1, x2) {
    c(2 * x1, -sin(x2))
}, rg = c(-3, -1, 3, 5), init = c(-3, 0.5),
          main = expression(x[1]^2+cos(x[2])))

## or a even more complicated function
ani.options(interval = 0, nmax = ifelse(interactive(), 200, 2))
f2 = function(x, y) sin(1/2 * x^2 - 1/4 * y^2 + 3) *
    cos(2 * x + 1 - exp(y))
xx = grad.desc(f2, c(-2, -2, 2, 2), c(-1, 0.5),
gamma = 0.1, tol = 1e-04)

## click your mouse to select a start point
if (interactive()) {
    xx = grad.desc(f2, c(-2, -2, 2, 2), interact = TRUE,
    tol = 1e-04)
    xx$persp(col = "lightblue", theta = 30, phi = 30)
}

## HTML animation pages
saveHTML({
    ani.options(interval = 0.3)
    grad.desc()
}, img.name='grad.desc',htmlfile='grad.desc.html',
         ani.height = 500, ani.width = 500,
         title = "Demonstration of the Gradient Descent Algorithm",
         description = "The arrows will take you to the optimum step by step.")

ani.options(oopt)
