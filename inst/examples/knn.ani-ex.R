## a binary classification problem
oopt = ani.options(interval = 2, nmax = ifelse(interactive(), 10, 2))
x = matrix(c(rnorm(80, mean = -1), rnorm(80, mean = 1)),
ncol = 2, byrow = TRUE)
y = matrix(rnorm(20, mean = 0, sd = 1.2), ncol = 2)
knn.ani(train = x, test = y, cl = rep(c("first class", "second class"),
                             each = 40), k = 30)

x = matrix(c(rnorm(30, mean = -2), rnorm(30, mean = 2),
rnorm(30, mean = 0)), ncol = 2, byrow = TRUE)
y = matrix(rnorm(20, sd = 2), ncol = 2)
knn.ani(train = x, test = y, cl = rep(c("first", "second", "third"),
                             each = 15), k = 25, cl.pch = c(2, 3, 19), dist.lty = 3)

## an interactive demo: choose the test set by mouse-clicking
if (interactive()) {
    ani.options(nmax = 5)
    knn.ani(interact = TRUE)
}

## HTML page
saveHTML({
    ani.options(nmax = ifelse(interactive(), 10, 2),interval = 2)
    par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
    knn.ani(cl.pch = c(3, 19), asp = 1)
}, img.name='knn_ani',htmlfile='knn.ani.html',ani.height = 500, ani.width = 600,
         title = "Demonstration for kNN Classification",
         description = c("For each row of the test set", 'the k nearest (in Euclidean',
         'distance) training set vectors are found, and the classification is',
         "decided by majority vote, with ties broken at random."))

ani.options(oopt)
