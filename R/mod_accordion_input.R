#' accordion_input
#'
#' Create an accordion component with collapsible content and input element
#' as the title.
#'
#' @param id a unique ID for the component
#' @param title a title for the card
#' @param text content to be placed inside the collapsible section
#'
#' @importFrom shiny NS tags
#' @importFrom rheroicons outline
#' @noRd
accordion_input <- function(id, title, text) {
    ns <- NS(id)
    tags$div(
        id = ns("card-group"),
        class = "card side-effects input-card",
        tags$input(
            type = "checkbox",
            class = "checkboxes",
            id = ns("checkbox")
        ),
        tags$label(
            `for` = ns("checkbox"),
            id = ns("checkbox-label"),
            class = "card-label",
            rheroicons::outline$check_circle(aria_hidden = TRUE),
            title
        ),
        tags$button(
            class = "action-button shiny-bound-input card-toggle",
            id = ns("toggle"),
            `aria-controls` = ns("content"),
            `aria-expanded` = "false",
            rheroicons::outline$chevron_down()
        ),
        tags$section(
            id = ns("content"),
            class = "card-content",
            role = "region",
            `aria-labelledby` = ns("checkbox-label"),
            tags$p(text)
        )
    )
}


#' Reset Card Input
#'
#' Reset the accordion card input to it's default state
#'
#' @param inputId ID of the component to reset
#'
#' @noRd
reset_accordion_input <- function(id) {
    session$sendCustomMessage(
        type = id,
        message = ""
    )
}