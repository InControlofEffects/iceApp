#' app_page UI Function
#'
#' @description A shiny Module.
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param class css classname to attach this this component
#' @importFrom shiny NS tags
#' @noRd
mod_app_page_ui <- function(id, class = NULL, html) {
    ns <- NS(id)
    a <- tags$article(id = ns("page"), class = "page", html)
    if (!is.null(class)) {
        a$attribs$class <- paste0(a$attribs$class, " ", class)
    }
    return(a)
}

## To be copied in the UI
# mod_app_page_ui("app_page_ui_1")