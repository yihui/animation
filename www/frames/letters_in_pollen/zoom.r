library(rgl)
x = read.table("e:/pollen.dat")
uM = matrix(c(-0.370919227600098, -0.513357102870941, 
    -0.773877620697021, 0, -0.73050606250763, 0.675815105438232, 
    -0.0981751680374146, 0, 0.573396027088165, 0.528906404972076, 
    -0.625681936740875, 0, 0, 0, 0, 1), 4, 4)
open3d(userMatrix = uM, windowRect = c(10, 10, 510, 
    510))
plot3d(x[, 1:3])
zm = seq(1, 0.045, length = 200)
par3d(zoom = 1)
for (i in 1:length(zm)) {
    par3d(zoom = zm[i])
    rgl.snapshot(paste(formatC(i, width = 3, flag = 0), ".png", 
        sep = ""))
    Sys.sleep(0.01)
} 
