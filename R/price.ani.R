#' Demonstrate stock prices in animations
#'
#' This function can display the frequencies of stock prices in a certain time
#' span with the span changing.
#'
#' @param price stock prices
#' @param time time corresponding to prices
#' @param time.begin the time for the animation to begin (default to be the
#'   minimum \code{time})
#' @param span time span (unit in seconds; default to be 15 minutes)
#' @param \dots other arguments passed to \code{\link{plot}}
#' @param xlab,ylab,xlim,ylim,main they are passed to \code{\link{plot}} with
#'   reasonable default values
#' @return invisible \code{NULL}
#' @author Yihui Xie
#' @export
#' @example inst/examples/price.ani-ex.R
price.ani = function(
  price, time, time.begin = min(time), span = 15 * 60, ..., xlab = 'price',
  ylab = 'frequency', xlim, ylim, main
) {
  time1 = time.begin
  miss.main = missing(main)
  tab.max = 0
  while (time1 < max(time)) {
    time2 = time1 + span
    sub.price = price[time >= time1 & time <= time2]
    if (length(sub.price) > 0) {
      tab.max = max(tab.max, max(table(sub.price)))
    }
    time1 = time2
  }
  if (missing(xlim))
    xlim = range(price)
  if (missing(ylim))
    ylim = c(0, tab.max)
  time1 = time.begin
  while (time1 < max(time)) {
    dev.hold()
    time2 = time1 + span
    sub.price = price[time >= time1 & time <= time2]
    if (length(sub.price) > 0) {
      tab.price = table(sub.price)
      if (miss.main)
        main = paste(time1, time2, sep = ' - ')
      plot(as.numeric(names(tab.price)), as.numeric(tab.price), type = 'h',
           ..., xlab = xlab, ylab = ylab, xlim = xlim, ylim = ylim,
           main = main, panel.first = grid())
    } else if (interactive()) {
      message('no prices between ', time1, ' and ', time2)
      flush.console()
    }
    time1 = time2
    ani.pause()
  }
}

