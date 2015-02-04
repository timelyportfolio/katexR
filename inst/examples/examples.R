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
  ,katexR("\\frac{1}{n} \\sum_{i=i}^{n} x_{i}")
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
          ,katexR(f)
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
        katexR(f,style="line-height:300%;text-align:center;", tag="p" )
      }
    )
  )) %>>%
  html_print


# borrow some tests from Mathjax
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
      strsplit("\\\\\\\\\n") %>>%
      unlist %>>%
      (tags$div(
        lapply(.,katexR)
      )) %>>%
      html_print
    }
  ))
  