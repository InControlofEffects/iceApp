
#' Optional Arguments as Attributes
#'
#' This function provides
#'
#' @param ... optional arguments
#' 
#' @noRd
as_html_attributes <- function(...) list(...)[names(list(...)) != ""]