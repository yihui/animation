#' Insert animations into a LaTeX document and compile it
#'
#' Record animation frames and insert them into a LaTeX document with the
#' \code{animate} package. Compile the document if an appropriate LaTeX command
#' is provided.
#'
#' This is actually a wrapper to generate a LaTeX document using R. The document
#' uses the LaTeX package called \code{animate} to insert animations into PDF's.
#' When we pass an R expression to this function, the expression will be
#' evaluated and recorded by a grahpics device (typically \code{\link{png}} and
#' \code{\link{pdf}}). At last, a LaTeX document will be created and compiled if
#' an appropriate LaTeX command is provided. And the final PDF output will be
#' opened with the PDF viewer set in \code{getOption('pdfviewer')} if
#' \code{ani.options('autobrowse') == TRUE}.
#' @param expr an expression to generate animations; use either the animation
#'   functions (e.g. \code{brownian.motion()}) in this package or a custom
#'   expression (e.g. \code{for(i in 1:10) plot(runif(10), ylim = 0:1)}).
#' @param nmax maximum number of animation frames (if missing and the graphics
#'   device is a bitmap device, this number will be automatically calculated);
#'   note that we do not have to specify \code{nmax} when using PDF devices.
#' @param img.name basename of file names of animation frames; see the Note
#'   section for a possible adjustment on \code{img.name}
#' @param ani.opts options to control the behavior of the animation (passed to
#'   the LaTeX macro \code{'\\animategraphics'}; default to be
#'   \code{'controls,width=\\linewidth'})
#' @param centering logical: whether to center the graph using the LaTeX
#'   environment \verb{\begin{center}} and \verb{\end{center}}
#' @param caption,label caption and label for the graphics in the figure
#'   environment
#' @param pkg.opts global options for the \code{animate} package
#' @param documentclass LaTeX document class; if \code{NULL}, the output will
#'   not be a complete LaTeX document (only the code to generate the PDF
#'   animation will be printed in the console); default to be \code{article},
#'   but we can also provide a complete statement like
#'   \verb{\\documentclass[a5paper]{article}}
#' @param latex.filename file name of the LaTeX document; if an empty string
#'   \code{''}, the LaTeX code will be printed in the console and hence not
#'   compiled
#' @param pdflatex the command for pdfLaTeX (set to \code{NULL} to ignore the
#'   compiling)
#' @param install.animate copy the LaTeX style files \file{animate.sty} and
#'   \file{animfp.sty}? If you have not installed the LaTeX package
#'   \code{animate}, it suffices just to copy these to files.
#' @param overwrite whether to overwrite the existing image frames
#' @param full.path whether to use the full path (\code{TRUE}) or relative path
#'   (\code{FALSE}) for the animation frames; usually the relative path
#'   suffices, but sometimes the images and the LaTeX document might not be in
#'   the same directory, so \code{full.path = TRUE} could be useful; in the
#'   latter case, remember that you should never use spaces in the filenames or
#'   paths!
#' @param ... other arguments passed to the graphics device
#'   \code{ani.options('ani.dev')}, e.g. \code{ani.height} and \code{ani.width}
#'
#' @return Invisible \code{NULL}
#' @note This function will detect if it was called in a Sweave environment --
#'   if so, \code{img.name} will be automatically adjusted to
#'   \code{prefix.string-label}, and the LaTeX output will not be a complete
#'   document, but rather a single line like
#'   \preformatted{\animategraphics[ani.opts]{1/interval}{img.name}{}{}}
#'
#'   This automatic feature can be useful to Sweave users (but remember to set
#'   the Sweave option \code{results=tex}). See \code{demo('Sweave_animation')}
#'   for a complete example.
#'
#'   PDF devices are recommended because of their high quality and usually they
#'   are more friendly to LaTeX, but the size of PDF files is often much larger;
#'   in this case, we may set the option \code{'qpdf'} or \code{'pdftk'} to
#'   compress the PDF graphics output. To set the PDF device, use
#'   \code{ani.options(ani.dev = 'pdf', ani.type = 'pdf')}
#'
#'   So far animations created by the LaTeX package \pkg{animate} can only be
#'   viewed with Acrobat Reader (Windows) or \command{acroread} (Linux).  Other
#'   PDF viewers may not support JavaScript (in fact the PDF animation is driven
#'   by JavaScript). Linux users may need to install \command{acroread} and set
#'   \code{options(pdfviewer = 'acroread')}.
#' @author Yihui Xie
#' @family utilities
#' @references To know more about the \code{animate} package, please refer to
#'   \url{http://www.ctan.org/tex-archive/macros/latex/contrib/animate/}. There
#'   are a lot of options can be set in \code{ani.opts} and \code{pkg.opts}.
#' @export
#' @example inst/examples/saveLatex-ex.R
saveLatex = function(
  expr, nmax, img.name = 'Rplot', ani.opts, centering = TRUE, caption = NULL,
  label = NULL, pkg.opts = NULL, documentclass = 'article', latex.filename = 'animation.tex',
  pdflatex = 'pdflatex', install.animate = TRUE, overwrite = TRUE, full.path = FALSE, ...
) {
  oopt = ani.options(...)
  if (!missing(nmax)) ani.options(nmax = nmax)
  on.exit(ani.options(oopt))
  file.ext = ani.options('ani.type')
  use.dev = ani.options('use.dev')
  ## detect if I'm in a Sweave environment
  in.sweave = FALSE
  if ((n.parents <- length(sys.parents())) >= 3) {
    for (i in seq_len(n.parents) - 1) {
      if ('chunkopts' %in% ls(envir = sys.frame(i))) {
        chunkopts = get('chunkopts', envir = sys.frame(i))
        if (all(c('prefix.string', 'label') %in% names(chunkopts))) {
          ## yes, I'm in Sweave w.p. 95%
          img.name = paste(chunkopts$prefix.string, chunkopts$label, sep = '-')
          ani.options(img.fmt = paste(img.name, '%d.', file.ext, sep = ''))
          in.sweave = TRUE
          break
        }
      }
    }
  }

  interval = ani.options('interval')
  ## generate the image frames
  ani.dev = ani.options('ani.dev')
  num = ifelse(file.ext == 'pdf' && use.dev, '', '%d')
  img.fmt = sprintf('%s%s.%s', img.name, num, file.ext)
  if (!in.sweave)
    ani.options(img.fmt = img.fmt)
  if (is.character(ani.dev))
    ani.dev = get(ani.dev)
  ani.files.len = length(
    list.files(path = dirname(img.name), pattern =
                 sprintf('^%s[0-9]*\\.%s$', basename(img.name), file.ext))
  )
  if (overwrite || !ani.files.len) {
    if (use.dev)
      ani.dev(img.fmt, width = ani.options('ani.width'), height = ani.options('ani.height'))
    expr
    if (use.dev) dev.off()
    ## compress PDF files
    if (file.ext == 'pdf') compress_pdf(img.name)
  }
  ani.files.len = length(
    list.files(path = dirname(img.name), pattern = sprintf('^%s[0-9]*\\.%s$', basename(img.name), file.ext))
  )

  if (missing(nmax)) {
    ## count the number of images generated
    start.num = ifelse(file.ext == 'pdf' && use.dev, '', 1)
    end.num = ifelse(file.ext == 'pdf' && use.dev, '', ani.files.len)
  } else {
    ## PDF animations should start from 0 to nmax-1
    start.num = ifelse(file.ext == 'pdf' && use.dev, 0, 1)
    end.num = ifelse(file.ext == 'pdf' && use.dev, nmax - 1, nmax)
  }

  if (missing(ani.opts)) ani.opts = 'controls,width=\\linewidth'

  if (install.animate && !in.sweave && length(documentclass)) {
    file.copy(system.file('misc', 'animate', 'animate.sty', package = 'animation'),
              'animate.sty', overwrite = TRUE)
    file.copy(system.file('misc', 'animate', 'animfp.sty', package = 'animation'),
              'animfp.sty', overwrite = TRUE)
  }

  if (!in.sweave && length(documentclass)) {
    if (img.name == sub('\\.tex$', '', latex.filename))
      stop("'img.name' should not be the same with 'latex.filename'!")
    if (!grepl('^\\\\documentclass', documentclass))
      documentclass = sprintf('\\documentclass{%s}', documentclass)
    cat(sprintf(
      '%s
                \\usepackage%s{animate}
                \\begin{document}
                \\begin{figure}
                %s
                \\animategraphics[%s]{%s}{%s}{%s}{%s}%s%s
                %s
                \\end{figure}
                \\end{document}
                ', documentclass,
      ifelse(is.null(pkg.opts), '', sprintf('[%s]', pkg.opts)),
      ifelse(centering, '\\begin{center}', ''),
      ani.opts,
      1/interval,
      ifelse(full.path, gsub('\\\\', '/', normalizePath(img.name)), img.name),
      start.num, end.num,
      ifelse(is.null(caption), '', sprintf('\\caption{%s}', caption)),
      ifelse(is.null(label), '', sprintf('\\label{%s}', label)),
      ifelse(centering, '\\end{center}', '')),
        '\n', file = latex.filename
    )
    if ((latex.filename != '') & !is.null(pdflatex)) {
      message('LaTeX document created at: ', file.path(getwd(), latex.filename))
      if (system(sprintf('%s %s', pdflatex, latex.filename)) == 0) {
        message(sprintf('successfully compiled: %s %s', pdflatex, latex.filename))
        if (ani.options('autobrowse'))
          system(
            sprintf('%s %s', shQuote(normalizePath(getOption('pdfviewer'))),
                    sprintf('%s.pdf', sub('([^.]+)\\.[[:alnum:]]+$', '\\1', latex.filename)))
          )
      }
      else {
        message('An error occurred while compiling the LaTeX document; \nyou should probably take a look at the log file: ',
                sprintf('%s.log', sub('([^.]+)\\.[[:alnum:]]+$',
                                      '\\1', latex.filename)), ' under ', getwd())
        if (Sys.info()['sysname'] == 'Darwin')
          message("Mac OS users may also consider saveLatex(..., pdflatex = '/usr/texbin/pdflatex') if pdflatex is not in your PATH variable.")
      }
    }
  } else {
    cat(sprintf(
      '%s
                \\animategraphics[%s]{%s}{%s}{%s}{%s}
                %s
                ',
      ifelse(centering, '\\begin{center}', ''),
      ani.opts,
      1/interval,
      ifelse(full.path, gsub('\\\\', '/', normalizePath(img.name)), img.name),
      start.num, end.num,
      ifelse(centering, '\\end{center}', ''))
    )
  }
  invisible(NULL)
}
