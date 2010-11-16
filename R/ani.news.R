`ani.news` <-
function(...){
    newsfile <- file.path(system.file(package = "animation"), 
        "NEWS")
    file.show(newsfile,...)
}

