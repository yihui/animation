pdf('huge-plot.pdf')
plot(rnorm(50000))
dev.off()

## Windows
ani.options(pdftk = 'D:/Installer/pdftk.exe')
pdftk('huge-plot.pdf', output = 'huge-plot0.pdf')

## Linux (does not work??)
ani.options(pdftk = 'pdftk')
pdftk('huge-plot.pdf', output = 'huge-plot1.pdf')

ani.options(pdftk = NULL)

file.info(c('huge-plot.pdf', 'huge-plot0.pdf', 'huge-plot1.pdf'))['size']

