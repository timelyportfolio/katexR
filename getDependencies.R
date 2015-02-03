# get katex js and css

library(pipeR)

tf = tempfile()
download.file("https://github.com/Khan/KaTeX/releases/download/v0.1.1/katex.zip",tf)
unzip(tf,exdir = "./inst/htmlwidgets/lib")
