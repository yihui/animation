\docType{data}
\name{ObamaSpeech}
\alias{ObamaSpeech}
\title{Word counts of a speech by the US President Obama}
\format{int [1:59] 2 45 52 53 11 48 28 15 50 29 ...}
\source{
The full text of speech is at
\url{http://www.baltimoresun.com/news/nation-world/bal-text1105,0,5055673,full.story}
}
\description{
This data recorded the number of words in each paragraph of
Barack Obama's speech in Chicago after winning the
presidential election.
}
\examples{
## pattern: longer paragraph and shorter paragraph
plot(ObamaSpeech, type = 'b', pch = 20, xlab = 'paragraph index',
    ylab = 'word count')
}

