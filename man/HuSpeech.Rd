\docType{data}
\name{HuSpeech}
\alias{HuSpeech}
\title{Word counts of a speech by the Chinese President Hu}
\format{int [1:75] 119 175 222 204 276 168 257 89 61 288 ...}
\source{
The full text of speech is at
\url{http://cpc.people.com.cn/GB/64093/64094/8544901.html}
}
\description{
This speech came on the 30th anniversary of China's
economic reform in 1978.
}
\details{
On Dec 18, 2008, Chinese President Hu gave a speech on the
30th anniversary of China's economic reform in 1978, and
this data has recorded the number of words used in each
paragraph of his speech.
}
\examples{
## clear pattern: 1/3 short, 1/3 long, 1/3 short again
plot(HuSpeech, type = 'b', pch = 20, xlab = 'paragraph index',
    ylab = 'word count')
## see ?moving.block for an animation example
}

