#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_side_effect_card.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-27
#' PURPOSE: side effects card component + server module
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' define ui component
mod_side_effect_ui <- function(id, title, text) {
  ns <- NS(id)
  tags$div(
        id = ns("sideEffects"),
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
mod_se_server <- function(input, output, session) {

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
                elem = paste0("#", id, "-sideEffects"),
                css = "selected"
            )
        } else {
            browsertools::remove_css(
                elem = paste0("#", id, "-sideEffects"),
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