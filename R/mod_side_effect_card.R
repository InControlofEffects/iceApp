#' side_effect_card UI Function
#'
#' @description A shiny Module.
#' @param id,input,output,session Internal parameters for {shiny}.
#' @importFrom shiny NS tagList
#' @noRd
mod_side_effect_card_ui <- function(id, title, text) {
  ns <- NS(id)
  tags$div(
        id = ns("sideeffect"),
        class = "card side-effects",
        tags$label(
            class = "card-input",
            tags$input(
                type = "checkbox",
                class = "checkboxes",
                id = ns("checked")
            ),
            tags$span(title)
        ),
        tags$button(
            class = "action-button shiny-bound-input card-toggle",
            id = ns("toggle"),
            `aria-expanded` = "false",
            rheroicons::outline$chevron_down()
        ),
        tags$section(
            id = ns("content"),
            class = "card-content",
            `aria-hidden` = "true",
            tags$p(text)
        )
    )
}
    
#' side_effect_card Server Function
#'
#' @noRd
mod_side_effect_card_server <- function(input, output, session) {

    # parse module ID
    ns <- session$ns
    id <- gsub(
        pattern = "-<environment>",
        replacement = "",
        x = ns(input)[[1]]
    )

    # toggle classes when checkbox selected
    observeEvent(input$checked, {
        if (input$checked) {
            browsertools::add_css(
                elem = paste0("#", id, "-sideeffect"),
                css = "selected"
            )
        } else {
            browsertools::remove_css(
                elem = paste0("#", id, "-sideeffect"),
                css = "selected"
            )
        }
    })

    # toggle expandable content
    observeEvent(input$toggle, {
        browsertools::toggle_css(
            elem = paste0("#", id, "-toggle"),
            css = "rotated"
        )
        browsertools::toggle_elem(
            elem = paste0("#", id, "-content"),
            css = "expanded"
        )
    })
}