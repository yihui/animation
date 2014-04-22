\name{qpdf}
\alias{qpdf}
\title{A wrapper for the PDF toolkit qpdf}
\usage{
qpdf(input, output, options = "--stream-data=compress")
}
\arguments{
  \item{input}{the path of the input PDF file}

  \item{output}{the path of the output (if missing,
  \code{output} will be the same as \code{input})}

  \item{options}{options for \command{qpdf} (default to be
  \code{'--stream-data=compress'}, i.e. compress the PDF
  files)}
}
\value{
if \code{ani.options('qpdf')} is non-\code{NULL}, then this
function returns the status of the operation (\code{0} for
success; see \code{\link{system}}); otherwise a warning
will be issued
}
\description{
If the tool qpdf is available in the system, it will be
called to manipulate the PDF files (especially to compress
the PDF files).
}
\details{
This is a wrapper to call \command{qpdf}. The path of
\command{qpdf} should be set via
\code{\link{ani.options}(qpdf = 'path/to/qpdf')}.

See the reference for detailed usage of \command{qpdf}.
}
\examples{
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

}
\author{
Yihui Xie
}
\references{
\url{http://qpdf.sourceforge.net/}
}

