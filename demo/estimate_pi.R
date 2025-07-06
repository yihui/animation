library(animation)
estimate_pi = function(output = "estimate_pi.gif") {
  par(pty = "s")
  nmax = ani.options("nmax")
  
  points = data.frame(
    x = numeric(0), 
    y = numeric(0)
  )
  inside = logical(0)
  pi_estimates = numeric(0)
  
  saveGIF({
    for (n in 2^(0:22)) {
      new_points = data.frame(
        x = runif(n, min = -1, max = 1), 
        y = runif(n, min = -1, max = 1)
      )
      points = rbind(points, new_points)
      
      inside = (points$x^2 + points$y^2) < 1
      pi_estimate = mean(inside) * 4
      pi_estimates = c(pi_estimates, pi_estimate)
      
      theta = seq(0, 2 * pi, length.out = 100)
      plot(
        x = cos(theta), y = sin(theta), 
        axes = FALSE, col = "black", 
        lwd = 2, type = "l", bty = "n",
        xlab = "", ylab = "", main = ""
      )
      
      rect(
        xleft = -1, ybottom = -1, 
        xright = 1, ytop = 1,
        border = "black", lwd = 2
      )
      
      mtext(paste(
        "n = ", nrow(points)), side = 3, 
        line = 1, at = -0.9, adj = 0, cex = 2
      )
      mtext(paste(
        "π ≈", round(pi_estimate, 6)), side = 3, 
        line = 1, at = 0.2, adj = 0, cex = 2
      )
      
      points(
        points$x[inside], points$y[inside], 
        col = "green", pch = 20, cex = 0.5
      )
      points(
        points$x[!inside], points$y[!inside], 
        col = "red", pch = 20, cex = 0.5
      )
      
      dev.flush()
    }
  },
  
  movie.name = output,
  interval = 0.5
  )
  
  result = list(
    final_pi_estimate = tail(pi_estimates, 1),
    total_points = nrow(points)
  )
  cat("final_points: ", result$total_points, "\n")
  cat("pi_estimate: ", result$final_pi_estimate, "\n")
}
