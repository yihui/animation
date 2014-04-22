\name{flip.coin}
\alias{flip.coin}
\title{Probability in flipping coins}
\usage{
flip.coin(faces = 2, prob = NULL, border = "white", grid = "white",
  col = 1:2, type = "p", pch = 21, bg = "transparent", digits = 3)
}
\arguments{
  \item{faces}{an integer or a character vector. See
  details below.}

  \item{prob}{the probability vector of showing each face.
  If \code{NULL}, each face will be shown in the same
  probability.}

  \item{border}{The border style for the rectangles which
  stand for probabilities.}

  \item{grid}{the color for horizontal grid lines in these
  rectangles}

  \item{col}{The colors to annotate different faces of the
  `coin'.}

  \item{type,pch,bg}{See \code{\link{points}}.}

  \item{digits}{integer indicating the precision to be used
  in the annotation of frequencies in the plot}
}
\value{
A list containing \item{freq}{A vector of frequencies
(simulated probabilities)} \item{nmax}{the total number of
tosses}
}
\description{
This function provides a simulation to the process of
flipping coins and computes the frequencies for `heads' and
`tails'.
}
\details{
If \code{faces} is a single integer, say 2, a sequence of
integers from 1 to \code{faces} will be used to denote the
faces of a coin; otherwise this character vector just gives
the names of each face.

When the \eqn{i}-th face shows up, a colored thin rectangle
will be added to the corresponding place (the \eqn{i}-th
bar), and there will be corresponding annotations for the
number of tosses and frequencies.

The special argument \code{grid} is for consideration of a
too large number of flipping, in which case if you still
draw horizontal lines in these rectangles, the rectangles
will be completely covered by these lines, thus we should
specify it as \code{NA}.

At last the frequency for each face will be computed and
shown in the header of the plot -- this shall be close to
\code{prob} if \code{ani.options('nmax')} is large enough.
}
\note{
You may change the colors of each face using the argument
\code{col} (repeated if shorter than the number of faces).
}
\examples{
oopt = ani.options(interval = 0.2, nmax = ifelse(interactive(), 100, 2))
## a coin would stand on the table?? just kidding :)
flip.coin(faces = c('Head', 'Stand', 'Tail'), type = 'n',
          prob = c(0.45, 0.1, 0.45), col =c(1, 2, 4))

flip.coin(bg = 'yellow')

## HTML animation page
saveHTML({
  ani.options(interval = 0.2, nmax = ifelse(interactive(), 100, 2))
  par(mar = c(2, 3, 2, 1.5), mgp = c(1.5, 0.5, 0))
  flip.coin(faces = c('Head', 'Stand', 'Tail'), type = 'n',
            prob = c(0.45, 0.1, 0.45), col =c(1, 2, 4))
}, img.name = 'flip.coin', htmlfile='flip.coin.html',
         ani.height = 500, ani.width = 600, title = 'Probability in flipping coins',
         description = c('This animation has provided a simulation of flipping coins',
                         'which might be helpful in understanding the concept of probability.'))

ani.options(oopt)
}
\author{
Yihui Xie
}
\references{
\url{http://vis.supstat.com/2013/03/simulation-of-coin-flipping}
}
\seealso{
\code{\link{points}}, \code{\link{sample}}
}

