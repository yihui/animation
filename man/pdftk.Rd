\name{pdftk}
\alias{pdftk}
\title{A wrapper for the PDF toolkit Pdftk}
\usage{
pdftk(input, operation = NULL, output, other.opts = "compress dont_ask")
}
\arguments{
  \item{input}{the path of the input PDF file(s)}

  \item{operation}{the operation to be done on the input
  (default to be \code{NULL})}

  \item{output}{the path of the output (if missing and
  \code{input} is a scalar, \code{output} will be the same
  as \code{input})}

  \item{other.opts}{other options (default to be
  \code{'compress dont_ask'}, i.e. compress the PDF files
  and do not ask the user for any input)}
}
\value{
if \code{ani.options('pdftk')} is non-\code{NULL}, then
this function returns the status of the operation (\code{0}
for success; see \code{\link{system}}); otherwise a warning
will be issued
}
\description{
If the toolkit Pdftk is available in the system, it will be
called to manipulate the PDF files (especially to compress
the PDF files).
}
\details{
This is a wrapper to call \command{pdftk}. The path of
\command{pdftk} should be set via
\code{\link{ani.options}(pdftk = 'path/to/pdftk')}.

See the reference for detailed usage of \command{pdftk}.
}
\examples{
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

}
\author{
Yihui Xie
}
\references{
\url{http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/}
}

