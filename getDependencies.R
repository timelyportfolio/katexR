# get katex js and css

library(pipeR)

tf = tempfile()
download.file("https://github.com/Khan/KaTeX/releases/download/v0.1.1/katex.zip",tf)
unzip(tf,exdir = "./inst/htmlwidgets/lib")


# add delete woff2 from css and delete woff2 files
readLines(
  "inst/htmlwidgets/lib/katex/katex.min.css"
) %>>%
  (
    gsub(
      x = .
      ,pattern = "(url)\\(fonts/[a-zA-Z0-9-_]*\\.woff2\\)\\s?(format\\('woff2'\\),)"   #*/[a-z][A-Z\\-_]*#\\.woff2\\)"#[\\s]format\\('woff2'\\),"
      ,perl = T
      ,replacement = ""
    )
  ) %>>%
  (
    cat(., file="inst/htmlwidgets/lib/katex/katex_nowoff2.min.css")
  )
  