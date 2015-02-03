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
