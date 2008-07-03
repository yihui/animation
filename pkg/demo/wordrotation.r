for (i in 1:360) {
    plot(1, ann = F, type = "n", axes = F)
    text(1, 1, "Animation", srt = i, col = rainbow(360)[i], cex = 7 * 
        i/360)
    Sys.sleep(0.01)
}