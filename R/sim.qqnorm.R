sim.qqnorm <-
function(n = 20, ...) {
    for(i in 1:ani.options("nmax")) {
        qqnorm(rnorm(n),...)
        Sys.sleep(ani.options("interval"))
    }
}

