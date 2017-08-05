#' An animated map for vector data
#' This project is just at its very beginning!
#'
#' @param	viewpoint 	Text. Following the pattern "$projection=$x,$y,$z".
#' @param	mode		Currently only two values: "air" or "ocean".
#' @param	fn		filename. 
#' @param   width		Width of the display area of the widget.
#' @param   height	Height of the display area of the widget.
#' @param	elementId	Name of the widget.
#' @import htmlwidgets
#' @export

Rearth <- function(viewpoint="", mode="air", fn, 
		width = NULL, height = NULL, elementId = NULL) {

  widget_path <- system.file("htmlwidgets", package="Rearth")
  Fname <- paste(normalizePath(widget_path),"_visualization_.json",sep="\\data\\")
  URL_path = "lib/index-1.0.0/earth_index.html#current/"

  if (mode == "air") {
    URL_path = paste(URL_path, "wind/surface/level/", sep="")
  } else {
    URL_path = paste(URL_path, "ocean/surface/currents/", sep="")
  }

  URL_path = paste(URL_path, viewpoint, sep="")
 
  fok <- file.copy(from=fn, to=Fname, overwrite = TRUE)

  if (fok) {
	# print(URL_path)
  } else {
	stop("Failed to get the data file.")
  }

  # forward options using x
  x = list(
    viewpoint = URL_path,
    fname = Fname
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'Rearth',
    x,
    width = width,
    height = height,
    package = 'Rearth',
    elementId = elementId
  )

}


#' Shiny bindings for Rearth
#'
#' Output and render functions for using Rearth within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a Rearth
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name Rearth-shiny
#'
#' @export

RearthOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'Rearth', width, height, package = 'Rearth')
}

#' @rdname Rearth-shiny
#' @export

renderRearth <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, RearthOutput, env, quoted = TRUE)
}
