## brownian motion: note the 'loop' option in ani.opts and the careful settings in documentclass

saveLatex({
  par(mar = c(3, 3, 1, 0.5), mgp = c(2, 0.5, 0),
      tcl = -0.3, cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
  brownian.motion(pch = 21, cex = 5, col = 'red', bg = 'yellow',
                  main = 'Demonstration of Brownian Motion')
}, img.name = 'BM', ani.opts = 'controls,loop,width=0.95\\textwidth',
          latex.filename = ifelse(interactive(), 'brownian_motion.tex', ''),
          interval = 0.1, nmax = 10,
          ani.dev = 'pdf', ani.type = 'pdf', ani.width = 7, ani.height = 7,
          documentclass = paste('\\documentclass{article}',
                                '\\usepackage[papersize={7in,7in},margin=0.3in]{geometry}', sep = '\n'))

## the PDF graphics output is often too large because it is uncompressed; try the option ani.options('pdftk') or ani.options('qpdf') to compress the PDF graphics; see ?pdftk or ?qpdf and ?ani.options
