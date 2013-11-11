#' A wrapper for the PDF toolkit qpdf
#'
#' If the tool qpdf is available in the system, it will be called to manipulate
#' the PDF files (especially to compress the PDF files).
#'
#' This is a wrapper to call \command{qpdf}. The path of \command{qpdf} should
#' be set via \code{\link{ani.options}(qpdf = 'path/to/qpdf')}.
#'
#' See the reference for detailed usage of \command{qpdf}.
#' @param input the path of the input PDF file
#' @param output the path of the output (if missing, \code{output} will be the
#'   same as \code{input})
#' @param options options for \command{qpdf} (default to be
#'   \code{'--stream-data=compress'}, i.e. compress the PDF files)
#' @return if \code{ani.options('qpdf')} is non-\code{NULL}, then this function
#'   returns the status of the operation (\code{0} for success; see
#'   \code{\link{system}}); otherwise a warning will be issued
#' @author Yihui Xie
#' @references \url{http://qpdf.sourceforge.net/}
#' @export
#' @example inst/examples/qpdf-ex.R
qpdf = function(input, output, options = '--stream-data=compress') {
  if (!is.null(qpdf.path <- ani.options('qpdf'))) {
    ## already 'shQuote()'ed?
    if (!grepl('^["\']', qpdf.path)) qpdf.path = shQuote(qpdf.path)
    auto.output = missing(output) && file.exists(input)
    if (auto.output)
      output = file.path(dirname(input), paste('output', basename(input), sep = '-'))
    cmd = paste(qpdf.path, options, input, output)
    message('* qpdf is running... \n* ', cmd)
    status = system(cmd)
    message(ifelse(status == 0, '* done!', '* failed (***)'))
    if (auto.output && file.exists(output))
      file.rename(output,
                  file.path(dirname(output), sub('^output-', '', basename(output))))
    status
  } else warning('the path of qpdf was not specified!')
}
