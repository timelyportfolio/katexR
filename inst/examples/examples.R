library(katexR)
library(htmltools)
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
