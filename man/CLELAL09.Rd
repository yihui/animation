\docType{data}
\name{CLELAL09}
\alias{CLELAL09}
\title{The NBA game between CLE Cavaliers and LAL Lakers on Dec 25, 2009}
\format{A data frame with 455 observations on the following 7 variables.
  \describe{ \item{\code{player}}{a character vector: the current player}
  \item{\code{time}}{a character vector: the time} \item{\code{period}}{a
  numeric vector: the period (1 - 4)} \item{\code{realx}}{a numeric vector:
  the x-axis location} \item{\code{realy}}{a numeric vector: the y-axis
  location} \item{\code{result}}{a factor with levels \code{made} and
  \code{missed}} \item{\code{team}}{a factor with levels \code{CLE},
  \code{LAL} and \code{OFF}} }}
\source{
\url{http://www.basketballgeek.com/data/} (transformed
based on the original data)
}
\description{
Cleveland Cavaliers played against Los Angeles Lakers at
Staples Center in LA on Dec 25, 2009 and won the game by
102:87. This data recorded the locations of players on the
court and the results of the shots.
}
\note{
We view the court with CLE in the left and LAL in the
right: \code{realx} is the distance to the left border of
CLE's court, and \code{realy} is the distance to the bottom
border of the court; notice that the size of the court is
\eqn{94 \times 50}{94 x 50} (feet).
}
\examples{
## see demo('CLEvsLAL', package = 'animation') for a `replay' of the game
}

