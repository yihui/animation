\name{creativity}
\Rdversion{1.1}
\alias{creativity}
\docType{data}
\title{
Creativity scores of writing according to extrinsic and intrinsic rewards.
}
\description{
Each row is a data for a single subject. Variables are creativity score and a code for the treatment group (1: extrinsic, 2: intrinsic) 
}
\usage{data(creativity)}
\format{
  A data frame with 47 observations on the following 2 variables.
  \describe{
    \item{\code{score}}{a numeric vector: creativity scores}
    \item{\code{code}}{a factor with levels \code{extrinsic} and \code{intrinsic}}
  }
}
\details{

}
\source{
\url{http://www.public.iastate.edu/~pdixon/stat500/datasets.html}
}
\references{

}
\examples{
data(creativity)

## perform t-test
t.test(score ~ code, data = creativity)

## a horizontal boxplot
boxplot(score ~ code, creativity, col = c("blue", 
    "red"), horizontal = TRUE)
with(creativity, {
    # boxplot is only a rough summary, so we do not actually know where
    #    are the original data points, so we add short ticks in the bottom 
    #    and top axis to denote original values
    rug(score[code == "extrinsic"], side = 1, col = "blue")
    rug(score[code == "intrinsic"], side = 3, col = "red")
}) 

## alternatively, we can use strip chart
stripchart(score ~ code, creativity, at = c(1.25, 
    1.75), las = 1) 
# why at = c(1.25, 1.75)? without this, our plot will be almost blank!
#    we ajusted the position of the strips so that users can compare
#    the two batches of data more easily

## density curves for the two groups
with(creativity, {
    plot(density(score[code == "intrinsic"]), col = "red", lwd = 2, 
        xlim = range(score), main = "", xlab = "score")
    lines(density(score[code == "extrinsic"]), col = "blue", 
        lwd = 2, lty = 2)
    legend("topleft", legend = levels(code), col = c("blue", 
        "red"), lwd = 2, lty = 2:1, bty = "n")
    # mark out the average values for two groups by two points
    points(tapply(score, code, mean), rep(0, 2), col = c("blue", "red"), 
        pch = 19)
    # we can see the average values on the top axis
    axis(side = 3, round(tapply(score, code, mean), 2))
    # we can clearly see the bimodal distribution for the intrinsic group
    #    so ask yourself, is normal distribution appropriate?
}) 

## a permutation test is actually very easy in R
# the code below needs a little bit knowledge about matrix multiplication
#    as we have expressed the difference in terms of the product of 
#    two vectors as x' * c where c consists of 1 and -1
# finally we return the p-value directly
with(creativity, {
    idx = rep(c(-1, 1), table(code))
    mean(replicate(5000, t(score) \%*\% sample(idx)) >= as.vector(t(score) \%*\% 
        idx))
}) 
# the p-value is around 0.0025
}
\keyword{datasets}
