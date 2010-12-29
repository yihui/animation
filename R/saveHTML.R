##' Insert animations into an HTML page.
##' This function first records all the plots in the R expression as bitmap
##' images, then inserts them into an HTML page and finally create the animation
##' using the SciAnimator library.
##'
##' This is a much better version than \code{ani.start} and \code{ani.stop},
##' and all users are encouraged to try this function when creating HTML
##' animation pages. It mainly uses the SciAnimator library, which is based
##' on jQuery. It has a neat interface (both technically and visually) and is
##' much easier to use or extend. Moreover, this function allows multiple
##' animations in a single HTML page -- just use the same filename for the
##' HTML page (specified in \code{ani.options('htmlfile')}).
##'
##' Optionally the source code and some session information can be added
##' below the animations for the sake of reproducibility (specified by the
##' option \code{ani.options('verbose')} -- if \code{TRUE}, the description,
##' loaded packages, the code to produce the animation, as well as a part
##' of \code{sessionInfo()} will be written in the bottom of the animation;
##' the R code will be highlighted using the SyntaxHighlighter library for
##' better reading experience).
##'
##' @param expr an R expresion to be evaluated to create a sequence of images
##' @param img.name the filename of the images (the real output will be like
##' \file{img.name1.png}, \file{img.name2.png}, ...); this name has to be
##' different for different animations, since it will be used as the identifiers
##' for each animation; make it as unique as possible
##' @param global.opts a string: the global options of the animation; e.g. we
##' can specify the default theme to be blue using
##' \verb{$.fn.scianimator.defaults.theme = 'blue';}
##' note these options must be legal JavaScript expressions (ended by \code{';'})
##' @param single.opts the options for each single animation (if there are
##' multiple ones in one HTML page), e.g. \verb{'utf8': false, 'theme': 'dark'}
##' see the reference for a complete list of available options
##' @param ... other arguments to be passed to \code{\link{ani.options}} to
##' animation options such as the time interval between image frames
##' @return the path of the output
##' @note Microsoft IE might restrict the HTML page from running JavaScript
##' and try to ``protect your security'' when you view the animation page.
##' If this happens, you have two choices: (1) abandon the well-known fragile
##' IE and try some really secure web browsers such as Firefox (or anything but
##' IE); or (2) tell IE that you allow the blocked content.
##'
##' When you want to publish the HTML page on the web, you have to make sure
##' to upload the associated \file{css} and \file{js} folders with the HTML file.
##' @author Yihui Xie <\url{http://yihui.name}>
##' @references \url{https://github.com/brentertz/scianimator}
##' @seealso \code{\link{ani.start}}, \code{\link{ani.stop}} (early versions of
##' HTML animations)
##' @example animation/inst/examples/saveHTML-ex.R
saveHTML = function(expr, img.name = 'Rplot',
                    global.opts = '', single.opts = '', ...) {
    oopt = ani.options(...)

    ## escape special chars first: http://api.jquery.com/category/selectors/
    spec.chars = strsplit("!\"#$%&'()*+,./:;?@[\\]^`{|}~", '')[[1]]
    img.name0 = strsplit(img.name, '')[[1]]
    spec.name = img.name0 %in% spec.chars
    if (any(spec.name)) img.name0[spec.name] = paste('\\\\', img.name0[spec.name], sep = '')
    img.name0 = paste(img.name0, collapse = '')

    ## deparse the expression and form the verbose description
    .dexpr = NULL
    if (isTRUE(ani.options('verbose'))) {
        info = sessionInfo()
        .dexpr = deparse(substitute(expr))
        if (length(.dexpr) >=3 && .dexpr[1] == '{' && tail(.dexpr, 1) == '}') {
            .dexpr = sub('^[ ]{4}', '', .dexpr[-c(1, length(.dexpr))])
        }
        .dexpr = append(.dexpr, c(strwrap(paste(ani.options('description'),
                                                collapse = ' '),
                        width = ani.options('ani.width')/8, exdent = 2,
                        prefix = '## '),
                               sprintf('library(%s)', names(info$otherPkgs))), 0)
        ## append sessionInfo()
        .dexpr = append(.dexpr, paste('##', c(R.version.string,
                                      paste('Platform:', info$platform),
                 strwrap(paste('Other packages:',
                               paste(sapply(info$otherPkgs, function(x)
                        paste(x$Package, x$Version)), collapse = ', '))))))
        .dexpr = paste('	<div class="scianimator" style="width: ',
                       ani.options('ani.width'), 'px;"><pre class="brush: r">',
                       paste(.dexpr, collapse = '\n'), '</pre></div>', sep = '')
    }

    ani.type = ani.options('ani.type')
    ani.dev = ani.options('ani.dev')
    if (is.character(ani.dev)) ani.dev = get(ani.dev)
    imgdir = file.path(ani.options('outdir'), ani.options('imgdir'))
    dir.create(imgdir, showWarnings = FALSE, recursive = TRUE)
    ani.dev(file.path(imgdir, paste(img.name, '%d', '.', ani.type, sep = '')),
            width = ani.options('ani.width'), height = ani.options('ani.height'))
    expr
    dev.off()

    htmlfile = file.path(ani.options('outdir'), ani.options('htmlfile'))
    file.copy(system.file('misc', 'scianimator', c('js', 'css'),
                          package = 'animation'), dirname(htmlfile),
              recursive = TRUE)
    unlink(file.path(dirname(htmlfile), 'js', 'template.js'))
    ## try to append to the HTML file if it exists
    html = if (file.exists(htmlfile)) {
        readLines(htmlfile)
    } else {
        readLines(system.file('misc', 'scianimator', 'index.html',
                              package = 'animation'))
    }
    html = sub('<title>.*</title>', sprintf('<title>%s</title>',
                                         ani.options('title')), html)
    html = sub('<meta name="generator" content=".*">',
              sprintf('<meta name="generator" content="R package animation %s">',
                      packageVersion('animation')), html)
    n = grep('<!-- highlight R code -->', html, fixed = TRUE)
    div.str = sprintf('	<div id="%s"></div>', img.name)
    js.str = sprintf('	<script src="js/%s.js"></script>', img.name)
    ## make sure there are no duplicate div/scripts
    if (!length(div.pos <- grep(div.str, html, fixed = TRUE)) &
        !length(js.pos <- grep(js.str, html, fixed = TRUE))) {
        html = append(html, c(div.str, .dexpr, js.str), n - 1)
    } else {
        if (js.pos - div.pos > 1) {
            ## remove the old session info
            html = html[-seq(div.pos + 1, js.pos - 1)]
            html = append(html, .dexpr, div.pos)
        }
    }
    js.temp = readLines(system.file('misc', 'scianimator', 'js', 'template.js',
                              package = 'animation'))
    if (!ani.options('autoplay')) js.temp = js.temp[-11]
    js.temp = paste(js.temp, collapse = '\n')
    imglen = length(list.files(imgdir, pattern = paste(img.name, '[0-9]+\\.', ani.type, sep = '')))
    imglist = file.path(ani.options('imgdir'), sprintf(paste(img.name, '%d.', ani.type, sep = ''), seq_len(imglen)))
    js.temp = sprintf(js.temp, global.opts, img.name0,
                      paste(shQuote(imglist, 'sh'), collapse = ', '),
                      ani.options('ani.height'), ani.options('ani.width'),
                      1000 * ani.options('interval'),
                      ifelse(ani.options('loop'), 'loop', 'none'),
                      ifelse(nzchar(single.opts), paste(',\n', single.opts), ''),
                      img.name0
    )
    writeLines(js.temp, file.path(dirname(htmlfile), 'js', paste(img.name, 'js', sep = '.')))
    writeLines(html, con = htmlfile)

    if (ani.options('autobrowse'))
        browseURL(paste('file:///', normalizePath(htmlfile), sep = ''))
    ani.options(oopt)
    message('HTML file created at: ', htmlfile)
    invisible(htmlfile)
}
