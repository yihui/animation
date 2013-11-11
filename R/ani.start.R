#' Generate an HTML animation page
#'
#' These functions are defunct and should not be used any more.
#' @param ... arguments passed to \code{\link{ani.options}} to set animation
#'   parameters
#' @keywords internal
#' @export
ani.start = function(...) {
  .Defunct(msg = 'This function is defunct. Use animation::saveHTML() instead.')
}
#' @rdname ani.start
#' @export
ani.stop = ani.start
