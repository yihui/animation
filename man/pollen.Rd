\docType{data}
\name{pollen}
\alias{pollen}
\title{Synthetic dataset about the geometric features of pollen grains}
\format{A data frame with 3848 observations on the following 5 variables.
  \describe{ \item{RIDGE}{a numeric vector} \item{NUB}{a numeric vector}
  \item{CRACK}{a numeric vector} \item{WEIGHT}{a numeric vector}
  \item{DENSITY}{a numeric vector} }}
\source{
collected from Statlib Datasets Archive:
\url{http://stat.cmu.edu/datasets/}
}
\description{
There are 3848 observations on 5 variables. From the 1986
ASA Data Exposition dataset, made up by David Coleman of
RCA Labs
}
\examples{
## some dense points in the center?
plot(pollen[, 1:2], pch = 20, col = rgb(0, 0, 0, 0.1))

## see demo('pollen', package = 'animation') for a 3D demo; truth is there!
}

