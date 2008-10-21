png("pollen.png", width = 500, height = 500)
par(mar = c(3, 0, 4, 0), cex.main = 2, family = "serif")
plot(1, type = "n", axes = FALSE, main = "Animations in Statistics")
mtext(paste("by Yihui Xie @", Sys.time(), "\n http://animation.yihui.name"), 
    1, line = -1, cex = 1.5)
points(apply(x[, 1:2], 2, function(xx) (xx - min(xx, 
    na.rm = TRUE))/(max(xx, na.rm = TRUE) - min(xx, na.rm = TRUE)) * 
    0.8 + 0.6), pch = 20, col = rgb(1, 0, 0, 0.1))
text(1, 1, "Letters \"EUREKA\"\n        in \nPOLLEN data", 
    cex = 4)
dev.off() 
