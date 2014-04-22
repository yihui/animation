#' Insert animations into an HTML page, AngularJS version
#'
#' This function first records all the plots in the R expression as bitmap
#' images, then inserts them into an HTML page and finally creates the animation
#' using a template that uses AngularJS and Twitter Bootstrap. You will need to
#' be connected to the internet as the page gets these things from remove servers.
#'
#' Two sliders are displayed, one sets the frame and the other controls the speed.
#' A drop-down control sets the looping mode.
#' 
#' @param expr an R expression to be evaluated to create a sequence of images
#' @param img.name the filename of the images (the real output will be like
#'   \file{img.name1.png}, \file{img.name2.png}, ...); this name has to be
#'   different for different animations, since it will be used as the
#'   identifiers for each animation; make it as unique as possible; meanwhile,
#'   the following characters in \code{img.name} will be replaced by \code{_} to
#'   make it a legal jQuery string:
#'
#'   \verb{!"#$\%&'()*+,./:;?@@[\]^`{|}~}
#' @param title HTML page title
#' @param htmlfile the filename of the HTML file
#' @param pause Time in milliseconds between frames
#' @param endPause Time between restarting when in Loop-pause mode
#' @param loopmode Either "One-shot", "Loop", or "Loop-pause" to describe
#'   what to do at the end of a frame sequence. "Loop-pause" pauses for
#'   an extra period so the end is clear. This is similar to rainfall radar
#'   sequences often seen on weather forecasts.
#' @param overwrite Whether to stomp on an existing HTML file
#' @param description Some HTML to place in a container DIV after the animation.
#'   You would typically want to make paragraphs with P tags.
#' @param ... other arguments to be passed to \code{\link{ani.options}} to
#'   animation options such as the time interval between image frames
#' @return The path of the HTML output.
#' @note When you want to publish the HTML page on the web, you only have  to upload the
#'   the HTML file and 
#'   the images.
#'
#'   This was loosely based on code from the choroplethr package but has been
#'   extensively rewritten by Barry Rowlingson
#'
#' @author Yihui Xie, Barry Rowlingson
#' @family utilities
#' @export
saveHTML2 = function(
    expr, img.name = 'Rplot',
    title = "Animation Playr",
    htmlfile = 'index.html',
    pause = 1000,
    endPause = 2000,
    loopmode = c("One-shot","Loop","Loop-pause"),
    overwrite = FALSE,
    description,
    ...
) {
  oopt = ani.options(...)
  loopmode = match.arg(loopmode)
  
  if(file.exists(htmlfile) && !overwrite){
      stop("Won't overwrite html unless overwrite=TRUE")
  }

  pause = round(pause) # ms
  endPause = round(endPause) # ms
  maxPause = max(c(2000,2 * pause))

  pause = maxPause - pause
  
  ## replace special chars first: http://api.jquery.com/category/selectors/
  spec.chars = strsplit("!\"#$%&'()*+,./:;?@[\\]^`{|}~", '')[[1]]
  img.name0 = strsplit(img.name, '')[[1]]
  img.name0[img.name0 %in% spec.chars] = '_'
  img.name0 = paste(img.name0, collapse = '')

  ani.type = ani.options('ani.type')
  ani.dev = ani.options('ani.dev')
  if (is.character(ani.dev)) ani.dev = get(ani.dev)
  imgdir = ani.options('imgdir')
  dir.create(imgdir, showWarnings = FALSE, recursive = TRUE)

  img.fmt = file.path(imgdir, paste(img.name, '%d', '.', ani.type, sep = ''))
  ani.options(img.fmt = img.fmt)

  ## clear out existing images that match the pattern
  imgs = list.files(imgdir, pattern = paste(img.name, '[0-9]+\\.', ani.type, sep = ''),
      full.names=TRUE)
  file.remove(imgs)

  if ((use.dev <- ani.options('use.dev')))
    ani.dev(img.fmt, width = ani.options('ani.width'), height = ani.options('ani.height'))
  eval(expr)
  if (use.dev) dev.off()

  ## how many frames generated?
  imglen = length(list.files(imgdir, pattern = paste(img.name, '[0-9]+\\.', ani.type, sep = '')))
  
  src = system.file("misc","anganimator","template.html", package="animation")
  template = paste0(readLines(src),collapse="\n")

  if(missing(description)){
      description = ""
  }else{
      description = .simpleTemplate('<div class="container">[[description]]</div>', list(description=description))
  }
  
  context = list(
      title=title,
      nframes = imglen,
      description = description,
      pauseTime = pause,
      endPauseTime = endPause,
      maxPause = maxPause,
      loopmode = loopmode,
      imgstub = file.path(imgdir, img.name)
      )
  page = .simpleTemplate(template, context)
  
  cat(page, file=htmlfile)
  
  if (ani.options('autobrowse'))
    browseURL(paste('file:///', normalizePath(htmlfile), sep = ''))
  ani.options(oopt)
  message('HTML file created at: ', htmlfile)
  invisible(htmlfile)
}

.simpleTemplate <- function(template, context){
    ## replace [[foo]] in template string with context[[foo]] for all foo in names(context)
    ## eg:
    ## > t="[[what]] [[thing]] is [[what]]"
    ## > .simpleTemplate(t, list(thing="frog",what="fat"))
    ## [1] "fat frog is fat"
    ##
    for(n in names(context)){
        template = gsub(paste0("[[",n,"]]",sep=""), context[[n]], template,fixed=TRUE)
    }
    return(template)
}
    
