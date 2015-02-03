#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
katexR <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'katexR',
    x,
    width = width,
    height = height,
    package = 'katexR'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
katexROutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'katexR', width, height, package = 'katexR')
}

#' Widget render function for use in Shiny
#'
#' @export
renderKatexR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, katexROutput, env, quoted = TRUE)
}
