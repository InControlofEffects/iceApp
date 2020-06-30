#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_side_effect_card.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-30
#' PURPOSE: side effects card component + server module
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' mode_side_effect_ui
#' Create an accordion component with collapsible content
#' @param id a unique ID for the component
#' @param title a title for the card
#' @param text content to be placed inside the collapsible section
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
    
#' mod_se_server
#' @param input required shiny object
#' @param output required shiny object
#' @param session required shiny object
#' @param session_db an R6 object used for sending data to the db
mod_se_server <- function(input, output, session, session_db) {

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

            # add selected css class
            browsertools::add_css(
                elem = paste0("#", id, "-sideEffects"),
                css = "selected"
            )

            # log selection
            session_db$capture_action(
                event = "side_effect_selection",
                id = id,
                desc = "user selected side effect"
            )

        } else {

            # remove selected css class
            browsertools::remove_css(
                elem = paste0("#", id, "-sideEffects"),
                css = "selected"
            )

            # log removal
            session_db$capture_action(
                event = "side_effect_selection",
                id = id,
                desc = "user deselected side effect"
            )
        }
    })

    # toggle expandable content
    observeEvent(input$toggle, {

        # toggle rotate class for toggle icon
        browsertools::toggle_css(
            elem = paste0("#", id, "-toggle"),
            css = "rotated"
        )

        # toggle class that reveals/hides content
        browsertools::toggle_elem(
            elem = paste0("#", id, "-content"),
            css = "expanded"
        )

        # log toggle
        session_db$capture_action(
            event = "side_effect_definition",
            id  = id,
            desc = "user toggled definition"
        )

    })
}