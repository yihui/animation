#!/usr/bin/env Rscript

## deal with LyX filename mangling
x = readLines('animation-jss.tex')
idx = grep('\\\\documentclass', x)
if (idx > 1) x = x[-(1:(idx-1))]
idx = grep('\\\\bibliography|\\\\includegraphics', x)
x[idx] = sub('\\{.*animation_inst_doc_', '{', x[idx])
idx = grep('\\\\includegraphics', x)
x[idx] = sub('\\{figure_', '{figure/', x[idx])
idx = grep('\\\\animategraphics', x)
x[idx] = sub('\\{[^\\}]*animation/inst/doc/', '{', x[idx])
writeLines(x, 'animation-jss.tex')
file.rename('animation-jss.tex', 'animation-jss.Rnw')
## now we can cheat Sweave :-)
