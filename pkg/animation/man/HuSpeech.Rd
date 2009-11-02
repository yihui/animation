\name{HuSpeech}
\alias{HuSpeech}
\docType{data}
\title{
Word Counts of a Speech by Chinese President Hu
}
\description{
On Dec 18, 2008, Chinese President Hu gave a speech on the 30th anniversary of China's economic reform in 1978, and this data has recorded the number of words used in each paragraph of his speech.
}
\usage{data(HuSpeech)}
\format{
  The format is:
 int [1:75] 119 175 222 204 276 168 257 89 61 288 ...
}
\source{
The full text of speech: \url{http://cpc.people.com.cn/GB/64093/64094/8544901.html}
}
\examples{
data(HuSpeech)
# clear pattern: 1/3 short, 1/3 long, 1/3 short again
plot(HuSpeech, type = "b", pch = 20, xlab = "paragraph index", 
    ylab = "word count")
# see ?moving.block for an animation example
}
\keyword{datasets}
