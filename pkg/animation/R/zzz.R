.First.lib <- function(lib, pkg) {
    options(demo.ask = FALSE)
    cat("animation: Demonstrate Animations in Statistics (Version ", 
        packageDescription("animation", fields = "Version"), 
        ")\nSee http://animation.yihui.name for online examples;\n", 
        "Install the latest version under development from R-Forge:\n   install.packages(\"animation\", repos = \"http://r-forge.r-project.org\")\n", sep = "")
}
