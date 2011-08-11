pdf('huge-plot.pdf')
plot(rnorm(50000))
dev.off()

## Windows
ani.options(qpdf = 'D:/Installer/qpdf/bin/qpdf.exe')
qpdf('huge-plot.pdf', output = 'huge-plot0.pdf')

## Linux
ani.options(qpdf = 'qpdf')
qpdf('huge-plot.pdf', output = 'huge-plot1.pdf')

ani.options(qpdf = NULL)

file.info(c('huge-plot.pdf', 'huge-plot0.pdf', 'huge-plot1.pdf'))['size']

