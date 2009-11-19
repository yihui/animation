\name{ISU.Stat500-package}
\Rdversion{1.1}
\alias{ISU.Stat500-package}
\alias{ISU.Stat500}
\docType{package}
\title{
Misc Functions and Data Sets for the Course Stat500 in the Department of Statistics, Iowa State University
}
\description{
This package is written to support the course Stat500 (Statistical Methods) in the Department of Statistics, Iowa State University. Included are functions for the permutation test, bootstrapping, computing the sample size based on CI width/s.e./power, data transformation for equal variance in t-test and ANOVA, model diagnostics (e.g. normality), inference for contrasts, various demos for linear regressions; all the data sets used in the class are (hopefully) to be included in this package.
}
\details{
\tabular{ll}{
Package: \tab ISU.Stat500\cr
Type: \tab Package\cr
Version: \tab 0.1-0\cr
Date: \tab 2009-11-25\cr
License: \tab GPL-2 | GPL-3\cr
LazyLoad: \tab yes\cr
}


}
\author{
Hui Lin, Tengfei Yin and Yihui Xie

Maintainer: Hui Lin <hlin@iastate.edu>

}
\references{

}

\keyword{ package }
\seealso{

}
\examples{
data(creativity)
t.test(score ~ code, data = creativity)
}
