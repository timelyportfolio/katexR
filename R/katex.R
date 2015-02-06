#' render function for KaTeX in R
#'
#' @param tex String containing the formula to be parsed and rendered
#' @param tag String for the type of html tag to use. \code{tag = "div"} is the default.
#' @param inline Logical to use \code{\\displaystyle}.  Default is \code{FALSE}.
#'          Change to \code{TRUE} if you would like your formula to be included inline.
#'          See \href{https://github.com/Khan/KaTeX/issues/66}{this issue} for more details.
#' @param style String with the style attributes, such as \code{style = "font-size:20px;text-align:center;"}.
#' Note, the behavior of \code{katexR} is different from standard \code{htmlwidgets}, and \code{height}
#' and \code{width} parameters will not work.
#' 
#' @examples
#' \dontrun{
#' # a simple mean formula
#' katex("\\frac{1}{n} \\sum_{i=i}^{n} x_{i}")
#' 
#' # to illustrate use with a different tag and some styling
#' katex(
#'  "\\frac{1}{n} \\sum_{i=i}^{n} x_{i}"
#'  ,tag = "p"
#'  ,style = "color:blue; font-size:300%; text-align:center;"
#' )
#' 
#' # katex plays nicely with htmltools
#' library(htmltools)
#' 
#' html_print(tagList(
#'  tags$div(
#'    tags$pre( "\\frac{1}{n} \\sum_{i=i}^{n} x_{i}" )
#'    , katex( "\\frac{1}{n} \\sum_{i=i}^{n} x_{i}", tag="span" )
#'  )
#' ))
#' 
#' # or if you want to customize your KaTeX experience
#' #   use katex to just get the required dependencies
#' html_print(tagList(
#'   tags$p( id = "katex-one" )
#'   ,tags$script( "
#'      katex.render('\\\\frac{1}{n} \\\\sum_{i=i}^{n} x_{i}',document.getElementById('katex-one'))
#'   ")
#'   ,katex() # empty means just use for js/css dependencies
#' ))
#' 
#'
#' }
#' 
#' @import htmlwidgets
#'
#' @export
katex <- function(
  tex = ""
  , tag = "div"
  , inline = FALSE
  , style = NULL
) {

  # send katex 
  x = list(
    tex = tex
    ,tag = tag
    ,inline = inline
    ,style = style
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'katexR',
    x,
    sizingPolicy = htmlwidgets::sizingPolicy(
      knitr.figure = FALSE
      ,defaultWidth = "auto"
      ,defaultHeight = "auto"
    ),
    package = 'katexR'
  )
}


as.tags <- function(x, ...){
  UseMethod("as.tags")
}

#' Define custom as.tags function for katexR
#' @method as.tags katexR
#' @export as.tags.katexR
as.tags.katexR <- function(x, standalone = FALSE) {
  toHTML_katexR(x, standalone = standalone)
}

#' Define custom toHTML to pass tag type for katexR 
toHTML_katexR <- function(x, standalone = FALSE, knitrOptions = NULL) {
  
  if (!is.null(x$elementId))
    id <- x$elementId
  else
    id <- paste("htmlwidget", as.integer(stats::runif(1, 1, 10000)), sep="-")
  
  x$id <- id
  

  html <- htmltools::tagList(
    htmlwidgets:::widget_html(
      name = class(x)[1],
      package = attr(x, "package"),
      id = id,
      style = x$x$style,
      class = class(x)[1],
      tagType = x$x$tag
    ),
    htmlwidgets:::widget_data(x, id)
  )
  html <- htmltools::attachDependencies(
    html
    , c(
      htmlwidgets:::widget_dependencies(class(x)[1], attr(x, 'package'))
      , x$dependencies
    )
  )
  
  htmltools::browsable(html)
}

#' Define custom html function for katexR
katexR_html <- function( id, style, class, tagType = "div", ... ){
  htmltools::tag(tagType, list(id = id, style = style, class = class, "") )
}





#' @export

katexR <- function( ... ) {
  # defunct this in favor of easier to type katex
  .Defunct("katex", msg = "katexR is defunct. Please use katex since way easier to type.")
}