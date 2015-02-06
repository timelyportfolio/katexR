library(katexR)
library(htmltools)
library(rvest)
library(XML)
library(pipeR)

tagList(
  tags$p( id = "katex-one" )
  ,tags$script( "
      katex.render('\\\\frac{1}{n} \\\\sum_{i=i}^{n} x_{i}',document.getElementById('katex-one'))
  " )
  ,katex("\\frac{1}{n} \\sum_{i=i}^{n} x_{i}")
) %>>% html_print


# another set of tests
rnwText = readLines("https://raw.githubusercontent.com/saluteyang/LaTeXPage_Rstats/master/EDA_Energy.Rnw")

rnwText %>>%
  (grep(x=.,pattern = "(?<=\\$\\$)(.*?)(?=\\$\\$)", perl=T, value = T )) %>>%
  (gsub(x=.,pattern = "(\\$\\$)", replacement="", perl=T)) %>>%
  (tagList(
    tags$h1(
      "katexR tests with this "
      ,tags$a("Rnw paper", href="https://github.com/saluteyang/LaTeXPage_Rstats/blob/master/EDA_Energy.Rnw")
    )
    ,lapply(
      .
      ,function(f){
        tags$div(
          tags$pre(f)
          ,katex(f)
        )
      }
    )
  )) %>>%
  html_print


# borrow some tests from KaTeX

paste0(
  readLines("https://raw.githubusercontent.com/Khan/KaTeX/master/test/katex-spec.js")
  ,collapse="\n"
) -> katex_tests

# my regex is horrible
katex_tests %>>%
  (
    list(
      begin = gregexpr(
        text = .
        ,pattern = "(?<=good)(.{0,20}) =(.*)\\["
        ,perl = T
      )
      ,end = gregexpr(
        text = .
        ,pattern = "(\\];(.*)\\n)"
        ,perl = T
      )
    )
  ) -> positions

# get the arrays with good tests
sort(c(positions$begin[[1]],positions$end[[1]])) %>>%
  (
    .[which(.%in%positions$begin[[1]]) + 1]
  ) %>>%
  (
    sapply(
      1:length(.)
      ,function(n){
        substr(katex_tests,positions$begin[[1]][n],.[n])
      }
    )
  ) %>>%
  (gsub(x=.,pattern="(.*\\=)",replacement="")) %>>%
  (lapply(.,jsonlite::fromJSON)) %>>%
  unlist %>>%
  (tagList(
    lapply(
      .
      ,function(f){
        tags$div(
          tags$pre(f, style = "background-color:lightgray;")
          ,katex(
            f
            , style="line-height:300%;text-align:center;font-size:200%;"
            , tag="p" )
        )
      }
    )
  )) %>>%
  html_print


# use http://en.wikibooks.org/wiki/LaTeX/Mathematics
wK <- "http://en.wikibooks.org/wiki/LaTeX/Mathematics" %>>%
  html

wK %>>%
  html_nodes("table .source-latex,code") %>>%
  html_text %>>%
  (
    tagList(
      lapply(
        .
        ,function(f){
          tags$div(
            tags$pre(f)
            ,katex(f)
          )
        }
      )
    )
  ) %>>%
  html_print


# borrow some tests from Mathjax
#  most of these  are not working but a good start
"http://cdn.mathjax.org/mathjax/latest/test/sample.html" %>>%
  html -> mj
 
mj %>>%
  html_nodes( "p" ) %>>%
  (xmlApply(
    .[1:7]  # 8 is an inline so will skip
    ,function(p){
      gsub(
        x= xmlValue(p)
        ,pattern = "\\n\\\\(begin|end)*(\\{align\\})\\n"
        ,replacement = ""
      ) %>>%
      (gsub(
        x = .
        ,pattern = "\\&"
        ,replacement = ""
      )) %>>%
      (gsub(
        x=.
        ,pattern = "(\\\\)(\\[)|\\]"
        ,replacement = ""
      )) %>>%
      (gsub(
        x=.
        ,pattern = "(\\\\)(\\s?)"
        ,replacement = ""
      ))  %>>%
      (gsub(
        x=.
        ,pattern = "((left)|(right)|(dot)|(sigma)|(sum)|(leq)|(\\!)|(frac)|(times)|(partial)|(sqrt)|(choose))"
        ,replacement = "\\\\\\1"
      ))  %>>%
      strsplit("\\\\\\\\\n") %>>%
      unlist %>>%
      (tags$div(
        lapply(.,function(f){as.tags(katex(f))})
      )) %>>%
      html_print
    }
  ))
  