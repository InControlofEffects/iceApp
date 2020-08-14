#' medication_card UI Function
#'
#' @description A shiny Module.
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param title name of the medication
#' @param type define card type (avoid or suggested)
#' @importFrom shiny NS tagList tags
#' @noRd
mod_medication_card_ui <- function(id, title = "", type = "recommended") {
    ns <- NS(id)

    # define elements
    parent <- tags$div(id = ns("result"), class = "card card-medication")
    title <- tags$p(id = ns("result-title"), class = "card-label", title)

    # if type == suggested
    if (type == "recommended") {
        parent$attribs$class <- paste0(
            parent$attribs$class,
            " card-recommended"
        )
        parent$children <- tagList(
            title,
            rheroicons::icons$check_circle(type = "solid", aria_hidden = TRUE)
        )
    }

    # if type == avoid
    if (type == "avoid") {
        parent$attribs$class <- paste0(
            parent$attribs$class,
            " card-avoid"
        )
        parent$children <- tagList(
            title,
            rheroicons::icons$exclamation(type = "solid", aria_hidden = TRUE)
        )
    }

    # return
    return(parent)

}