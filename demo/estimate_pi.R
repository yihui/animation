estimate_pi = function(n = 1000) {
  par(pty = "s", mar = c(0.5, 0.5, 2.5, 0.5))

  # estimate pi by calculating the proportion of points inside the unit circle
  x = runif(n, min = -1, max = 1)
  y = runif(n, min = -1, max = 1)
  inside = (x^2 + y^2) <= 1

  # draw the circle
  theta = seq(0, 2 * pi, length.out = 100)
  xt = cos(theta); yt = sin(theta)

  for (i in seq_len(n)) {
    i_in = head(inside, i)
    n_in = sum(i_in)
    plot(
      xt, yt, axes = FALSE, asp = 1,
      type = "l", bty = "n", xlab = "", ylab = "",
      main = substitute(
        paste(hat(pi), ' = ', frac(n, N) %*% 4, ' = ', pi_hat),
        list(n = n_in, N = i, pi_hat = sprintf('%6f', n_in / i * 4))
      )
    )
    rect(-1, -1, 1, 1)
    points(
      head(x, i), head(y, i), cex = 10 - (i/n)^.2 * 9.2,
      col = i_in + 2, pch = ifelse(i_in, 20, 4)
    )
    dev.flush()
    Sys.sleep(.05)
  }
}

estimate_pi()
