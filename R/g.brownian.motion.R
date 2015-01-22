#' Brownian Motion using Google Visualization API
#'
#' We can use R to generate random numbers from the Normal distribution and
#' write them into an HTML document, then the Google Visualization gadget
#' ``motionchart'' will prepare the animation for us (a Flash animation with
#' several buttons).
#' @param p number of points
#' @param start start ``year''; it has no practical meaning in this animation
#'   but it's the required by the Google gadget
#' @param digits the precision to round the numbers
#' @param file the HTML filename
#' @param width,height width and height of the animation
#' @return \code{NULL}. An HTML page will be opened as the side effect.
#' @note The number of frames is controlled by \code{ani.options('nmax')} as
#'   usual.
#'
#'   Due to the ``security settings'' of Adobe Flash player, you might not be
#'   able to view the generated Flash animation locally, i.e. using an address
#'   like \samp{file:///C:/Temp/index.html}. In this case, you can upload the
#'   HTML file to a web server and use the http address to view the Flash file.
#' @author Yihui Xie
#' @seealso \code{\link{brownian.motion}}, \code{\link{BM.circle}},
#'   \code{\link{rnorm}}
#' @references \url{http://code.google.com/apis/visualization/} and
#'   \url{http://bit.ly/12w1sYi}
#' @export
#' @examples
#' g.brownian.motion(15, digits = 2, width = 600, height = 500, file = 'BM-motion-chart.html')
g.brownian.motion = function(
  p = 20, start = 1900, digits = 14, file = 'index.html', width = 800, height = 600
) {
  n = ani.options('nmax')
  x = round(c(t(apply(matrix(rnorm(p * n), p, n), 1, cumsum))), digits)
  y = round(c(t(apply(matrix(rnorm(p * n), p, n), 1, cumsum))), digits)
  tmp = character(p * n * 4)
  tmp[seq(1, p * n * 4, 4)] = shQuote(formatC(rep(1:p, n), width = nchar(p), flag = 0))
  tmp[seq(2, p * n * 4, 4)] = rep(start + (1:n), each = p)
  tmp[seq(3, p * n * 4, 4)] = x
  tmp[seq(4, p * n * 4, 4)] = y
  cat(
    c(
      '<html>', '  <head>', '    <script type=\"text/javascript\" src=\"http://www.google.com/jsapi\"></script>',
      '    <script type=\"text/javascript\">', '      google.load(\"visualization\", \"1\", {packages:[\"motionchart\"]});',
      '      google.setOnLoadCallback(drawChart);', '      function drawChart() {',
      '        var data = new google.visualization.DataTable();'
      ),
    paste('        data.addRows(', p * n, ');', sep = ''),
    c(
      "        data.addColumn('string', 'point');", "        data.addColumn('number', 'year');",
      "        data.addColumn('number', 'X');", "        data.addColumn('number', 'Y');"
      ),
    paste(
      '        data.setValue(', rep(0:(p * n - 1), each = 4), ', ', rep(0:3, p * n),
      ', ', tmp, ');', sep = '', collapse = '\n'
      ),
    c("        var chart = new google.visualization.MotionChart(document.getElementById('chart_div'));"),
    paste('        chart.draw(data, {width: ', width, ', height: ', height, '});\n      }', sep = ''),
    c('    </script>', '  </head>', '', '  <body>'),
    paste(
      '    <div id=\"chart_div\" style=\"width: ', width, 'px; height: ',height, 'px;\"></div>', sep = ''
      ),
    c('  </body>', '</html>'),
    file = file, sep = '\n'
    )
  if (ani.options('autobrowse'))
    browseURL(paste('file:///', normalizePath(file), sep = ''))
}

