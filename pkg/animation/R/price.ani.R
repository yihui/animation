price.ani <-
function(price, time, time.begin = min(time), 
    span = 15 * 60, ..., xlab = "price", ylab = "frequency", 
    xlim, ylim, main) {
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
        time2 = time1 + span
        sub.price = price[time >= time1 & time <= time2]
        if (length(sub.price) > 0) {
            tab.price = table(sub.price)
            if (miss.main) 
                main = paste(time1, time2, sep = " - ")
            plot(as.numeric(names(tab.price)), tab.price, type = "h", 
                ..., xlab = xlab, ylab = ylab, xlim = xlim, ylim = ylim, 
                main = main, panel.first = grid())
        }
        else {
            message("no prices between ", time1, " and ", time2)
        }
        time1 = time2
        Sys.sleep(ani.options("interval"))
    }
}

