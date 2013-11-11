#' A wrapper for the PDF toolkit Pdftk
#'
#' If the toolkit Pdftk is available in the system, it will be called to
#' manipulate the PDF files (especially to compress the PDF files).
#'
#' This is a wrapper to call \command{pdftk}. The path of \command{pdftk} should
#' be set via \code{\link{ani.options}(pdftk = 'path/to/pdftk')}.
#'
#' See the reference for detailed usage of \command{pdftk}.
#' @param input the path of the input PDF file(s)
#' @param operation the operation to be done on the input (default to be
#'   \code{NULL})
#' @param output the path of the output (if missing and \code{input} is a
#'   scalar, \code{output} will be the same as \code{input})
#' @param other.opts other options (default to be \code{'compress dont_ask'},
#'   i.e. compress the PDF files and do not ask the user for any input)
#' @return if \code{ani.options('pdftk')} is non-\code{NULL}, then this function
#'   returns the status of the operation (\code{0} for success; see
#'   \code{\link{system}}); otherwise a warning will be issued
#' @author Yihui Xie
#' @references \url{http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/}
#' @export
#' @example inst/examples/pdftk-ex.R
pdftk = function(input, operation = NULL, output, other.opts = 'compress dont_ask') {
  if (!is.null(pdftk.path <- ani.options('pdftk'))) {
    ## already 'shQuote()'ed?
    if (!grepl('^["\']', pdftk.path)) pdftk.path = shQuote(pdftk.path)
    auto.output = missing(output) && length(input) == 1 && file.exists(input)
    if (auto.output)
      output = file.path(dirname(input), paste('output', basename(input), sep = '-'))
    cmd = paste(pdftk.path, paste(input, collapse = ' '),
                operation, sprintf('output %s', output), other.opts)
    message('* Pdftk is running... \n* ', cmd)
    status = system(cmd)
    message(ifelse(status == 0, '* done!', '* failed (***)'))
    if (auto.output && file.exists(output))
      file.rename(
        output, file.path(dirname(output), sub('^output-', '', basename(output)))
      )
    status
  } else warning('the path of pdftk was not specified!')
}
