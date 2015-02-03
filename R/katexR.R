#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
katexR <- function(
  katex = ""
  , tag = "div"
  , style = NULL
  , width = NULL
  , height = NULL
) {

  # send katex 
  x = list(
    katex = katex
    ,tag = tag
    ,style = style
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'katexR',
    x,
    width = width,
    height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(
      knitr.figure = FALSE
      ,knitr.defaultWidth = "auto"
      ,knitr.defaultHeight = "auto"
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
  htmltools::tag(tagType, list(id = id, style = style, class = class,"") )
}