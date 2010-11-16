`g.brownian.motion` <-
function(p = 20, start = 1900, 
    digits = 14, file = "brownian.motion.html", width = 800, 
    height = 600) {
    n = ani.options("nmax")
    x = round(c(t(apply(matrix(rnorm(p * n), p, n), 1, cumsum))), 
        digits)
    y = round(c(t(apply(matrix(rnorm(p * n), p, n), 1, cumsum))), 
        digits)
    tmp = character(p * n * 4)
    tmp[seq(1, p * n * 4, 4)] = shQuote(formatC(rep(1:p, n), 
        width = nchar(p), flag = 0))
    tmp[seq(2, p * n * 4, 4)] = rep(start + (1:n), each = p)
    tmp[seq(3, p * n * 4, 4)] = x
    tmp[seq(4, p * n * 4, 4)] = y
    cat(c("<html>", "  <head>", "    <script type=\"text/javascript\" src=\"http://www.google.com/jsapi\"></script>", 
        "    <script type=\"text/javascript\">", "      google.load(\"visualization\", \"1\", {packages:[\"motionchart\"]});", 
        "      google.setOnLoadCallback(drawChart);", "      function drawChart() {", 
        "        var data = new google.visualization.DataTable();"), 
        paste("        data.addRows(", p * n, ");", sep = ""), 
        c("        data.addColumn('string', 'point');", "        data.addColumn('number', 'year');", 
            "        data.addColumn('number', 'X');", "        data.addColumn('number', 'Y');"), 
        paste("        data.setValue(", rep(0:(p * n - 1), each = 4), 
            ", ", rep(0:3, p * n), ", ", tmp, ");", sep = "", 
            collapse = "\n"), c("        var chart = new google.visualization.MotionChart(document.getElementById('chart_div'));"), 
        paste("        chart.draw(data, {width: ", width, ", height: ", 
            height, "});\", \"      }", sep = ""), c("    </script>", 
            "  </head>", "", "  <body>"), paste("    <div id=\"chart_div\" style=\"width: ", 
            width, "px; height: ", height, "px;\"></div>", sep = ""), 
        c("  </body>", "</html>"), file = file, sep = "\n")
    browseURL(file.path(getwd(), file))
}

